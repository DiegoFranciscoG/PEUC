import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/data/bank_parser.dart';
import 'package:peuc/domain/admission_rules.dart';
import 'package:peuc/domain/models.dart';

Map<String, dynamic> _minimalBank({String topic = '1.1.1', String answer = 'a'}) => {
      'version': '2026.1.0',
      'source': {'name': 'Banco', 'url': 'https://example.org', 'sha256': 'abc', 'questions': 1},
      'areas': [
        {'code': 'MAT', 'prefix': '1', 'name': 'Matemáticas'},
      ],
      'topics': [
        {'code': '1.1.1', 'area': 'MAT', 'unit_code': '1.1', 'unit': 'Álgebra', 'title': 'Números reales.'},
      ],
      'questions': [
        {
          'n': 7,
          'page': 3,
          'topic': topic,
          'stem': [
            {'t': 'El resultado de'},
            {'img': 'abc.webp'},
          ],
          'options': [
            {'l': 'a', 'b': [{'t': 'x²'}]},
            {'l': 'b', 'b': [{'img': 'def.webp'}]},
          ],
          'answer': answer,
          'why': 'Porque sí.',
          'check': 'image',
          'note': null,
          'flag': null,
        },
      ],
    };

void main() {
  test('parses areas, topics, blocks and answers', () {
    final bank = parseBank(jsonEncode(_minimalBank()));
    final q = bank.byNumber(7)!;

    expect(bank.version, '2026.1.0');
    expect(q.areaCode, 'MAT');
    expect(q.stem[1].isImage, isTrue);
    expect(q.stem[1].image, 'abc.webp');
    expect(q.options[1].hasImage, isTrue);
    expect(q.correctOption.plainText, 'x²');
    expect(q.check, AnswerCheck.image);
    expect(q.plainStem, 'El resultado de');
    expect(q.hasObservation, isFalse);
  });

  test('rejects an unknown topic', () {
    expect(() => parseBank(jsonEncode(_minimalBank(topic: '9.9.9'))), throwsFormatException);
  });

  test('rejects an answer that is not among the options', () {
    expect(() => parseBank(jsonEncode(_minimalBank(answer: 'z'))), throwsFormatException);
  });

  group('bundled official bank', () {
    final bank = parseBank(File('assets/bank/bank.json').readAsStringSync());

    test('has the 2737 official questions numbered 1..2737', () {
      expect(bank.questions.length, 2737);
      expect(bank.questions.map((q) => q.number).toList(), List.generate(2737, (i) => i + 1));
    });

    test('uses the 62 subtopics of the official syllabus in 5 areas', () {
      expect(bank.areas.map((a) => a.code).toSet(), AdmissionRules.areaOrder.toSet());
      expect(bank.topics.length, 62);
    });

    test('every area has enough questions for a full simulation', () {
      for (final code in AdmissionRules.areaOrder) {
        expect(bank.byArea(code).length, greaterThanOrEqualTo(AdmissionRules.questionsPerArea), reason: code);
      }
    });

    test('every question has a stem, 2 to 6 options and a justification', () {
      for (final q in bank.questions) {
        expect(q.stem, isNotEmpty, reason: '#${q.number}');
        expect(q.options.length, inInclusiveRange(2, 6), reason: '#${q.number}');
        expect(q.justification.trim(), isNotEmpty, reason: '#${q.number}');
      }
    });

    test('no answer remains in conflict with the official options', () {
      expect(bank.questions.where((q) => q.check == AnswerCheck.conflict), isEmpty);
    });

    test('every referenced picture exists', () {
      final names = {
        for (final q in bank.questions) ...[
          ...q.stem.where((b) => b.isImage).map((b) => b.image!),
          for (final o in q.options) ...o.blocks.where((b) => b.isImage).map((b) => b.image!),
        ],
      };
      final missing = names.where((n) => !File('assets/bank/img/$n').existsSync());
      expect(missing, isEmpty);
    });

    test('corrected answers carry a note', () {
      final corrected = bank.questions.where((q) => q.wasCorrected);
      expect(corrected.map((q) => q.number).toSet(), {957, 1550, 2535});
      expect(corrected.every((q) => q.note != null), isTrue);
    });
  });
}
