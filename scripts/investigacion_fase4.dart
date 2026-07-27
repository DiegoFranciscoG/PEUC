import 'dart:io';
import 'dart:convert';
import 'dart:math';

int levenshtein(String s, String t) {
  if (s.isEmpty) return t.length;
  if (t.isEmpty) return s.length;
  List<int> v0 = List<int>.filled(t.length + 1, 0);
  List<int> v1 = List<int>.filled(t.length + 1, 0);
  for (int i = 0; i <= t.length; i++) v0[i] = i;
  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;
    for (int j = 0; j < t.length; j++) {
      int cost = (s[i] == t[j]) ? 0 : 1;
      v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
    }
    for (int j = 0; j <= t.length; j++) v0[j] = v1[j];
  }
  return v1[t.length];
}

String normalize(String text) {
  return text.toLowerCase()
      .replaceAll(RegExp(r'[áäâ]'), 'a')
      .replaceAll(RegExp(r'[éëê]'), 'e')
      .replaceAll(RegExp(r'[íïî]'), 'i')
      .replaceAll(RegExp(r'[óöô]'), 'o')
      .replaceAll(RegExp(r'[úüû]'), 'u')
      .replaceAll(RegExp(r'[^a-z0-9]'), '');
}

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  
  print('==== 1. PARES DE LENGUAJE (>90%) ====');
  final len = data.where((e) => e['materia'] == 'Lengua y Literatura').toList();
  int count = 0;
  for (int i = 0; i < len.length; i++) {
    for (int j = i + 1; j < len.length; j++) {
      final s1 = len[i]['enunciado'].toString();
      final s2 = len[j]['enunciado'].toString();
      final n1 = normalize(s1);
      final n2 = normalize(s2);
      final dist = levenshtein(n1, n2);
      final m = max(n1.length, n2.length);
      if (m > 0 && (1.0 - (dist / m)) > 0.90) {
        print('--- PAR ${count + 1} ---');
        print('Q1: $s1');
        print('Q2: $s2');
        count++;
        if (count >= 3) break;
      }
    }
    if (count >= 3) break;
  }

  print('\n==== 2. BUSCANDO SUBTEMAS HUÉRFANOS EN ARCHIVOS RAW ====');
  final targetCodes = [
    '3.1.1', '3.1.2', '3.1.3', '3.4.1', '3.6.1', '3.7.1',
    '4.1.1', '4.2.1', '4.3.1', '4.5.3', '4.6.1', '4.7.1', '4.9.1'
  ];

  final dirsToScan = [
    Directory('assets/data'),
    Directory('lotes_generados')
  ];

  final Map<String, List<String>> foundInFiles = {};
  for (var code in targetCodes) foundInFiles[code] = [];

  for (final dir in dirsToScan) {
    if (!dir.existsSync()) continue;
    final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.json'));
    for (final file in files) {
      if (file.path.contains('preguntas.json') || file.path.contains('preguntas_clean.json') || file.path.contains('preguntas_backup.json')) continue;
      
      try {
        final content = file.readAsStringSync();
        // Regex para buscar el código en el JSON ("codigo_tema": "3.1.1" o similar)
        for (var code in targetCodes) {
          if (content.contains(code)) {
             // Confirmar parseando si es posible
             try {
                final decoded = jsonDecode(content);
                List list = decoded is List ? decoded : (decoded is Map ? decoded['preguntas'] ?? [] : []);
                int matchCount = 0;
                for (var item in list) {
                  if (item is Map && (item['codigo_tema'] == code || item['codigo_subtema'] == code)) {
                    matchCount++;
                  }
                }
                if (matchCount > 0) {
                  foundInFiles[code]!.add('\${file.path} (\$matchCount encontradas)');
                }
             } catch(_) {
                foundInFiles[code]!.add('\${file.path} (Aparición de texto, no parseable)');
             }
          }
        }
      } catch (e) {}
    }
  }

  for (var code in targetCodes) {
    if (foundInFiles[code]!.isNotEmpty) {
      final text = foundInFiles[code]!.join(', ');
      print('Código $code -> $text');
    } else {
      print('Código $code -> NADA ENCONTRADO EN NINGÚN JSON CRUDO');
    }
  }
}
