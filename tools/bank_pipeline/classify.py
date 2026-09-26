"""Assigns every question to one subtopic of the official 2026 syllabus.

The official bank is published without area labels, so the pipeline predicts
them in two steps:
  1. Rules for Abstract Reasoning items (picture sequences, matrices, rotations),
     whose text carries almost no vocabulary.
  2. TF-IDF nearest-centroid over a reference corpus per subtopic (official
     syllabus titles plus topic vocabulary). Question text, options and the
     justification are used as features.
Manual review results (review_overrides.json) always win over predictions.
"""
from __future__ import annotations

import math
import re
import unicodedata
from collections import Counter, defaultdict
from dataclasses import dataclass

STOPWORDS = set(
    """a al algo algun alguna algunas alguno algunos ante antes aquel aquella aquellas aquello
    aquellos aqui asi aun bajo bien cada como con contra cual cuales cualquier cuando cuanto
    de del desde donde dos el ella ellas ello ellos en entre era eran es esa esas ese eso esos
    esta estaba estan estar este esto estos fue fueron ha habia han hasta hay la las le les lo
    los mas me mi mientras muy nada ni no nos o otra otras otro otros para pero poco por porque
    puede pueden que quien se sea segun ser si sin sobre solo son su sus tal tambien tan tanto
    te tiene tienen todo todos tu un una uno unos usted y ya indique seleccione opcion opciones
    siguiente siguientes correcta correcto respuesta cual cuales literal enunciado expresion
    determine identifique escoja elija lea texto relacione corresponda afirmacion anteriores
    ninguna todas verdadero falso""".split()
)

ABSTRACT_PATTERNS = [
    (re.compile(r"rota|gir(a|o|ar)|manecillas|180\s*°|90\s*°|270\s*°", re.I), "5.3.1"),
    (re.compile(r"\b(cubo|desarrollo|plan(o|tilla)|arm(ar|ado)|plegar|dobl(ar|ez)|3d|2d|tridimensional)\b", re.I), "5.3.2"),
    (re.compile(r"\b(vista|perspectiva|frontal|lateral|superior|planta)\b", re.I), "5.3.3"),
    (re.compile(r"\bes a\b.*\bcomo\b|analog", re.I), "5.1.2"),
    (re.compile(r"diferente|no pertenece|no corresponde|distint|igual(es)? a|semejan", re.I), "5.1.1"),
    (re.compile(r"deform", re.I), "5.2.1"),
    (re.compile(r"secuencia|serie|contin[uú]e|sigue", re.I), "5.2.2"),
    (re.compile(r"signo de interrogaci|reemplaza|falta|complete la (matriz|figura)", re.I), "5.2.3"),
]
MATH_HINT = re.compile(r"\d|ecuaci|funci|valor|calcul|polinom|raiz|raíz|fracci|x\b", re.I)


def tokens(text: str) -> list[str]:
    text = unicodedata.normalize("NFKD", text.lower())
    text = "".join(c for c in text if not unicodedata.combining(c))
    words = re.findall(r"[a-z]{3,}", text)
    return [w[:7] for w in words if w not in STOPWORDS]


@dataclass
class Prediction:
    code: str
    confidence: float
    method: str  # rule | tfidf | override


class SyllabusClassifier:
    def __init__(self, corpus: dict[str, list[str]]):
        """corpus: subtopic code -> list of reference texts."""
        self.codes = sorted(corpus)
        docs_tokens = {code: Counter(t for text in corpus[code] for t in tokens(text)) for code in self.codes}
        df = Counter()
        for counts in docs_tokens.values():
            df.update(counts.keys())
        n = len(self.codes)
        self.idf = {t: math.log((1 + n) / (1 + d)) + 1 for t, d in df.items()}
        self.centroids = {code: self._vector(counts) for code, counts in docs_tokens.items()}

    def _vector(self, counts: Counter) -> dict[str, float]:
        vec = {t: (1 + math.log(c)) * self.idf.get(t, 0.0) for t, c in counts.items() if t in self.idf}
        norm = math.sqrt(sum(v * v for v in vec.values())) or 1.0
        return {t: v / norm for t, v in vec.items()}

    def rank(self, text: str) -> list[tuple[str, float]]:
        vec = self._vector(Counter(tokens(text)))
        scores = [
            (code, sum(w * centroid.get(t, 0.0) for t, w in vec.items()))
            for code, centroid in self.centroids.items()
        ]
        return sorted(scores, key=lambda s: -s[1])

    def predict(self, text: str) -> Prediction:
        ranked = self.rank(text)
        best, second = ranked[0], ranked[1]
        confidence = best[1] - second[1]
        return Prediction(best[0], round(confidence, 4), "tfidf")


def abstract_rule(stem_text: str, option_has_text: list[bool], stem_has_image: bool) -> str | None:
    """Returns an Abstract Reasoning subtopic when the item looks like a picture puzzle."""
    options_are_pictures = option_has_text and not any(option_has_text)
    if not (options_are_pictures or stem_has_image):
        return None
    if MATH_HINT.search(stem_text) and not re.search(r"secuencia|figura|rota|interrogaci", stem_text, re.I):
        return None
    for pattern, code in ABSTRACT_PATTERNS:
        if pattern.search(stem_text):
            return code
    return "5.2.2" if options_are_pictures and not stem_text.strip() else None


def build_corpus(syllabus: list[dict], extra: dict[str, list[str]] | None = None) -> dict[str, list[str]]:
    corpus: dict[str, list[str]] = defaultdict(list)
    for item in syllabus:
        title = item["title"]
        corpus[item["code"]].extend([title, title, title, item.get("unit", "")])
    for code, texts in (extra or {}).items():
        corpus[code].extend(texts)
    return dict(corpus)
