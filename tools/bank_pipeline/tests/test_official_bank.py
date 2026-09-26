"""Integration test over the real sources. It runs only when the official PDF and
the resolved .docx are available (set BANK_PDF and BANK_DOCX); the files are not
versioned because they belong to the Universidad de Cuenca and to the author."""
import os
from pathlib import Path

import pytest

from extract_pdf import extract
from parse_docx import answer_images, parse
from validate import check_question, stem_similarity

PDF = Path(os.environ.get("BANK_PDF", "missing.pdf"))
DOCX = Path(os.environ.get("BANK_DOCX", "missing.docx"))

pytestmark = pytest.mark.skipif(not (PDF.exists() and DOCX.exists()), reason="fuentes oficiales no disponibles")


@pytest.fixture(scope="module")
def sources():
    questions, store = extract(PDF, None)
    return questions, store, parse(DOCX), answer_images(DOCX)


def test_extracts_all_questions_in_order(sources):
    questions, store, _, _ = sources
    assert [q.number for q in questions] == list(range(1, 2738))
    assert all(q.stem and q.options for q in questions)
    assert store.count > 2000


def test_every_resolved_answer_is_consistent_with_the_official_options(sources):
    questions, store, answers, images = sources
    results = [check_question(q, a, store.raw, images.get(q.number, [])) for q, a in zip(questions, answers)]
    assert not [r for r in results if r.status.startswith("mismatch") or r.status == "missing_letter"]
    assert all(stem_similarity(q, a) >= 0.6 for q, a in zip(questions, answers))
