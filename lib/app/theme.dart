import 'package:flutter/material.dart';

const Color _seed = Color(0xFF2B5BA7);

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(backgroundColor: scheme.surface, centerTitle: false, scrolledUnderElevation: 1),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHigh,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
    ),
    listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.symmetric(horizontal: 16)),
  );
}

/// Colours that stay readable in light and dark mode for right/wrong feedback.
extension FeedbackColors on ColorScheme {
  Color get success => brightness == Brightness.light ? const Color(0xFF1E7B34) : const Color(0xFF7FD493);

  Color get successContainer =>
      brightness == Brightness.light ? const Color(0xFFD5F2DA) : const Color(0xFF14391D);
}

/// Icon and colour of each exam component.
abstract final class AreaStyle {
  static IconData icon(String areaCode) => switch (areaCode) {
        'MAT' => Icons.functions,
        'LEN' => Icons.menu_book_outlined,
        'CNA' => Icons.science_outlined,
        'CSO' => Icons.public,
        _ => Icons.extension_outlined,
      };

  static Color color(String areaCode) => switch (areaCode) {
        'MAT' => const Color(0xFF3A6FD8),
        'LEN' => const Color(0xFF8E4FC9),
        'CNA' => const Color(0xFF23936A),
        'CSO' => const Color(0xFFD27A24),
        _ => const Color(0xFFC0447B),
      };
}
