from extract_pdf import SUBSCRIPT, SUPERSCRIPT, Block, _line_text, _reading_order, _script, _SUB_OK, _SUP_OK, _TextAccumulator


def span(text, size=11.2, flags=4, y=100.0):
    return {"text": text, "size": size, "flags": flags, "origin": (0, y), "font": "DejaVuSans"}


def test_superscripts_become_unicode():
    line = {"spans": [span("x"), span("2 ", size=8.4, flags=5, y=95.5), span("- x - 6")]}
    assert _line_text(line) == "x² - x - 6"


def test_negative_exponent():
    line = {"spans": [span("f (x) = x"), span("-1", size=8.4, flags=5, y=95.5)]}
    assert _line_text(line) == "f (x) = x⁻¹"


def test_subscripts_become_unicode():
    line = {"spans": [span("H"), span("3", size=8.4, y=103), span("PO"), span("4", size=8.4, y=103)]}
    assert _line_text(line) == "H₃PO₄"


def test_unmappable_script_falls_back_to_explicit_notation():
    assert _script("zo", SUBSCRIPT, _SUB_OK, "_") == "_(zo)"
    assert _script("1/2", SUPERSCRIPT, _SUP_OK, "^") == "^(1/2)"


def test_reading_order_puts_number_before_stem_on_the_same_row():
    items = [(176.0, 86.0, "line", "stem"), (179.0, 65.0, "line", "number"), (204.0, 86.0, "line", "a)")]
    assert [it[3] for it in _reading_order(items)] == ["number", "stem", "a)"]


def test_accumulator_joins_wrapped_lines_and_keeps_hard_breaks():
    blocks = []
    acc = _TextAccumulator(blocks)
    acc.add_line("Lea el siguiente fragmento y luego, identifique", 520)
    acc.add_line("la opción correcta.", 200)
    acc.add_line("Texto nuevo", 150)
    assert blocks == [Block(text="Lea el siguiente fragmento y luego, identifique la opción correcta.\nTexto nuevo")]


def test_accumulator_joins_hyphenated_words():
    blocks = []
    acc = _TextAccumulator(blocks)
    acc.add_line("pre-escritura, escritura y pos-", 520)
    acc.add_line("escritura.", 200)
    assert blocks[0].text == "pre-escritura, escritura y pos-escritura."


def test_images_split_text_blocks():
    blocks = []
    acc = _TextAccumulator(blocks)
    acc.add_line("El resultado de racionalizar", 300)
    acc.add_image("abc.webp", 56.04, 41.9)
    acc.add_line("es", 100)
    assert [b.to_dict() for b in blocks] == [
        {"t": "El resultado de racionalizar"},
        {"img": "abc.webp", "w": 56.0, "h": 41.9},
        {"t": "es"},
    ]


def test_pictures_without_size_omit_it():
    assert Block(image="x.webp").to_dict() == {"img": "x.webp"}
