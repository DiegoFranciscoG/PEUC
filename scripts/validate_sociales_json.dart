import 'dart:convert';
import 'dart:io';

void main() {
  // 1. Validate preguntas.json - extract 4.x entries and validate each individually
  print('=== VALIDANDO preguntas.json ===');
  _validateFile('assets/data/preguntas.json', '4.');
  
  print('\n=== VALIDANDO teoria.json ===');
  _validateFile('assets/data/teoria.json', '4.');
}

void _validateFile(String path, String prefix) {
  if (!File(path).existsSync()) {
    print('ERROR: Archivo no encontrado: $path');
    return;
  }

  final String content = File(path).readAsStringSync();
  
  // First validate the whole file
  List<dynamic> all;
  try {
    all = jsonDecode(content);
    print('✅ Parseo completo del archivo OK (${all.length} entradas)');
  } catch (e) {
    print('❌ ERROR DE PARSEO EN EL ARCHIVO COMPLETO: $e');
    return;
  }
  
  // Now isolate 4.x entries and validate each one individually
  int errors = 0;
  for (var entry in all) {
    String codigo = entry['codigo_tema'] ?? entry['codigo'] ?? entry['codigoTema'] ?? '';
    if (!codigo.startsWith(prefix)) continue;
    
    // Re-serialize and re-parse to detect encoding issues at object level
    try {
      final String serialized = jsonEncode(entry);
      final reparsed = jsonDecode(serialized);
      
      // Check for unescaped backslashes in string fields
      _checkBackslashes(entry, codigo);
      
    } catch (e) {
      print('❌ ERROR en código $codigo: $e');
      errors++;
    }
  }
  
  if (errors == 0) {
    print('✅ Todos los objetos 4.x validan correctamente.');
  } else {
    print('❌ Total de objetos con errores: $errors');
  }
}

void _checkBackslashes(dynamic entry, String codigo) {
  // Check all string values for bare backslashes that aren't valid JSON escapes
  // A bare \n, \t, \r inside a JSON value is fine (they're valid escapes)
  // A bare \f, \v or any \X where X is not a valid escape char is problematic
  // The most common issue is \frac, \sum, \int etc. in LaTeX that were NOT escaped

  if (entry is Map) {
    for (var key in entry.keys) {
      final val = entry[key];
      if (val is String) {
        _checkStringForBareBackslash(val, codigo, key.toString());
      } else if (val is List) {
        for (int i = 0; i < val.length; i++) {
          if (val[i] is String) {
            _checkStringForBareBackslash(val[i], codigo, '$key[$i]');
          }
        }
      }
    }
  }
}

void _checkStringForBareBackslash(String val, String codigo, String field) {
  // The raw string in Dart (after jsonDecode) will have actual backslashes
  // We look for single backslashes followed by a letter that's not a valid LaTeX escape
  // Already decoded: \\n became \n, \\t became \t, but \f\r\a\c\{} etc. are suspicious
  // In LaTeX context, we'd see things like \frac, \sum, etc.
  // These should be stored as \\frac, \\sum in the JSON source
  
  // After jsonDecode, if the source had \\frac it becomes \frac (one backslash) - that's correct
  // If the source had \frac (bare) the jsonDecode would have failed or treated it as unknown escape
  
  // So if we see \f, \s, \i etc. after decode, it might indicate the original had \\frac
  // which decoded correctly to \frac - this is actually fine for LaTeX rendering
  
  // The real problem would be if jsonDecode itself failed, which we already tested above
  // So we'll just report fields that contain backslashes for manual review
  if (val.contains('\\')) {
    // Count backslash occurrences
    final count = '\\'.allMatches(val).length;
    if (count > 0) {
      print('  ℹ️  $codigo > $field: contiene $count barra(s) invertida(s) — verificando...');
      // Show a snippet around the backslash
      final idx = val.indexOf('\\');
      final start = idx > 20 ? idx - 20 : 0;
      final end = idx + 30 < val.length ? idx + 30 : val.length;
      print('     Contexto: ...${val.substring(start, end)}...');
    }
  }
}
