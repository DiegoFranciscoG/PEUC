import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Versioned schema migrations. Index i upgrades the schema from version i to
/// i + 1. Never edit a released migration: append a new one instead.
/// The question bank is NOT stored here (it is read-only content bundled as an
/// asset); this database only keeps the student's progress.
const List<List<String>> migrations = [
  // v1 — initial schema
  [
    '''CREATE TABLE exam_sessions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      started_at TEXT NOT NULL,
      duration_seconds INTEGER NOT NULL CHECK (duration_seconds >= 0),
      field_code TEXT NOT NULL,
      correct INTEGER NOT NULL CHECK (correct >= 0),
      wrong INTEGER NOT NULL CHECK (wrong >= 0),
      blank INTEGER NOT NULL CHECK (blank >= 0),
      points REAL NOT NULL,
      weighted_percent REAL NOT NULL
    )''',
    '''CREATE TABLE attempts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question_number INTEGER NOT NULL CHECK (question_number > 0),
      topic_code TEXT NOT NULL,
      area_code TEXT NOT NULL,
      chosen TEXT NOT NULL,
      correct INTEGER NOT NULL CHECK (correct IN (0, 1)),
      mode TEXT NOT NULL CHECK (mode IN ('practice', 'exam')),
      session_id INTEGER REFERENCES exam_sessions(id) ON DELETE CASCADE,
      answered_at TEXT NOT NULL
    )''',
    'CREATE INDEX idx_attempts_question ON attempts(question_number)',
    'CREATE INDEX idx_attempts_topic ON attempts(topic_code)',
    '''CREATE TABLE bookmarks(
      question_number INTEGER PRIMARY KEY CHECK (question_number > 0),
      created_at TEXT NOT NULL
    )''',
    '''CREATE TABLE settings(
      key TEXT PRIMARY KEY,
      value TEXT NOT NULL
    )''',
  ],
];

int get schemaVersion => migrations.length;

Future<void> migrate(Database db, int from, int to) async {
  for (var version = from; version < to; version++) {
    final batch = db.batch();
    for (final statement in migrations[version]) {
      batch.execute(statement);
    }
    await batch.commit(noResult: true);
  }
}

/// Opens (or creates and migrates) the progress database. On the web it uses
/// SQLite compiled to WebAssembly and persisted in IndexedDB.
Future<Database> openAppDatabase({DatabaseFactory? factory, String name = 'peuc.db'}) async {
  final dbFactory = factory ?? (kIsWeb ? databaseFactoryFfiWeb : databaseFactory);
  final path = kIsWeb || name == inMemoryDatabasePath ? name : p.join(await dbFactory.getDatabasesPath(), name);
  return dbFactory.openDatabase(
    path,
    options: OpenDatabaseOptions(
      version: schemaVersion,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) => migrate(db, 0, version),
      onUpgrade: migrate,
    ),
  );
}
