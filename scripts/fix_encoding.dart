import 'dart:io';
import 'dart:convert';

void main() async {
  final fixes = {
    'Ã¡': 'á', 'Ã©': 'é', 'Ã­': 'í', 'Ã³': 'ó', 'Ãº': 'ú',
    'Ã±': 'ñ', 'Ã\u0081': 'Á', 'Ã\u0089': 'É', 'Ã\u008d': 'Í',
    'Ã\u0093': 'Ó', 'Ã\u009a': 'Ú', 'Ã\u0091': 'Ñ',
    'Â¿': '¿', 'Â¡': '¡', 'Ã\u00bc': 'ü', 'Ã\u00b6': 'ö',
    'â€™': '\u2019', 'â€œ': '\u201c', 'â€\u009d': '\u201d',
    'â€"': '\u2013', 'â€"': '\u2014', 'â€¦': '\u2026',
  };

  final paths = [
    'assets/data/preguntas.json',
    'assets/data/teoria.json',
  ];

  for (final path in paths) {
    final file = File(path);
    if (!file.existsSync()) {
      print('Skipping (not found): $path');
      continue;
    }

    var content = file.readAsStringSync(encoding: utf8);
    int totalFixes = 0;

    for (final entry in fixes.entries) {
      final count = entry.key.allMatches(content).length;
      if (count > 0) {
        print('  [${path.split('/').last}] "${entry.key}" -> "${entry.value}" ($count times)');
        totalFixes += count;
        content = content.replaceAll(entry.key, entry.value);
      }
    }

    if (totalFixes > 0) {
      // Re-parse and re-serialize to normalize JSON
      try {
        final decoded = jsonDecode(content);
        final fixed = const JsonEncoder.withIndent('  ').convert(decoded);
        file.writeAsStringSync(fixed, encoding: utf8);
        print('✅ Fixed $totalFixes characters in $path');
      } catch (e) {
        // If JSON is broken, just write the string-replaced version
        file.writeAsStringSync(content, encoding: utf8);
        print('⚠️  Saved raw (JSON re-parse failed): $e');
      }
    } else {
      print('✅ No encoding issues found in $path');
    }
  }

  print('\nDone! All files cleaned.');
}
