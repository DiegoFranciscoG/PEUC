import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/data/app_database.dart';
import 'package:peuc/data/progress_repository.dart';
import 'package:peuc/domain/admission_rules.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../support/fixtures.dart';

void main() {
  sqfliteFfiInit();

  late Database db;
  late ProgressRepository repository;
  var now = DateTime(2026, 9, 26, 10);

  setUp(() async {
    db = await openAppDatabase(factory: databaseFactoryFfi, name: inMemoryDatabasePath);
    repository = ProgressRepository(db, clock: () => now);
  });

  tearDown(() => db.close());

  test('migrations create the schema at the latest version', () async {
    expect(await db.getVersion(), schemaVersion);
    final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type = 'table'");
    expect(tables.map((t) => t['name']), containsAll(['attempts', 'exam_sessions', 'bookmarks', 'settings']));
  });

  test('constraints reject invalid rows', () async {
    await expectLater(
      db.insert('attempts', {
        'question_number': 1,
        'topic_code': '1.1.1',
        'area_code': 'MAT',
        'chosen': 'a',
        'correct': 2,
        'mode': 'practice',
        'answered_at': 'x',
      }),
      throwsA(isA<DatabaseException>()),
    );
  });

  test('an empty database gives an empty snapshot', () async {
    final snapshot = await repository.snapshot();
    expect(snapshot.seen, isEmpty);
    expect(snapshot.overall.attempts, 0);
    expect(snapshot.overall.ratio, 0);
  });

  test('practice answers feed accuracy, seen and last-wrong sets', () async {
    final q1 = testQuestion(1, answer: 'b');
    final q2 = testQuestion(2, answer: 'b', topic: '2.1.1', area: 'LEN');

    await repository.recordPracticeAnswer(q1, 'a'); // wrong
    await repository.recordPracticeAnswer(q2, 'b'); // right
    var snapshot = await repository.snapshot();
    expect(snapshot.seen, {1, 2});
    expect(snapshot.lastWrong, {1});
    expect(snapshot.byArea['MAT']!.ratio, 0);
    expect(snapshot.byTopic['2.1.1']!.ratio, 1);

    await repository.recordPracticeAnswer(q1, 'b'); // now right
    snapshot = await repository.snapshot();
    expect(snapshot.lastWrong, isEmpty);
    expect(snapshot.byTopic['1.1.1']!.attempts, 2);
    expect(snapshot.overall.correct, 2);
  });

  test('saving an exam stores the session and only the answered questions', () async {
    final bank = testBank();
    final questions = [for (final code in AdmissionRules.areaOrder) ...bank.byArea(code).take(12)];
    final answers = {for (final q in questions.take(30)) q.number: q.answer};

    final id = await repository.saveExam(
      questions: questions,
      answers: answers,
      startedAt: now,
      elapsed: const Duration(minutes: 42),
      field: fieldByCode('M'),
    );

    final snapshot = await repository.snapshot();
    expect(id, greaterThan(0));
    expect(snapshot.sessions.single.correct, 30);
    expect(snapshot.sessions.single.blank, 30);
    expect(snapshot.sessions.single.duration, const Duration(minutes: 42));
    expect(snapshot.sessions.single.weightedPercent, closeTo(45 + 10 + 10 / 2, 1e-9));
    expect(snapshot.seen.length, 30);
  });

  test('bookmarks toggle on and off', () async {
    expect(await repository.toggleBookmark(5), isTrue);
    expect((await repository.snapshot()).bookmarks, {5});
    expect(await repository.toggleBookmark(5), isFalse);
    expect((await repository.snapshot()).bookmarks, isEmpty);
  });

  test('settings are upserted', () async {
    await repository.saveSetting('field_code', 'CN');
    await repository.saveSetting('field_code', 'MCN');
    expect(await repository.settings(), {'field_code': 'MCN'});
  });

  test('clearing progress keeps settings', () async {
    await repository.recordPracticeAnswer(testQuestion(1), 'a');
    await repository.toggleBookmark(1);
    await repository.saveSetting('career', 'Medicina');
    now = now.add(const Duration(minutes: 1));

    await repository.clearProgress();
    final snapshot = await repository.snapshot();
    expect(snapshot.seen, isEmpty);
    expect(snapshot.bookmarks, isEmpty);
    expect(await repository.settings(), {'career': 'Medicina'});
  });
}
