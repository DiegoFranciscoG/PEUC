"""Extracts the official UCuenca 2026 question bank from its published PDF.

The PDF has a very regular layout that is exploited here instead of OCR:
  * question number  -> bold, ~10.5 pt, left margin (x < 80)
  * stem             -> regular, ~11.2 pt, x ~ 86-91
  * option start     -> bold, ~11.2 pt, text "a) ...", x ~ 86
  * option wrap line -> regular, x ~ 105
  * images           -> image blocks placed between those lines
Header (page 1) and footer ("Página N de 1148") lines are skipped.

Every question is returned as a list of content blocks (text or image) so the
app can render images inline, in the same order as the official document.
"""
from __future__ import annotations

import hashlib
import io
import re
from dataclasses import dataclass, field
from pathlib import Path

import pymupdf
from PIL import Image

OPTION_RE = re.compile(r"^([a-h])\)\s*(.*)$")
FOOTER_RE = re.compile(r"Página\s+\d+\s+de\s+\d+")
NUMBER_X_MAX = 80.0
OPTION_X_MAX = 100.0
# A line whose right edge ends before this x is treated as a hard line break.
HARD_BREAK_X = 470.0


@dataclass
class Block:
    """A piece of content: either text or an image reference."""

    text: str | None = None
    image: str | None = None
    # Size (PDF points) at which the picture is shown in the official document.
    width: float | None = None
    height: float | None = None

    def to_dict(self) -> dict:
        if self.text is not None:
            return {"t": self.text}
        data = {"img": self.image}
        if self.width and self.height:
            data.update(w=round(self.width, 1), h=round(self.height, 1))
        return data


@dataclass
class Option:
    label: str
    blocks: list[Block] = field(default_factory=list)


@dataclass
class Question:
    number: int
    page: int
    stem: list[Block] = field(default_factory=list)
    options: list[Option] = field(default_factory=list)


class _TextAccumulator:
    """Joins wrapped PDF lines into paragraphs, keeping real line breaks."""

    def __init__(self, blocks: list[Block]):
        self._blocks = blocks
        self._last_x1: float | None = None

    def add_line(self, text: str, x1: float) -> None:
        text = text.strip()
        if not text:
            return
        last = self._blocks[-1] if self._blocks else None
        if last is not None and last.text is not None:
            wrapped = self._last_x1 is not None and self._last_x1 >= HARD_BREAK_X
            if wrapped and last.text.endswith("-") and not last.text.endswith(" -"):
                last.text = last.text + text
            elif wrapped:
                last.text = f"{last.text} {text}"
            else:
                last.text = f"{last.text}\n{text}"
        else:
            self._blocks.append(Block(text=text))
        self._last_x1 = x1

    def add_image(self, name: str, width: float | None = None, height: float | None = None) -> None:
        self._blocks.append(Block(image=name, width=width, height=height))
        self._last_x1 = None


class ImageStore:
    """Converts extracted images to WebP and de-duplicates them by content hash."""

    def __init__(self, out_dir: Path | None):
        self.out_dir = out_dir
        self._by_hash: dict[str, str] = {}
        self.raw: dict[str, bytes] = {}
        if out_dir is not None:
            out_dir.mkdir(parents=True, exist_ok=True)

    def save(self, raw: bytes, ext: str) -> str:
        digest = hashlib.sha256(raw).hexdigest()[:16]
        if digest in self._by_hash:
            return self._by_hash[digest]
        name = f"{digest}.webp"
        self.raw[name] = raw
        if self.out_dir is not None:
            img = Image.open(io.BytesIO(raw))
            if img.mode not in ("RGB", "RGBA", "L", "LA"):
                img = img.convert("RGBA")
            lossless = ext.lower() == "png"
            img.save(self.out_dir / name, "WEBP", lossless=lossless, quality=82, method=6)
        self._by_hash[digest] = name
        return name

    @property
    def count(self) -> int:
        return len(self._by_hash)


_SUP_FROM = "0123456789+-=()abcdefghijklmnoprstuvwxyzABDEGHIJKLMNOPRTUW"
_SUP_TO = "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁᵂ"
_SUB_FROM = "0123456789+-=()aehijklmnoprstuvx"
_SUB_TO = "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ"
SUPERSCRIPT = str.maketrans(_SUP_FROM, _SUP_TO)
SUBSCRIPT = str.maketrans(_SUB_FROM, _SUB_TO)
_SUP_OK = set(_SUP_FROM)
_SUB_OK = set(_SUB_FROM)


