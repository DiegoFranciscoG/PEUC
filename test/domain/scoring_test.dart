import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/domain/admission_rules.dart';
import 'package:peuc/domain/scoring.dart';

import '../support/fixtures.dart';

void main() {
  group('ComponentResult', () {
    test('applies +1 / −1/3 / 0', () {
      const result = ComponentResult(areaCode: 'MAT', correct: 9, wrong: 3, blank: 0);
      expect(result.points, closeTo(8, 1e-9));
      expect(result.percent, closeTo(8 / 12 * 100, 1e-9));
    });

    test('can be negative when only wrong answers are given', () {
      const result = ComponentResult(areaCode: 'MAT', correct: 0, wrong: 12, blank: 0);
      expect(result.points, closeTo(-4, 1e-9));
    });

    test('empty component scores zero', () {
      const result = ComponentResult(areaCode: 'MAT', correct: 0, wrong: 0, blank: 0);
      expect(result.percent, 0);
    });
  });

  group('scoreExam', () {
    test('counts correct, wrong and blank answers per area', () {
      final questions = [
        testQuestion(1, answer: 'a'),
        testQuestion(2, answer: 'b'),
        testQuestion(3, answer: 'c'),
        testQuestion(4, area: 'LEN', topic: '2.1.1', answer: 'd'),
      ];
      final score = scoreExam(questions, {1: 'a', 2: 'c', 4: 'd'});

      expect(score.components['MAT']!.correct, 1);
      expect(score.components['MAT']!.wrong, 1);
      expect(score.components['MAT']!.blank, 1);
      expect(score.components['LEN']!.correct, 1);
      expect(score.correct, 2);
      expect(score.points, closeTo(2 - 1 / 3, 1e-9));
    });

    test('weighted grade follows the field weights', () {
      final bank = testBank();
      final questions = [
        ...bank.byArea('MAT').take(12),
        ...bank.byArea('LEN').take(12),
        ...bank.byArea('CSO').take(12),
        ...bank.byArea('CNA').take(12),
        ...bank.byArea('RAB').take(12),
      ];
      // Everything right in Mathematics, everything blank elsewhere.
      final answers = {for (final q in questions.where((q) => q.areaCode == 'MAT')) q.number: q.answer};
      final score = scoreExam(questions, answers);

      expect(score.weightedPercent(fieldByCode('M')), closeTo(45, 1e-9));
      expect(score.weightedPercent(fieldByCode('CS')), closeTo(20, 1e-9));
    });

    test('a perfect exam is 100 % in every field', () {
      final bank = testBank();
      final questions = [for (final code in AdmissionRules.areaOrder) ...bank.byArea(code).take(12)];
      final score = scoreExam(questions, {for (final q in questions) q.number: q.answer});
      for (final field in knowledgeFields) {
        expect(score.weightedPercent(field), closeTo(100, 1e-9));
      }
    });
  });
}
