import io

from PIL import Image, ImageDraw

from extract_pdf import Block, Option, Question
from parse_docx import ResolvedAnswer
from validate import check_question, normalize, similarity, stem_similarity


def question(options, number=1):
    return Question(number=number, page=1, stem=[Block(text="Enunciado")], options=options)


def text_option(label, text):
    return Option(label=label, blocks=[Block(text=text)])


def answer(letter, text, number=1):
    return ResolvedAnswer(number=number, stem="Enunciado", letter=letter, answer_text=text, justification="j")


def png(draw):
    img = Image.new("L", (120, 40), 255)
    draw(ImageDraw.Draw(img))
    buffer = io.BytesIO()
    img.save(buffer, "PNG")
    return buffer.getvalue()


def test_normalize_removes_accents_case_and_symbols():
    assert normalize("¡Óxido de Bario (II)!") == "oxidodebarioii"
    assert similarity("x²", "x2") == 1.0


def test_text_answer_matching_its_letter_is_ok():
    q = question([text_option("a", "Galápagos"), text_option("b", "Costa")])
    assert check_question(q, answer("b", "Costa"), {}, []).status == "ok_text"


def test_text_answer_matching_another_letter_is_a_conflict():
    q = question([text_option("a", "Miguel Riofrío"), text_option("b", "Juan León Mera")])
    result = check_question(q, answer("b", "Miguel Riofrío"), {}, [])
    assert result.status == "mismatch_text"
    assert result.best_label == "a"


def test_missing_letter_is_reported():
    q = question([text_option("a", "Verdadero"), text_option("b", "Falso")])
    assert check_question(q, answer("e", "Falso"), {}, []).status == "missing_letter"


def test_picture_answer_is_matched_against_option_pictures():
    raw = {
        "one.webp": png(lambda d: d.rectangle((10, 10, 40, 30), fill=0)),
        "two.webp": png(lambda d: d.ellipse((70, 5, 110, 35), fill=0)),
    }
    q = question([
        Option(label="a", blocks=[Block(image="one.webp")]),
        Option(label="b", blocks=[Block(image="two.webp")]),
    ])
    docx_picture = raw["two.webp"]
    assert check_question(q, answer("b", "círculo"), raw, [docx_picture]).status == "ok_image"
    assert check_question(q, answer("a", "círculo"), raw, [docx_picture]).status == "mismatch_image"


def test_stem_similarity_detects_misaligned_numbering():
    q = question([text_option("a", "x")])
    assert stem_similarity(q, answer("a", "x")) == 1.0
    other = ResolvedAnswer(number=1, stem="Otra pregunta distinta", letter="a", answer_text="x", justification="")
    assert stem_similarity(q, other) < 0.6
