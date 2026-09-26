import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/data/progress_store.dart';
import 'package:peuc/domain/admission_rules.dart';

import '../support/fixtures.dart';

/// Behaviour every [ProgressStore] must share (SQLite and in-memory).
void progressStoreContract(Future<ProgressStore> Function() create) {
  late ProgressStore store;

  setUp(() async => store = await create());

  test('an empty store gives an empty snapshot', () async {
    final snapshot = await store.snapshot();
    expect(snapshot.seen, isEmpty);
    expect(snapshot.overall.attempts, 0);
    expect(snapshot.overall.ratio, 0);
  });

  test('practice answers feed accuracy, seen and last-wrong sets', () async {
    final q1 = testQuestion(1, answer: 'b');
    final q2 = testQuestion(2, answer: 'b', topic: '2.1.1', area: 'LEN');

    await store.recordPracticeAnswer(q1, 'a'); // wrong
    await store.recordPracticeAnswer(q2, 'b'); // right
    var snapshot = await store.snapshot();
    expect(snapshot.seen, {1, 2});
    expect(snapshot.lastWrong, {1});
    expect(snapshot.byArea['MAT']!.ratio, 0);
    expect(snapshot.byTopic['2.1.1']!.ratio, 1);

    await store.recordPracticeAnswer(q1, 'b'); // now right
    snapshot = await store.snapshot();
    expect(snapshot.lastWrong, isEmpty);
    expect(snapshot.byTopic['1.1.1']!.attempts, 2);
    expect(snapshot.overall.correct, 2);
  });

  test('saving an exam stores the session and only the answered questions', () async {
    final bank = testBank();
    final questions = [for (final code in AdmissionRules.areaOrder) ...bank.byArea(code).take(12)];
    final answers = {for (final q in questions.take(30)) q.number: q.answer};

    final id = await store.saveExam(
      questions: questions,
      answers: answers,
      startedAt: DateTime(2026, 9, 26, 10),
      elapsed: const Duration(minutes: 42),
      field: fieldByCode('M'),
    );

    final snapshot = await store.snapshot();
    expect(id, greaterThan(0));
    expect(snapshot.sessions.single.correct, 30);
    expect(snapshot.sessions.single.blank, 30);
    expect(snapshot.sessions.single.duration, const Duration(minutes: 42));
    // Mathematics (45 %) and Language (10 %) complete, Social Sciences (10 %) half.
    expect(snapshot.sessions.single.weightedPercent, closeTo(45 + 10 + 10 / 2, 1e-9));
    expect(snapshot.seen.length, 30);
  });

  test('sessions are listed most recent first', () async {
    final questions = testBank().byArea('MAT').take(12).toList();
    for (final minutes in [10, 20]) {
      await store.saveExam(
        questions: questions,
        answers: const {},
        startedAt: DateTime(2026, 9, 26, 10, minutes),
        elapsed: Duration(minutes: minutes),
        field: fieldByCode('CN'),
      );
    }
    final sessions = (await store.snapshot()).sessions;
    expect(sessions.first.duration, const Duration(minutes: 20));
  });

  test('bookmarks toggle on and off', () async {
    expect(await store.toggleBookmark(5), isTrue);
    expect((await store.snapshot()).bookmarks, {5});
    expect(await store.toggleBookmark(5), isFalse);
    expect((await store.snapshot()).bookmarks, isEmpty);
  });

  test('settings are upserted', () async {
    await store.saveSetting('field_code', 'CN');
    await store.saveSetting('field_code', 'MCN');
    expect(await store.settings(), {'field_code': 'MCN'});
  });

  test('clearing progress keeps settings', () async {
    await store.recordPracticeAnswer(testQuestion(1), 'a');
    await store.toggleBookmark(1);
    await store.saveSetting('career', 'Medicina');

    await store.clearProgress();
    final snapshot = await store.snapshot();
    expect(snapshot.seen, isEmpty);
    expect(snapshot.bookmarks, isEmpty);
    expect(await store.settings(), {'career': 'Medicina'});
  });
}