def _script(text: str, table: dict, allowed: set, fallback: str) -> str:
    core = text.strip()
    if not core:
        return text
    converted = core.translate(table) if set(core) <= allowed else f"{fallback}({core})"
    return text.replace(core, converted)


def _line_text(line: dict) -> str:
    """Joins the spans of a line, turning raised/lowered small spans into
    Unicode super/subscripts (x2 -> x², H2O -> H₂O, x-1 -> x⁻¹)."""
    spans = line["spans"]
    base = max(spans, key=lambda s: s["size"])
    parts = []
    for span in spans:
        text = span["text"]
        smaller = span["size"] < base["size"] * 0.85
        if span["flags"] & 1 and smaller:
            text = _script(text, SUPERSCRIPT, _SUP_OK, "^")
        elif smaller and span["origin"][1] > base["origin"][1] + 1:
            text = _script(text, SUBSCRIPT, _SUB_OK, "_")
        parts.append(text)
    return "".join(parts)


def _is_bold(line: dict) -> bool:
    return "Bold" in line["spans"][0]["font"]


def _size(line: dict) -> float:
    return round(line["spans"][0]["size"], 1)


def iter_items(doc: pymupdf.Document):
    """Yields ('line', page, line_dict) and ('image', page, block_dict) in reading order.

    Lines are ordered by baseline (the question number and its stem use different
    font sizes, so their top edges differ but their baselines match). Images are
    ordered by their vertical centre, which places an option image after its
    "a)" label even when both start at the same top edge.
    """
    for page in doc:
        data = page.get_text("dict")
        items = []
        for block in data["blocks"]:
            if block["type"] == 1:
                y0, y1 = block["bbox"][1], block["bbox"][3]
                items.append(((y0 + y1) / 2, block["bbox"][0], "image", block))
            else:
                for line in block["lines"]:
                    baseline = line["spans"][0]["origin"][1]
                    items.append((baseline, line["bbox"][0], "line", line))
        for _, _, kind, obj in _reading_order(items):
            yield kind, page.number, obj


def _reading_order(items: list[tuple], row_tolerance: float = 4.0) -> list[tuple]:
    """Sorts top-to-bottom; items whose y differs by less than the tolerance form
    one visual row and are then ordered left-to-right (number before stem)."""
    items = sorted(items, key=lambda it: it[0])
    ordered: list[tuple] = []
    row: list[tuple] = []
    for item in items:
        if row and item[0] - row[0][0] > row_tolerance:
            ordered.extend(sorted(row, key=lambda it: it[1]))
            row = []
        row.append(item)
    ordered.extend(sorted(row, key=lambda it: it[1]))
    return ordered


def extract(pdf_path: Path, image_dir: Path | None = None) -> tuple[list[Question], ImageStore]:
    doc = pymupdf.open(pdf_path)
    store = ImageStore(image_dir)
    questions: list[Question] = []
    current: Question | None = None
    acc: _TextAccumulator | None = None

    for kind, page_no, obj in iter_items(doc):
        if kind == "image":
            if current is None:
                continue  # cover page artwork
            name = store.save(obj["image"], obj.get("ext", "png"))
            x0, y0, x1, y1 = obj["bbox"]
            acc.add_image(name, x1 - x0, y1 - y0)
            continue

        text = _line_text(obj).strip()
        if not text or FOOTER_RE.search(text) or _size(obj) >= 15:
            continue
        x0, x1 = obj["bbox"][0], obj["bbox"][2]

        expected = (current.number + 1) if current else 1
        if _is_bold(obj) and x0 < NUMBER_X_MAX and text.isdigit() and int(text) == expected:
            current = Question(number=int(text), page=page_no + 1)
            questions.append(current)
            acc = _TextAccumulator(current.stem)
            continue
        if current is None:
            continue  # document title lines

        match = OPTION_RE.match(text)
        next_label = chr(ord("a") + len(current.options))
        if _is_bold(obj) and x0 < OPTION_X_MAX and match and match.group(1) == next_label:
            option = Option(label=next_label)
            current.options.append(option)
            acc = _TextAccumulator(option.blocks)
            if match.group(2):
                acc.add_line(match.group(2), x1)
            continue

        acc.add_line(text, x1)

    return questions, store


def question_to_dict(q: Question) -> dict:
    return {
        "number": q.number,
        "page": q.page,
        "stem": [b.to_dict() for b in q.stem],
        "options": [{"label": o.label, "blocks": [b.to_dict() for b in o.blocks]} for o in q.options],
    }
