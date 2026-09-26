import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/domain/admission_rules.dart';
import 'package:peuc/domain/exam_builder.dart';

import '../support/fixtures.dart';

void main() {
  group('allocateProportionally', () {
    test('uses the largest remainder method', () {
      final allocation = ExamBuilder.allocateProportionally({'a': 50, 'b': 30, 'c': 20}, 12);
      expect(allocation, {'a': 6, 'b': 4, 'c': 2});
    });

    test('distributes exactly the requested seats', () {
      final allocation = ExamBuilder.allocateProportionally({'a': 7, 'b': 7, 'c': 7}, 10);
      expect(allocation.values.fold(0, (a, b) => a + b), 10);
      expect(allocation.values.every((v) => v >= 3), isTrue);
    });

    test('never gives a group more than its size', () {
      final allocation = ExamBuilder.allocateProportionally({'a': 1, 'b': 100}, 12);
      expect(allocation['a']! <= 1, isTrue);
      expect(allocation.values.fold(0, (a, b) => a + b), 12);
    });

    test('caps the total at the available questions', () {
      final allocation = ExamBuilder.allocateProportionally({'a': 2, 'b': 3}, 12);
      expect(allocation, {'a': 2, 'b': 3});
    });

    test('handles empty input and zero seats', () {
      expect(ExamBuilder.allocateProportionally({}, 12), isEmpty);
      expect(ExamBuilder.allocateProportionally({'a': 5}, 0), {'a': 0});
    });
  });

  group('simulation', () {
    test('has 12 questions per component in the official order, without repeats', () {
      final exam = ExamBuilder(Random(1)).simulation(testBank());
      expect(exam.length, AdmissionRules.totalQuestions);
      expect(exam.map((q) => q.number).toSet().length, exam.length);
      for (final (i, code) in AdmissionRules.areaOrder.indexed) {
        final block = exam.sublist(i * 12, i * 12 + 12);
        expect(block.every((q) => q.areaCode == code), isTrue, reason: code);
      }
    });

    test('covers every topic of a component proportionally', () {
      final exam = ExamBuilder(Random(2)).simulation(testBank());
      final math = exam.where((q) => q.areaCode == 'MAT');
      expect(math.where((q) => q.topicCode == '1.1.1').length, 6);
      expect(math.where((q) => q.topicCode == '1.1.5').length, 6);
    });

    test('is random between attempts', () {
      final bank = testBank();
      final first = ExamBuilder(Random(3)).simulation(bank).map((q) => q.number).toList();
      final second = ExamBuilder(Random(4)).simulation(bank).map((q) => q.number).toList();
      expect(first, isNot(second));
    });
  });

  group('practiceSet', () {
    test('puts last-wrong questions first, then unseen ones', () {
      final pool = testBank().byArea('MAT');
      final set = ExamBuilder(Random(5)).practiceSet(
        pool,
        5,
        seen: {for (final q in pool.take(15)) q.number},
        lastWrong: {pool[0].number, pool[1].number},
      );
      expect(set.length, 5);
      expect(set.take(2).map((q) => q.number).toSet(), {pool[0].number, pool[1].number});
      expect(set.skip(2).every((q) => q.number > pool[14].number), isTrue);
    });

    test('returns the whole pool when it is smaller than the count', () {
      final pool = testBank().byArea('RAB').take(3).toList();
      expect(ExamBuilder(Random(6)).practiceSet(pool, 10).length, 3);
    });
  });
}
