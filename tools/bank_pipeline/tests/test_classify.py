import json
from pathlib import Path

from classify import SyllabusClassifier, abstract_rule, build_corpus, tokens

DATA = Path(__file__).resolve().parents[1] / "data"


def test_tokens_drop_stopwords_accents_and_short_words():
    assert tokens("¿Cuál es la función exponencial?") == ["funcion", "exponen"]


def test_abstract_rule_detects_picture_puzzles():
    assert abstract_rule("Seleccione la opción que continúe la secuencia.", [False] * 4, True) == "5.2.2"
    assert abstract_rule("Tomando como base la figura, seleccione la que se obtiene al girar 180°", [False] * 4, True) == "5.3.1"


def test_abstract_rule_ignores_math_with_picture_options():
    assert abstract_rule("El resultado de racionalizar la expresión 2x es", [False] * 4, True) is None


def test_classifier_uses_the_reference_vocabulary():
    corpus = build_corpus(
        [
            {"code": "3.4.4", "title": "El enlace químico.", "unit": "El mundo de la química"},
            {"code": "4.2.1", "title": "Silogística aristotélica y lógica moderna de clases.", "unit": "Argumentación"},
        ],
        {"3.4.4": ["enlace covalente iónico electrones compartidos"], "4.2.1": ["silogismo premisa conclusión falacia"]},
    )
    clf = SyllabusClassifier(corpus)
    assert clf.predict("¿Qué tipo de enlace comparte electrones?").code == "3.4.4"
    assert clf.predict("Identifique la falacia en el siguiente silogismo").code == "4.2.1"


def test_review_overrides_cover_every_question_with_valid_topics():
    syllabus = {t["code"] for t in json.loads((DATA / "syllabus_2026.json").read_text(encoding="utf-8"))["topics"]}
    overrides = json.loads((DATA / "review_overrides.json").read_text(encoding="utf-8"))
    assert len(syllabus) == 62
    assert set(overrides["topics"]) == {str(n) for n in range(1, 2738)}
    assert set(overrides["topics"].values()) <= syllabus
    for number, fix in overrides["answers"].items():
        assert fix.get("note") or fix.get("why"), number
        assert fix.get("letter", "a") in "abcdef"
