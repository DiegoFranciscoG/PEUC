import '../domain/admission_rules.dart';
import '../domain/models.dart';
import '../domain/scoring.dart';

class Accuracy {
  const Accuracy({required this.attempts, required this.correct});

  final int attempts;
  final int correct;

  double get ratio => attempts == 0 ? 0 : correct / attempts;
}

class ExamSessionSummary {
  const ExamSessionSummary({
    required this.id,
    required this.startedAt,
    required this.duration,
    required this.fieldCode,
    required this.correct,
    required this.wrong,
    required this.blank,
    required this.points,
    required this.weightedPercent,
  });

  final int id;
  final DateTime startedAt;
  final Duration duration;
  final String fieldCode;
  final int correct;
  final int wrong;
  final int blank;
  final double points;
  final double weightedPercent;
}

/// Everything the dashboards need, read in one go.
class ProgressSnapshot {
  const ProgressSnapshot({
    required this.byTopic,
    required this.byArea,
    required this.seen,
    required this.lastWrong,
    required this.bookmarks,
    required this.sessions,
  });

  static const empty = ProgressSnapshot(
    byTopic: {},
    byArea: {},
    seen: {},
    lastWrong: {},
    bookmarks: {},
    sessions: [],
  );

  final Map<String, Accuracy> byTopic;
  final Map<String, Accuracy> byArea;

  /// Questions answered at least once.
  final Set<int> seen;

  /// Questions whose most recent answer was wrong.
  final Set<int> lastWrong;
  final Set<int> bookmarks;

  /// Most recent first.
  final List<ExamSessionSummary> sessions;

  Accuracy get overall => byArea.values.fold(
        const Accuracy(attempts: 0, correct: 0),
        (sum, a) => Accuracy(attempts: sum.attempts + a.attempts, correct: sum.correct + a.correct),
      );
}

/// Where the student's progress lives. The SQLite implementation persists it;
/// [MemoryProgressStore] keeps the app usable when the browser blocks storage
/// (private mode, storage disabled or full).
abstract interface class ProgressStore {
  /// False when progress is only kept until the app is closed.
  bool get persistent;

  Future<void> recordPracticeAnswer(Question question, String chosen);

  /// Saves a finished simulation. Blank questions are not stored as attempts
  /// (they are neither right nor wrong).
  Future<int> saveExam({
    required List<Question> questions,
    required Map<int, String> answers,
    required DateTime startedAt,
    required Duration elapsed,
    required KnowledgeField field,
  });

  Future<ProgressSnapshot> snapshot();

  /// Returns true when the question ends up bookmarked.
  Future<bool> toggleBookmark(int questionNumber);

  Future<Map<String, String>> settings();

  Future<void> saveSetting(String key, String value);

  /// Deletes answers, simulations and bookmarks (settings are kept).
  Future<void> clearProgress();
}

class _Attempt {
  const _Attempt(this.question, this.correct);

  final Question question;
  final bool correct;
}

/// Non-persistent fallback with the same behaviour as the SQLite store.
class MemoryProgressStore implements ProgressStore {
  final List<_Attempt> _attempts = [];
  final List<ExamSessionSummary> _sessions = [];
  final Set<int> _bookmarks = {};
  final Map<String, String> _settings = {};

  @override
  bool get persistent => false;

  @override
  Future<void> recordPracticeAnswer(Question question, String chosen) async =>
      _attempts.add(_Attempt(question, question.isCorrect(chosen)));

  @override
  Future<int> saveExam({
    required List<Question> questions,
    required Map<int, String> answers,
    required DateTime startedAt,
    required Duration elapsed,
    required KnowledgeField field,
  }) async {
    final score = scoreExam(questions, answers);
    final id = _sessions.length + 1;
    _sessions.add(ExamSessionSummary(
      id: id,
      startedAt: startedAt,
      duration: elapsed,
      fieldCode: field.code,
      correct: score.correct,
      wrong: score.wrong,
      blank: score.blank,
      points: score.points,
      weightedPercent: score.weightedPercent(field),
    ));
    for (final q in questions) {
      final chosen = answers[q.number];
      if (chosen != null) _attempts.add(_Attempt(q, q.isCorrect(chosen)));
    }
    return id;
  }

  @override
  Future<ProgressSnapshot> snapshot() async {
    Map<String, Accuracy> grouped(String Function(Question q) key) {
      final result = <String, Accuracy>{};
      for (final a in _attempts) {
        final k = key(a.question);
        final current = result[k] ?? const Accuracy(attempts: 0, correct: 0);
        result[k] = Accuracy(attempts: current.attempts + 1, correct: current.correct + (a.correct ? 1 : 0));
      }
      return result;
    }

    final latest = <int, bool>{};
    for (final a in _attempts) {
      latest[a.question.number] = a.correct;
    }
    return ProgressSnapshot(
      byTopic: grouped((q) => q.topicCode),
      byArea: grouped((q) => q.areaCode),
      seen: latest.keys.toSet(),
      lastWrong: {for (final e in latest.entries) if (!e.value) e.key},
      bookmarks: Set.of(_bookmarks),
      sessions: _sessions.reversed.toList(),
    );
  }

  @override
  Future<bool> toggleBookmark(int questionNumber) async {
    if (_bookmarks.remove(questionNumber)) return false;
    _bookmarks.add(questionNumber);
    return true;
  }

  @override
  Future<Map<String, String>> settings() async => Map.of(_settings);

  @override
  Future<void> saveSetting(String key, String value) async => _settings[key] = value;

  @override
  Future<void> clearProgress() async {
    _attempts.clear();
    _sessions.clear();
    _bookmarks.clear();
  }
}
