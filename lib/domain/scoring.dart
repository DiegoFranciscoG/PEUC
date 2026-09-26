import 'admission_rules.dart';
import 'models.dart';

/// Result of one exam component (area).
class ComponentResult {
  const ComponentResult({
    required this.areaCode,
    required this.correct,
    required this.wrong,
    required this.blank,
  });

  final String areaCode;
  final int correct;
  final int wrong;
  final int blank;

  int get total => correct + wrong + blank;

  /// Official rule: +1 per correct answer, −1/3 per wrong answer, 0 if blank.
  double get points =>
      correct * AdmissionRules.correctPoints +
      wrong * AdmissionRules.wrongPoints +
      blank * AdmissionRules.blankPoints;

  /// Points as a percentage of the component maximum. It can be negative,
  /// because the penalty applies even when nothing is answered right.
  double get percent => total == 0 ? 0 : points / total * 100;
}

class ExamScore {
  const ExamScore(this.components);

  final Map<String, ComponentResult> components;

  int get correct => components.values.fold(0, (sum, c) => sum + c.correct);

  int get wrong => components.values.fold(0, (sum, c) => sum + c.wrong);

  int get blank => components.values.fold(0, (sum, c) => sum + c.blank);

  double get points => components.values.fold(0, (sum, c) => sum + c.points);

  /// Exam grade (0..100 scale) with the weights of a knowledge field.
  /// The university does not publish the scale of the grade, so the app shows
  /// it as a percentage of the maximum (documented as an assumption).
  double weightedPercent(KnowledgeField field) => field.weights.entries.fold(
        0,
        (sum, weight) => sum + weight.value / 100 * (components[weight.key]?.percent ?? 0),
      );
}

/// Scores a set of questions. [answers] maps question number → chosen label;
/// questions without an entry count as blank.
ExamScore scoreExam(List<Question> questions, Map<int, String> answers) {
  final counters = <String, List<int>>{};
  for (final q in questions) {
    final c = counters.putIfAbsent(q.areaCode, () => [0, 0, 0]);
    final chosen = answers[q.number];
    if (chosen == null) {
      c[2]++;
    } else if (q.isCorrect(chosen)) {
      c[0]++;
    } else {
      c[1]++;
    }
  }
  return ExamScore({
    for (final entry in counters.entries)
      entry.key: ComponentResult(
        areaCode: entry.key,
        correct: entry.value[0],
        wrong: entry.value[1],
        blank: entry.value[2],
      ),
  });
}
