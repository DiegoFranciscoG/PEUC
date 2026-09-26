import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/app/app.dart';
import 'package:peuc/data/app_database.dart';
import 'package:peuc/features/practice/practice_screen.dart';
import 'package:peuc/state/providers.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../support/fixtures.dart';

void main() {
  sqfliteFfiInit();
  late Database db;

  setUp(() async {
    db = await openAppDatabase(factory: databaseFactoryFfiNoIsolate, name: inMemoryDatabasePath);
  });

  tearDown(() => db.close());

  Widget app({Widget? home}) => ProviderScope(
        overrides: [
          bankProvider.overrideWith((ref) async => testBank()),
          databaseProvider.overrideWith((ref) async => db),
        ],
        child: home == null ? const PeucApp() : MaterialApp(home: home),
      );

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
      await tester.pump();
    }
    await tester.pumpAndSettle();
  }

  testWidgets('dashboard shows the bank and the official exam card', (tester) async {
    await tester.pumpWidget(app());
    await settle(tester);

    expect(find.text('Banco oficial 2026'), findsOneWidget);
    expect(find.text('Simulacro oficial'), findsOneWidget);
    expect(find.text('Ponderación de tu carrera'), findsOneWidget);
  });

  testWidgets('tabs navigate to practice, bank search and progress', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(app());
    await settle(tester);

    await tester.tap(find.text('Practicar'));
    await settle(tester);
    expect(find.text('Practica por componente'), findsOneWidget);
    expect(find.text('Razonamiento Abstracto'), findsOneWidget);

    await tester.tap(find.text('Banco'));
    await settle(tester);
    await tester.enterText(find.byType(TextField), '21');
    await settle(tester);
    expect(find.textContaining('#21 ·'), findsOneWidget);

    await tester.tap(find.text('Progreso'));
    await settle(tester);
    expect(find.text('Aciertos por componente'), findsOneWidget);
  });

  testWidgets('practice shows immediate feedback with the justification', (tester) async {
    final questions = testBank().byArea('LEN').take(2).toList();
    await tester.pumpWidget(app(home: PracticeScreen(title: 'Prueba', questions: questions)));
    await settle(tester);

    final semantics = tester.ensureSemantics();
    await tester.tap(find.bySemanticsLabel(RegExp('^Opción a')));
    await settle(tester);
    semantics.dispose();

    expect(find.textContaining('Justificación ${questions.first.number}'), findsOneWidget);
    expect(find.text('Siguiente'), findsOneWidget);
    expect((await db.query('attempts')).length, 1);
  });

  testWidgets('a simulation can be finished and scored', (tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(app());
    await settle(tester);
    await tester.tap(find.text('Empezar simulacro'));
    await settle(tester);

    expect(find.textContaining('Pregunta 1 de 60'), findsOneWidget);
    final semantics = tester.ensureSemantics();
    await tester.tap(find.bySemanticsLabel(RegExp('^Opción a')));
    await tester.pump();
    semantics.dispose();

    await tester.tap(find.text('Finalizar').first);
    await settle(tester);
    expect(find.text('¿Finalizar el simulacro?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Finalizar'));
    await settle(tester);

    expect(find.text('Nota estimada del examen'), findsOneWidget);
    expect((await db.query('exam_sessions')).single['blank'], 59);
  });

  testWidgets('when storage is blocked the app falls back to memory and warns', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        bankProvider.overrideWith((ref) async => testBank()),
        databaseProvider.overrideWith((ref) => Future<Database>.error(StateError('IndexedDB bloqueado'))),
      ],
      child: const PeucApp(),
    ));
    await settle(tester);

    expect(find.text('Tu progreso no se guardará'), findsOneWidget);
    expect(find.text('Banco oficial 2026'), findsOneWidget);
  });

  test('routes map web links to screens', () {
    expect(generateRoute(const RouteSettings(name: '/pregunta/15')), isNotNull);
    expect(generateRoute(const RouteSettings(name: '/pregunta/abc')), isNull);
    expect(generateRoute(const RouteSettings(name: '/area/mat')), isNotNull);
    expect(generateRoute(const RouteSettings(name: '/no-existe')), isNull);
  });
}
