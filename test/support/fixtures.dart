import 'package:peuc/domain/models.dart';

const testAreas = [
  Area(code: 'MAT', prefix: '1', name: 'Matemáticas'),
  Area(code: 'LEN', prefix: '2', name: 'Lengua y Literatura'),
  Area(code: 'CNA', prefix: '3', name: 'Ciencias Naturales'),
  Area(code: 'CSO', prefix: '4', name: 'Ciencias Sociales'),
  Area(code: 'RAB', prefix: '5', name: 'Razonamiento Abstracto'),
];

const testTopics = [
  Topic(code: '1.1.1', areaCode: 'MAT', unitCode: '1.1', unit: 'Álgebra y Funciones', title: 'Números reales.'),
  Topic(code: '1.1.5', areaCode: 'MAT', unitCode: '1.1', unit: 'Álgebra y Funciones', title: 'Ecuaciones.'),
  Topic(code: '2.1.1', areaCode: 'LEN', unitCode: '2.1', unit: 'Lengua y Cultura', title: 'Variedades lingüísticas.'),
  Topic(code: '3.3.1', areaCode: 'CNA', unitCode: '3.3', unit: 'Cuerpo humano', title: 'Sistemas del cuerpo.'),
  Topic(code: '4.2.1', areaCode: 'CSO', unitCode: '4.2', unit: 'Argumentación', title: 'Silogística.'),
  Topic(code: '5.2.2', areaCode: 'RAB', unitCode: '5.2', unit: 'Series gráficas', title: 'Cambio posicional.'),
];

Question testQuestion(
  int number, {
  String topic = '1.1.1',
  String area = 'MAT',
  String answer = 'b',
  List<String> options = const ['uno', 'dos', 'tres', 'cuatro'],
  String stem = 'Enunciado de prueba',
  String? note,
  String? flag,
}) =>
    Question(
      number: number,
      page: number,
      topicCode: topic,
      areaCode: area,
      stem: [ContentBlock.text(stem)],
      options: [
        for (final (i, text) in options.indexed)
          AnswerOption(label: String.fromCharCode(97 + i), blocks: [ContentBlock.text(text)]),
      ],
      answer: answer,
      justification: 'Justificación $number',
      check: AnswerCheck.text,
      note: note,
      flag: flag,
    );

/// 20 questions per area, split between the topics of each area.
QuestionBank testBank() {
  final questions = <Question>[];
  var n = 1;
  for (final area in testAreas) {
    final topics = testTopics.where((t) => t.areaCode == area.code).toList();
    for (var i = 0; i < 20; i++) {
      final topic = topics[i % topics.length];
      questions.add(testQuestion(n, topic: topic.code, area: area.code, stem: '${area.name} pregunta $n'));
      n++;
    }
  }
  questions[0] = testQuestion(1, stem: 'Resuelva la ecuación cuadrática', note: 'Nota de prueba', flag: 'corregida');
  return QuestionBank(
    version: 'test',
    sourceName: 'Banco de prueba',
    sourceUrl: 'https://example.org/banco.pdf',
    sourceSha256: '0' * 64,
    areas: testAreas,
    topics: testTopics,
    questions: questions,
  );
}
