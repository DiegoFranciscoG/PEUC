import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../data/app_database.dart';
import '../data/bank_loader.dart';
import '../data/progress_repository.dart';
import '../domain/admission_rules.dart';
import '../domain/models.dart';
import '../domain/search.dart';

final bankProvider = FutureProvider<QuestionBank>((ref) => BankLoader().load());

final searchIndexProvider = FutureProvider<SearchIndex>(
  (ref) async => SearchIndex(await ref.watch(bankProvider.future)),
);

final databaseProvider = FutureProvider<Database>((ref) async {
  final db = await openAppDatabase();
  ref.onDispose(db.close);
  return db;
});

final progressRepositoryProvider = FutureProvider<ProgressRepository>(
  (ref) async => ProgressRepository(await ref.watch(databaseProvider.future)),
);

/// Re-read after every answer (the screens invalidate it).
final progressProvider = FutureProvider<ProgressSnapshot>(
  (ref) async => (await ref.watch(progressRepositoryProvider.future)).snapshot(),
);

class AppSettings {
  const AppSettings({this.shuffleOptions = true, this.fieldCode = 'M', this.career});

  final bool shuffleOptions;
  final String fieldCode;
  final String? career;

  KnowledgeField get field => fieldByCode(fieldCode);
}

class SettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    final stored = await (await ref.watch(progressRepositoryProvider.future)).settings();
    return AppSettings(
      shuffleOptions: stored['shuffle_options'] != 'false',
      fieldCode: stored['field_code'] ?? 'M',
      career: stored['career'],
    );
  }

  Future<void> setShuffleOptions(bool value) async {
    await (await ref.read(progressRepositoryProvider.future)).saveSetting('shuffle_options', '$value');
    final current = state.value ?? const AppSettings();
    state = AsyncData(AppSettings(shuffleOptions: value, fieldCode: current.fieldCode, career: current.career));
  }

  Future<void> setCareer(String career) async {
    final field = fieldOfCareer(career);
    if (field == null) return;
    final repository = await ref.read(progressRepositoryProvider.future);
    await repository.saveSetting('career', career);
    await repository.saveSetting('field_code', field.code);
    final current = state.value ?? const AppSettings();
    state = AsyncData(AppSettings(shuffleOptions: current.shuffleOptions, fieldCode: field.code, career: career));
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsController, AppSettings>(SettingsController.new);
