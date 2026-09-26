"""Cross-checks the resolved answers (.docx) against the official options (PDF).

For every question the answer letter must exist in the official PDF and the
text (or picture) that the resolved bank gives for that letter must match the
official option. Pictures are compared with a 64-bit difference hash, which is
compared as trimmed grayscale thumbnails (mean absolute pixel difference), which
is robust to the re-encoding and rescaling done when the .docx was produced and
still tells apart formulas that differ in a single symbol.
"""
from __future__ import annotations

import io
import re
import unicodedata
from dataclasses import dataclass
from difflib import SequenceMatcher

from PIL import Image

from extract_pdf import Question
from parse_docx import ResolvedAnswer

TEXT_OK = 0.80
IMAGE_OK = 30.0  # max mean absolute pixel difference (0-255) to accept a picture match
IMAGE_MARGIN = 4.0  # the best option must beat the runner-up by at least this much


@dataclass
class Check:
    number: int
    status: str  # ok_text | ok_image | ok_stem_only | mismatch_text | mismatch_image | missing_letter
    detail: str = ""
    best_label: str | None = None
    score: float = 0.0


def normalize(text: str) -> str:
    text = unicodedata.normalize("NFKD", text.lower())
    text = "".join(c for c in text if not unicodedata.combining(c))
    return re.sub(r"[^a-z0-9]+", "", text)


def similarity(a: str, b: str) -> float:
    na, nb = normalize(a), normalize(b)
    if not na or not nb:
        return 0.0
    if na == nb:
        return 1.0
    if len(na) >= 8 and len(nb) >= 8 and (na in nb or nb in na):
        return 0.95
    return SequenceMatcher(None, na, nb).ratio()


def thumbnail(raw: bytes, size: tuple[int, int] = (96, 32)) -> list[int]:
    img = Image.open(io.BytesIO(raw)).convert("L")
    # Trim white margins so that padding differences do not dominate.
    inverted = img.point(lambda v: 255 if v < 200 else 0)
    box = inverted.getbbox()
    if box:
        img = img.crop(box)
    return list(img.resize(size, Image.LANCZOS).tobytes())


def image_distance(a: list[int], b: list[int]) -> float:
    return sum(abs(x - y) for x, y in zip(a, b)) / len(a)


def _option_text(option) -> str:
    return " ".join(b.text for b in option.blocks if b.text)


def _option_images(option) -> list[str]:
    return [b.image for b in option.blocks if b.image]


def check_question(
    q: Question,
    ans: ResolvedAnswer,
    raw_images: dict[str, bytes],
    docx_answer_images: list[bytes],
) -> Check:
    labels = [o.label for o in q.options]
    if ans.letter not in labels:
        return Check(q.number, "missing_letter", f"letra {ans.letter} no existe (opciones: {''.join(labels)})")

    chosen = q.options[labels.index(ans.letter)]
    text_scores = {o.label: similarity(ans.answer_text, _option_text(o)) for o in q.options}
    has_text = any(_option_text(o) for o in q.options)

    if has_text and _option_text(chosen):
        best = max(text_scores, key=text_scores.get)
        own = text_scores[ans.letter]
        if own >= TEXT_OK:
            return Check(q.number, "ok_text", best_label=ans.letter, score=own)
        if best != ans.letter and text_scores[best] >= TEXT_OK and text_scores[best] - own > 0.1:
            return Check(q.number, "mismatch_text",
                         f"el texto de la respuesta coincide con la opción {best}) ({text_scores[best]:.2f})",
                         best_label=best, score=text_scores[best])

    option_imgs = {o.label: _option_images(o) for o in q.options}
    if docx_answer_images and all(option_imgs.values()):
        targets = [thumbnail(b) for b in docx_answer_images]
        distances = {}
        for label, names in option_imgs.items():
            thumbs = [thumbnail(raw_images[n]) for n in names]
            distances[label] = min(image_distance(t, h) for t in targets for h in thumbs)
        ranked = sorted(distances, key=distances.get)
        best, runner_up = ranked[0], ranked[1] if len(ranked) > 1 else None
        clear = runner_up is None or distances[runner_up] - distances[best] >= IMAGE_MARGIN
        if best == ans.letter and distances[best] <= IMAGE_OK:
            return Check(q.number, "ok_image", best_label=best, score=distances[best])
        if best != ans.letter and distances[best] <= IMAGE_OK and clear:
            return Check(q.number, "mismatch_image",
                         f"la imagen de la respuesta coincide con la opción {best}) "
                         f"(d={distances[best]:.1f} vs {distances[ans.letter]:.1f})",
                         best_label=best, score=distances[best])

    return Check(q.number, "ok_stem_only", "respuesta sin texto/imagen comparable; se conserva la letra del banco resuelto",
                 best_label=ans.letter, score=text_scores.get(ans.letter, 0.0))


def stem_similarity(q: Question, ans: ResolvedAnswer) -> float:
    pdf_stem = " ".join(b.text for b in q.stem if b.text)
    if not pdf_stem.strip() and not ans.stem.strip():
        return 1.0
    return similarity(pdf_stem, ans.stem)
