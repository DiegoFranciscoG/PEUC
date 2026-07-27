import 'dart:io';
import 'dart:convert';
import 'dart:math';

// Levenshtein distance
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

class Stats {
  int total = 0;
  int exactDups = 0;
  int nearDups = 0;
  int codePegado = 0;
  int missingFields = 0;
}

void main() {
  final fileActual = File('assets/data/preguntas.json');
  final fileAnterior = File('assets/data/preguntas_backup.json'); // Extraído previamente de eab1be3

  final List listActual = jsonDecode(fileActual.readAsStringSync());
  final List listAnterior = jsonDecode(fileAnterior.readAsStringSync());

  // Funciones auxiliares
  final codeRegex = RegExp(r'\b[1-5]\.\d{1,2}\.\d{1,2}\b');
  
  void analizar(List data, String label, {bool printExamples = false}) {
    final Map<String, Map<String, Stats>> stats = {};
    final Map<String, Map<String, String>> seenEnunciados = {};
    final Map<String, Map<String, String>> normalizedEnunciados = {};

    List<String> exExact = [];
    List<String> exNear = [];
    List<String> exCode = [];
    List<String> exMissing = [];

    for (var item in data) {
      if (item is! Map) continue;

      final id = item['id']?.toString() ?? 'NO_ID';
      final materia = item['materia']?.toString() ?? 'HUERFANA';
      final codigo = item['codigo_tema']?.toString() ?? item['codigo_subtema']?.toString() ?? 'NO_CODIGO';
      final enunciado = item['enunciado']?.toString() ?? '';
      
      bool missing = false;
      if (!item.containsKey('id') || !item.containsKey('materia') || 
          (!item.containsKey('codigo_tema') && !item.containsKey('codigo_subtema')) || 
          !item.containsKey('enunciado') || !item.containsKey('opciones') || 
          !item.containsKey('respuesta_correcta')) {
        missing = true;
      }

      bool hasCode = codeRegex.hasMatch(enunciado);

      stats.putIfAbsent(materia, () => {});
      stats[materia]!.putIfAbsent(codigo, () => Stats());
      final s = stats[materia]![codigo]!;

      s.total++;
      if (missing) {
        s.missingFields++;
        if (exMissing.length < 3) exMissing.add('ID: $id | Faltan campos básicos (materia, código, etc)');
      }
      if (hasCode) {
        s.codePegado++;
        if (exCode.length < 3) exCode.add('ID: $id | Enunciado: "$enunciado"');
      }

      if (enunciado.isEmpty) continue;

      seenEnunciados.putIfAbsent(materia, () => {});
      normalizedEnunciados.putIfAbsent(materia, () => {});

      if (seenEnunciados[materia]!.containsKey(enunciado)) {
        s.exactDups++;
        if (exExact.length < 3) exExact.add('ID: $id | Duplica a: ${seenEnunciados[materia]![enunciado]} | Enunciado: "$enunciado"');
      } else {
        seenEnunciados[materia]![enunciado] = id;
        
        final norm = normalize(enunciado);
        bool isNear = false;
        for (final oldNorm in normalizedEnunciados[materia]!.keys) {
          final dist = levenshtein(norm, oldNorm);
          final maxLength = max(norm.length, oldNorm.length);
          if (maxLength > 0) {
            final sim = 1.0 - (dist / maxLength);
            if (sim > 0.90) {
              s.nearDups++;
              if (exNear.length < 3) exNear.add('ID: $id | Similitud ${(sim*100).toStringAsFixed(1)}% con ${normalizedEnunciados[materia]![oldNorm]} | Enunciado: "$enunciado"');
              isNear = true;
              break;
            }
          }
        }
        if (!isNear) {
          normalizedEnunciados[materia]![norm] = id;
        }
      }
    }

    print('\n=== $label ===');
    print('| Materia | Codigo | Total | Dup. Exactos | Dup. Casi Exactos | Codigo Pegado | Faltantes |');
    print('|---|---|---|---|---|---|---|');
    
    int gTotal = 0, gEx = 0, gNear = 0, gCod = 0, gMiss = 0;
    
    for (final m in stats.keys) {
      for (final c in stats[m]!.keys) {
        final s = stats[m]![c]!;
        print('| $m | $c | ${s.total} | ${s.exactDups} | ${s.nearDups} | ${s.codePegado} | ${s.missingFields} |');
        gTotal += s.total; gEx += s.exactDups; gNear += s.nearDups; gCod += s.codePegado; gMiss += s.missingFields;
      }
    }
    print('| **TOTAL** | | **$gTotal** | **$gEx** | **$gNear** | **$gCod** | **$gMiss** |');

    if (printExamples) {
      print('\n--- EJEMPLOS TEXTUALES ---');
      print('Duplicados Exactos:');
      exExact.forEach((e) => print('  - $e'));
      print('Duplicados Casi Exactos:');
      exNear.forEach((e) => print('  - $e'));
      print('Código Pegado en Enunciado:');
      exCode.forEach((e) => print('  - $e'));
      print('Campos Faltantes o Nulos:');
      exMissing.forEach((e) => print('  - $e'));
    }
  }

  analizar(listActual, 'DIAGNÓSTICO ACTUAL (preguntas.json)', printExamples: true);
  analizar(listAnterior, 'DIAGNÓSTICO ANTERIOR (commit eab1be3 - v1.0.0)');
}
