"""Builds the app question bank from the official PDF and the resolved .docx.

Usage:
    python build_bank.py --pdf Banco_de_preguntas_UCuenca_2026.pdf \
                         --docx Banco_UCuenca_2026_RESUELTO.docx \
                         --out ../../assets/bank --report ../../docs/reporte-validacion.md

Outputs:
    <out>/bank.json   questions, options, answers, justifications, topics
    <out>/img/*.webp  every picture of the official bank, de-duplicated
"""
from __future__ import annotations

import argparse
import hashlib
import json
from collections import Counter
from datetime import date
from pathlib import Path

from classify import SyllabusClassifier, abstract_rule, build_corpus
from extract_pdf import extract, question_to_dict
from parse_docx import answer_images, parse
from validate import check_question, stem_similarity

HERE = Path(__file__).parent
BANK_VERSION = "2026.1.0"
OFFICIAL_PDF_URL = "https://comunicacion.ucuenca.edu.ec/wp-content/uploads/2026/07/Banco_de_preguntas_UCuenca_2026.pdf"

METHOD_LABELS = {
    "review": "Revisión manual (review_overrides.json)",
    "rule": "Regla de razonamiento abstracto",
    "model": "Clasificador TF-IDF (sin revisar)",
}

CHECK_LABELS = {
    "ok_text": "text",
    "ok_image": "image",
    "ok_stem_only": "manual",
    "mismatch_text": "conflict",
    "mismatch_image": "conflict",
    "missing_letter": "conflict",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_json(path: Path, default):
    return json.loads(path.read_text(encoding="utf-8")) if path.exists() else default


def build(pdf: Path, docx_path: Path, out: Path, overrides_path: Path) -> dict:
    syllabus = load_json(HERE / "data" / "syllabus_2026.json", {})
    keywords = load_json(HERE / "data" / "topic_keywords.json", {})
    overrides = load_json(overrides_path, {"topics": {}, "answers": {}})
    topic_codes = {t["code"] for t in syllabus["topics"]}

    questions, store = extract(pdf, out / "img")
    answers = {a.number: a for a in parse(docx_path)}
    docx_imgs = answer_images(docx_path)
    classifier = SyllabusClassifier(build_corpus(syllabus["topics"], {c: [" ".join(w)] for c, w in keywords.items()}))

    if len(answers) != len(questions):
        raise SystemExit(f"El .docx tiene {len(answers)} respuestas y el PDF {len(questions)} preguntas")

    items, checks, methods = [], Counter(), Counter()
    for q in questions:
        ans = answers[q.number]
        if stem_similarity(q, ans) < 0.6:
            raise SystemExit(f"Pregunta {q.number}: el enunciado del .docx no coincide con el PDF")
        check = check_question(q, ans, store.raw, docx_imgs.get(q.number, []))
        checks[check.status] += 1

        stem_text = " ".join(b.text for b in q.stem if b.text)
        option_texts = [" ".join(b.text for b in o.blocks if b.text) for o in q.options]
        topic = overrides["topics"].get(str(q.number))
        method = "review"
        if topic is None:
            topic = abstract_rule(stem_text, [bool(t.strip()) for t in option_texts], any(b.image for b in q.stem))
            method = "rule"
        if topic is None:
            topic = classifier.predict(" ".join([stem_text, *option_texts, ans.justification])).code
            method = "model"
        if topic not in topic_codes:
            raise SystemExit(f"Pregunta {q.number}: subtema desconocido {topic}")
        methods[method] += 1

        data = question_to_dict(q)
        override = overrides["answers"].get(str(q.number), {})
        items.append(
            {
                "n": q.number,
                "page": q.page,
                "topic": topic,
                "stem": data["stem"],
                "options": [{"l": o["label"], "b": o["blocks"]} for o in data["options"]],
                "answer": override.get("letter", ans.letter),
                "why": override.get("why", ans.justification),
                "check": CHECK_LABELS[check.status],
                "note": override.get("note"),
                "flag": override.get("flag"),
            }
        )

    bank = {
        "version": BANK_VERSION,
        "generated": date.today().isoformat(),
        "source": {
            "name": "Banco de preguntas · Examen de admisión 2026 — Universidad de Cuenca",
            "url": OFFICIAL_PDF_URL,
            "sha256": sha256(pdf),
            "questions": len(questions),
        },
        "areas": syllabus["areas"],
        "topics": syllabus["topics"],
        "questions": items,
    }
    (out / "bank.json").write_text(json.dumps(bank, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    return {"checks": checks, "methods": methods, "images": store.count, "bank": bank}


def write_report(result: dict, report: Path) -> None:
    bank = result["bank"]
    by_area = Counter(q["topic"].split(".")[0] for q in bank["questions"])
    names = {a["prefix"]: a["name"] for a in bank["areas"]}
    flagged = [q for q in bank["questions"] if q["flag"] or q["note"]]
    lines = [
        "# Reporte de validación del banco",
        "",
        f"Generado por `tools/bank_pipeline/build_bank.py` · versión del banco `{bank['version']}` · {bank['generated']}",
        "",
        f"- Fuente oficial: [{bank['source']['name']}]({bank['source']['url']})",
        f"- SHA-256 del PDF procesado: `{bank['source']['sha256']}`",
        f"- Preguntas: **{len(bank['questions'])}** · imágenes únicas: **{result['images']}**",
        "",
        "## Cruce de respuestas (banco resuelto vs. opciones oficiales)",
        "",
        "| Resultado | Preguntas | Significado |",
        "|---|---:|---|",
        f"| Coincide el texto | {result['checks']['ok_text']} | El texto de la respuesta es el de la opción oficial con esa letra |",
        f"| Coincide la imagen | {result['checks']['ok_image']} | La imagen de la respuesta es la opción oficial con esa letra |",
        f"| Revisión manual | {result['checks']['ok_stem_only']} | Opción en imagen sin equivalente comparable; verificada a mano |",
        f"| Conflicto | {sum(result['checks'][k] for k in ('mismatch_text', 'mismatch_image', 'missing_letter'))} | Letra y contenido no coinciden |",
        "",
        "## Preguntas por área",
        "",
        "| Área | Preguntas |",
        "|---|---:|",
        *[f"| {names[p]} | {by_area[p]} |" for p in sorted(names)],
        "",
        "## Origen de la etiqueta de subtema",
        "",
        "| Método | Preguntas |",
        "|---|---:|",
        *[f"| {METHOD_LABELS[m]} | {c} |" for m, c in sorted(result["methods"].items())],
        "",
        "## Ítems con observación",
        "",
        "| # | Observación |",
        "|---:|---|",
        *[f"| {q['n']} | {q['note'] or q['flag']} |" for q in flagged],
        "",
    ]
    report.write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--pdf", type=Path, required=True)
    parser.add_argument("--docx", type=Path, required=True)
    parser.add_argument("--out", type=Path, default=HERE.parent.parent / "assets" / "bank")
    parser.add_argument("--overrides", type=Path, default=HERE / "data" / "review_overrides.json")
    parser.add_argument("--report", type=Path, default=HERE.parent.parent / "docs" / "reporte-validacion.md")
    args = parser.parse_args()
    result = build(args.pdf, args.docx, args.out, args.overrides)
    write_report(result, args.report)
    print(f"bank.json: {len(result['bank']['questions'])} preguntas · {result['images']} imágenes")
    print(dict(result["checks"]), dict(result["methods"]))


if __name__ == "__main__":
    main()
