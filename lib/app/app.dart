import 'package:flutter/material.dart';

import '../features/about/about_screen.dart';
import '../features/bank/question_detail_screen.dart';
import '../features/exam/exam_screen.dart';
import '../features/home/home_shell.dart';
import '../features/practice/practice_tab.dart';
import 'theme.dart';

class PeucApp extends StatelessWidget {
  const PeucApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P.E.U.C. — Banco oficial UCuenca 2026',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      onGenerateRoute: generateRoute,
    );
  }
}

/// Routes double as web links: #/pregunta/1234, #/banco, #/simulacro...
Route<void>? generateRoute(RouteSettings settings) {
  final segments = Uri.parse(settings.name ?? '/').pathSegments;
  final Widget? page = switch (segments) {
    [] => const HomeShell(),
    ['practicar'] => const HomeShell(initialTab: 1),
    ['banco'] => const HomeShell(initialTab: 2),
    ['progreso'] => const HomeShell(initialTab: 3),
    ['acerca'] => const AboutScreen(),
    ['simulacro'] => const ExamScreen(),
    ['area', final code] => AreaScreen(areaCode: code.toUpperCase()),
    ['pregunta', final n] when int.tryParse(n) != null => QuestionDetailScreen(number: int.parse(n)),
    _ => null,
  };
  if (page == null) return null;
  return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
}
