import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  Map<String, int> errorCounts = {};

  for (int i = 0; i < jsonList.length; i++) {
    final q = jsonList[i];
    final String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    if (!codigo.startsWith('4.')) continue;

    bool hasError = false;

    final String enunciado = q['enunciado'] ?? '';
    if (enunciado.trim().isEmpty) hasError = true;

    List<dynamic> opciones = [];
    if (q['opciones'] is String) {
      try { opciones = jsonDecode(q['opciones']); } catch (e) {}
    } else if (q['opciones'] is List) {
      opciones = q['opciones'];
    }
    if (opciones.length != 4) hasError = true;

    final String respuestaCorrecta = q['respuesta_correcta'] ?? q['respuestaCorrecta'] ?? '';
    if (respuestaCorrecta.trim().isEmpty) {
      hasError = true;
    } else {
      bool matchFound = false;
      for (var op in opciones) {
        if (op.toString().trim() == respuestaCorrecta.trim() || 
            op.toString().trim().contains(respuestaCorrecta.trim()) || 
            respuestaCorrecta.trim().contains(op.toString().trim())) {
          matchFound = true;
          break;
        }
      }
      if (!matchFound) hasError = true;
    }

    if (hasError) {
      errorCounts[codigo] = (errorCounts[codigo] ?? 0) + 1;
    }
  }

  print('Errores por código:');
  for (var k in errorCounts.keys) {
    print('  $k: ${errorCounts[k]}');
  }
}
