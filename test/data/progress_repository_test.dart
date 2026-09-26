import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/data/app_database.dart';
import 'package:peuc/data/progress_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'progress_store_contract.dart';

void main() {
  sqfliteFfiInit();

  final opened = <Database>[];
  Future<Database> openDb() async {
    final db = await openAppDatabase(factory: databaseFactoryFfi, name: inMemoryDatabasePath);
    opened.add(db);
    return db;
  }

  tearDown(() async {
    for (final db in opened) {
      await db.close();
    }
    opened.clear();
  });

  group('schema', () {
    test('migrations create the schema at the latest version', () async {
      final db = await openDb();
      expect(await db.getVersion(), schemaVersion);
      final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type = 'table'");
      expect(tables.map((t) => t['name']), containsAll(['attempts', 'exam_sessions', 'bookmarks', 'settings']));
    });

    test('constraints reject invalid rows', () async {
      final db = await openDb();
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

    test('the SQLite store is persistent', () async {
      expect(ProgressRepository(await openDb()).persistent, isTrue);
    });
  });

  group('SQLite store contract', () {
    progressStoreContract(() async => ProgressRepository(await openDb()));
  });
}
