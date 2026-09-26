import 'dart:math';

import 'admission_rules.dart';
import 'models.dart';

/// Builds question sets for simulations and practice sessions.
class ExamBuilder {
  ExamBuilder([Random? random]) : _random = random ?? Random();

  final Random _random;

  /// Official structure: 12 questions per component, in the guide's order.
  /// Inside each component, topics are sampled in proportion to how many
  /// questions of the official bank belong to them (assumption: the
  /// university does not publish the per-topic distribution).
  List<Question> simulation(QuestionBank bank, {int perArea = AdmissionRules.questionsPerArea}) => [
        for (final area in AdmissionRules.areaOrder) ...areaSample(bank.byArea(area), perArea),
      ];

  List<Question> areaSample(List<Question> pool, int count) {
    final byTopic = <String, List<Question>>{};
    for (final q in pool) {
      byTopic.putIfAbsent(q.topicCode, () => []).add(q);
    }
    final quotas = allocateProportionally(
      {for (final e in byTopic.entries) e.key: e.value.length},
      count,
    );
    final picked = <Question>[];
    for (final entry in byTopic.entries) {
      final shuffled = [...entry.value]..shuffle(_random);
      picked.addAll(shuffled.take(quotas[entry.key] ?? 0));
    }
    return picked..shuffle(_random);
  }

  /// Largest remainder (Hamilton) method: every group gets the floor of its
  /// proportional share, and the seats left go to the largest remainders.
  /// No group receives more than its size.
  static Map<String, int> allocateProportionally(Map<String, int> sizes, int total) {
    final available = sizes.values.fold(0, (sum, v) => sum + v);
    final seats = min(max(total, 0), available);
    if (seats == 0) return {for (final k in sizes.keys) k: 0};

    final allocation = <String, int>{};
    final remainders = <String, double>{};
    for (final entry in sizes.entries) {
      final quota = seats * entry.value / available;
      allocation[entry.key] = quota.floor();
      remainders[entry.key] = quota - quota.floor();
    }
    var left = seats - allocation.values.fold(0, (sum, v) => sum + v);
    final order = sizes.keys.toList()
      ..sort((a, b) {
        final byRemainder = remainders[b]!.compareTo(remainders[a]!);
        if (byRemainder != 0) return byRemainder;
        final bySize = sizes[b]!.compareTo(sizes[a]!);
        return bySize != 0 ? bySize : a.compareTo(b);
      });
    while (left > 0) {
      var assigned = false;
      for (final key in order) {
        if (left == 0) break;
        if (allocation[key]! < sizes[key]!) {
          allocation[key] = allocation[key]! + 1;
          left--;
          assigned = true;
        }
      }
      if (!assigned) break;
    }
    return allocation;
  }

  /// Practice set that prioritises what the student needs most: questions
  /// answered wrong last time, then questions never seen, then the rest.
  List<Question> practiceSet(
    List<Question> pool,
    int count, {
    Set<int> seen = const {},
    Set<int> lastWrong = const {},
  }) {
    List<Question> group(bool Function(Question q) test) => pool.where(test).toList()..shuffle(_random);
    return [
      ...group((q) => lastWrong.contains(q.number)),
      ...group((q) => !seen.contains(q.number)),
      ...group((q) => seen.contains(q.number) && !lastWrong.contains(q.number)),
    ].take(count).toList();
  }
}
