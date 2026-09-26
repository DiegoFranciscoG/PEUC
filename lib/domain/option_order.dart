import 'dart:math';

import 'models.dart';

/// Options that refer to other options ("todas las anteriores", "a y b") or
/// true/false pairs must keep the official order.
final RegExp _referencesOthers = RegExp(
  r'anterior|ninguna|todas|todos los|ambas|\b[a-f]\s*(y|e|o)\s*[a-f]\b|literales?',
  caseSensitive: false,
);

bool canShuffleOptions(Question question) {
  if (question.options.length <= 2) return false;
  return !question.options.any((o) => _referencesOthers.hasMatch(o.plainText));
}

/// Order in which the options are shown. Shuffling avoids memorising the
/// letter of the answer (in the resolved bank 40 % of the answers are "a").
List<AnswerOption> presentedOptions(Question question, {required bool shuffle, Random? random}) {
  if (!shuffle || !canShuffleOptions(question)) return question.options;
  return [...question.options]..shuffle(random ?? Random());
}

/// Letter shown next to an option at a given position (a, b, c...).
String displayLabel(int index) => String.fromCharCode('a'.codeUnitAt(0) + index);
