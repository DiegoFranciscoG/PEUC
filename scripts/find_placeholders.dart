import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  for (var q in jsonList) {
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    String enunciado = q['enunciado'] ?? '';
    List<dynamic> opciones = q['opciones'] ?? [];
    bool isPlaceholder = false;
    if (enunciado.toLowerCase().contains('pregunta oficial del tema') ||
        enunciado.toLowerCase().contains('sobre ciencias sociales')) {
      isPlaceholder = true;
    }
    for (var op in opciones) {
      String optStr = op.toString().toLowerCase();
      if (optStr.contains('opción a (correcta)') || 
          optStr.contains('opción b (incorrecta)') ||
          optStr.contains('opcion a (correcta)') ||
          optStr.contains('incorrecta)')) {
        isPlaceholder = true;
      }
    }
    if (isPlaceholder) {
      print('PLACEHOLDER en $codigo: ${enunciado.substring(0, enunciado.length > 80 ? 80 : enunciado.length)}');
    }
  }
}
