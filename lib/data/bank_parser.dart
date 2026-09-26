import 'dart:convert';

import '../domain/models.dart';

/// Parses assets/bank/bank.json (produced by tools/bank_pipeline).
/// Top-level function so it can run in a background isolate with compute().
QuestionBank parseBank(String source) {
  final json = jsonDecode(source) as Map<String, dynamic>;
  final source_ = json['source'] as Map<String, dynamic>;

  final areas = [
    for (final a in json['areas'] as List)
      Area(code: a['code'] as String, prefix: a['prefix'] as String, name: a['name'] as String),
  ];
  final topics = [
    for (final t in json['topics'] as List)
      Topic(
        code: t['code'] as String,
        areaCode: t['area'] as String,
        unitCode: t['unit_code'] as String,
        unit: t['unit'] as String,
        title: t['title'] as String,
      ),
  ];
  final areaOfTopic = {for (final t in topics) t.code: t.areaCode};

  final questions = <Question>[];
  for (final raw in json['questions'] as List) {
    final q = raw as Map<String, dynamic>;
    final topicCode = q['topic'] as String;
    final areaCode = areaOfTopic[topicCode];
    if (areaCode == null) {
      throw FormatException('Pregunta ${q['n']}: subtema desconocido $topicCode');
    }
    final options = [
      for (final o in q['options'] as List)
        AnswerOption(label: o['l'] as String, blocks: _blocks(o['b'] as List)),
    ];
    final answer = q['answer'] as String;
    if (!options.any((o) => o.label == answer)) {
      throw FormatException('Pregunta ${q['n']}: la respuesta $answer no está entre las opciones');
    }
    questions.add(Question(
      number: q['n'] as int,
      page: q['page'] as int,
      topicCode: topicCode,
      areaCode: areaCode,
      stem: _blocks(q['stem'] as List),
      options: options,
      answer: answer,
      justification: q['why'] as String,
      check: AnswerCheck.parse(q['check'] as String),
      note: q['note'] as String?,
      flag: q['flag'] as String?,
    ));
  }

  return QuestionBank(
    version: json['version'] as String,
    sourceName: source_['name'] as String,
    sourceUrl: source_['url'] as String,
    sourceSha256: source_['sha256'] as String,
    areas: areas,
    topics: topics,
    questions: questions,
  );
}

List<ContentBlock> _blocks(List raw) => [
      for (final b in raw)
        if ((b as Map).containsKey('img'))
          ContentBlock.image(
            b['img'] as String,
            width: (b['w'] as num?)?.toDouble(),
            height: (b['h'] as num?)?.toDouble(),
          )
        else
          ContentBlock.text(b['t'] as String),
    ];
