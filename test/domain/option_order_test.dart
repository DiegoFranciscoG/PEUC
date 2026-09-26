import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/domain/option_order.dart';

import '../support/fixtures.dart';

void main() {
  test('options that reference others keep the official order', () {
    expect(canShuffleOptions(testQuestion(1, options: ['uno', 'dos', 'Todas las anteriores'])), isFalse);
    expect(canShuffleOptions(testQuestion(2, options: ['uno', 'dos', 'Ninguna de las anteriores'])), isFalse);
    expect(canShuffleOptions(testQuestion(3, options: ['uno', 'dos', 'a y b son correctas'])), isFalse);
  });

  test('true/false pairs are not shuffled', () {
    expect(canShuffleOptions(testQuestion(4, options: ['Verdadero', 'Falso'], answer: 'a')), isFalse);
  });

  test('regular options can be shuffled', () {
    expect(canShuffleOptions(testQuestion(5)), isTrue);
  });

  test('shuffling keeps the same options and the correct label', () {
    final question = testQuestion(6, options: ['uno', 'dos', 'tres', 'cuatro', 'cinco']);
    final shuffled = presentedOptions(question, shuffle: true, random: Random(7));
    expect(shuffled.map((o) => o.label).toSet(), {'a', 'b', 'c', 'd', 'e'});
    expect(shuffled.where((o) => question.isCorrect(o.label)).single.plainText, 'dos');
  });

  test('without shuffle the official order is returned', () {
    final question = testQuestion(8);
    expect(presentedOptions(question, shuffle: false), same(question.options));
  });

  test('display labels follow the position', () {
    expect([for (var i = 0; i < 4; i++) displayLabel(i)], ['a', 'b', 'c', 'd']);
  });
}
