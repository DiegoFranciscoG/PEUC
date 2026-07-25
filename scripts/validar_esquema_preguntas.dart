import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  int totalErrors = 0;

  for (int i = 0; i < jsonList.length; i++) {
    final q = jsonList[i];
    final String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    if (!codigo.startsWith('4.')) continue;

    List<String> errors = [];

    // 1. ID
    if (q['id'] == null || q['id'].toString().trim().isEmpty) {
      errors.add('ID es nulo o vacío');
    }

    // 2. Enunciado
    final String enunciado = q['enunciado'] ?? '';
    if (enunciado.trim().isEmpty) {
      errors.add('Enunciado es nulo o vacío');
    }

    // 3. Opciones
    List<dynamic> opciones = [];
    if (q['opciones'] is String) {
      try {
        opciones = jsonDecode(q['opciones']);
      } catch (e) {
        errors.add('opciones es un string pero no se puede parsear como JSON: \$e');
      }
    } else if (q['opciones'] is List) {
      opciones = q['opciones'];
    } else {
      errors.add('opciones no es lista ni string JSON');
    }

    if (opciones.length != 4) {
      errors.add('Tiene \${opciones.length} opciones en lugar de 4');
    }

    bool hasEmptyOption = false;
    for (var op in opciones) {
      if (op == null || op.toString().trim().isEmpty) {
        hasEmptyOption = true;
      }
    }
    if (hasEmptyOption) {
      errors.add('Contiene opciones nulas o vacías');
    }

    // 4. Respuesta correcta
    final String respuestaCorrecta = q['respuesta_correcta'] ?? q['respuestaCorrecta'] ?? '';
    if (respuestaCorrecta.trim().isEmpty) {
      errors.add('Respuesta correcta es nula o vacía');
    } else {
      // Check if respuesta_correcta matches one of the options
      bool matchFound = false;
      for (var op in opciones) {
        if (op.toString().trim() == respuestaCorrecta.trim()) {
          matchFound = true;
          break;
        }
      }
      
      // Sometimes they prefix with "A) ", check for contains if exact match fails
      if (!matchFound) {
        for (var op in opciones) {
          String optStr = op.toString().trim();
          String ansStr = respuestaCorrecta.trim();
          if (optStr.contains(ansStr) || ansStr.contains(optStr)) {
            matchFound = true;
            break;
          }
        }
      }

      if (!matchFound) {
        errors.add('La respuesta correcta no coincide con ninguna de las opciones');
      }
    }

    if (errors.isNotEmpty) {
      final idStr = q['id'];
      print('=== ERROR EN PREGUNTA $codigo (índice $i, ID: $idStr) ===');
      for (var err in errors) {
        print('  - $err');
      }
      totalErrors++;
    }
  }

  print('');
  if (totalErrors == 0) {
    print('✅ Todos los objetos 4.x cumplen el esquema estricto.');
  } else {
    print('❌ Se encontraron $totalErrors preguntas con esquema inválido en Ciencias Sociales.');
  }
}
