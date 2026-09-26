import 'package:sqflite/sqflite.dart';

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

/// Local, private progress storage (no account, nothing leaves the device).
/// Only parameterised SQL is used.
class ProgressRepository {
  ProgressRepository(this._db, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final Database _db;
  final DateTime Function() _clock;

  Future<void> recordPracticeAnswer(Question question, String chosen) => _db.insert('attempts', {
        'question_number': question.number,
        'topic_code': question.topicCode,
        'area_code': question.areaCode,
        'chosen': chosen,
        'correct': question.isCorrect(chosen) ? 1 : 0,
        'mode': 'practice',
        'answered_at': _clock().toIso8601String(),
      });

  /// Saves a finished simulation and its answers in one transaction.
  /// Blank questions are not stored as attempts (they are neither right nor wrong).
  Future<int> saveExam({
    required List<Question> questions,
    required Map<int, String> answers,
    required DateTime startedAt,
    required Duration elapsed,
    required KnowledgeField field,
  }) {
    final score = scoreExam(questions, answers);
    return _db.transaction((txn) async {
      final sessionId = await txn.insert('exam_sessions', {
        'started_at': startedAt.toIso8601String(),
        'duration_seconds': elapsed.inSeconds,
        'field_code': field.code,
        'correct': score.correct,
        'wrong': score.wrong,
        'blank': score.blank,
        'points': score.points,
        'weighted_percent': score.weightedPercent(field),
      });
      final now = _clock().toIso8601String();
      final batch = txn.batch();
      for (final q in questions) {
        final chosen = answers[q.number];
        if (chosen == null) continue;
        batch.insert('attempts', {
          'question_number': q.number,
          'topic_code': q.topicCode,
          'area_code': q.areaCode,
          'chosen': chosen,
          'correct': q.isCorrect(chosen) ? 1 : 0,
          'mode': 'exam',
          'session_id': sessionId,
          'answered_at': now,
        });
      }
      await batch.commit(noResult: true);
      return sessionId;
    });
  }

  Future<ProgressSnapshot> snapshot() async {
    Map<String, Accuracy> grouped(List<Map<String, Object?>> rows, String key) => {
          for (final r in rows)
            r[key] as String: Accuracy(attempts: r['attempts'] as int, correct: (r['correct'] as int?) ?? 0),
        };

    final byTopic = await _db.rawQuery(
      'SELECT topic_code, COUNT(*) AS attempts, SUM(correct) AS correct FROM attempts GROUP BY topic_code',
    );
    final byArea = await _db.rawQuery(
      'SELECT area_code, COUNT(*) AS attempts, SUM(correct) AS correct FROM attempts GROUP BY area_code',
    );
    final latest = await _db.rawQuery(
      'SELECT a.question_number, a.correct FROM attempts a '
      'JOIN (SELECT question_number, MAX(id) AS last_id FROM attempts GROUP BY question_number) l '
      'ON a.id = l.last_id',
    );
    final bookmarks = await _db.query('bookmarks', columns: ['question_number']);
    final sessions = await _db.query('exam_sessions', orderBy: 'id DESC');

    return ProgressSnapshot(
      byTopic: grouped(byTopic, 'topic_code'),
      byArea: grouped(byArea, 'area_code'),
      seen: {for (final r in latest) r['question_number'] as int},
      lastWrong: {for (final r in latest) if (r['correct'] == 0) r['question_number'] as int},
      bookmarks: {for (final r in bookmarks) r['question_number'] as int},
      sessions: [
        for (final s in sessions)
          ExamSessionSummary(
            id: s['id'] as int,
            startedAt: DateTime.parse(s['started_at'] as String),
            duration: Duration(seconds: s['duration_seconds'] as int),
            fieldCode: s['field_code'] as String,
            correct: s['correct'] as int,
            wrong: s['wrong'] as int,
            blank: s['blank'] as int,
            points: (s['points'] as num).toDouble(),
            weightedPercent: (s['weighted_percent'] as num).toDouble(),
          ),
      ],
    );
  }

  Future<bool> toggleBookmark(int questionNumber) async {
    final removed = await _db.delete('bookmarks', where: 'question_number = ?', whereArgs: [questionNumber]);
    if (removed > 0) return false;
    await _db.insert('bookmarks', {
      'question_number': questionNumber,
      'created_at': _clock().toIso8601String(),
    });
    return true;
  }

  Future<Map<String, String>> settings() async => {
        for (final r in await _db.query('settings')) r['key'] as String: r['value'] as String,
      };

  Future<void> saveSetting(String key, String value) =>
      _db.insert('settings', {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);

  /// Deletes answers, simulations and bookmarks (settings are kept).
  Future<void> clearProgress() => _db.transaction((txn) async {
        await txn.delete('attempts');
        await txn.delete('exam_sessions');
        await txn.delete('bookmarks');
      });
}
