from parse_docx import parse_paragraphs


def test_parses_answer_letter_text_and_justification():
    result = parse_paragraphs([
        "1. ¿Qué es una paradoja?",
        "Respuesta: b) Una expresión que desafía al sentido común.",
        "Por qué: Contradice el sentido común.",
        "",
        "2. ¿A qué región pertenece?",
        "Respuesta: c) Costa",
        "Por qué: Habla costeña.",
    ])
    assert [r.number for r in result] == [1, 2]
    assert result[0].letter == "b"
    assert result[0].answer_text.startswith("Una expresión")
    assert result[1].justification == "Habla costeña."


def test_accepts_questions_whose_stem_is_only_an_image():
    result = parse_paragraphs([
        "1. Pregunta", "Respuesta: a) x", "Por qué: y",
        "2.", "Respuesta: d) 100", "Por qué: cálculo",
    ])
    assert result[1].number == 2
    assert result[1].stem == ""
    assert result[1].letter == "d"


def test_numbers_inside_text_do_not_start_a_new_question():
    result = parse_paragraphs([
        "1. Calcule:",
        "5. no es el siguiente número esperado",
        "Respuesta: a) 5",
        "Por qué: porque sí.",
    ])
    assert len(result) == 1
    assert "no es el siguiente" in result[0].stem
