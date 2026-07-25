import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  for (var q in jsonList) {
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    if (codigo != '3.4.4') continue;
    String enunciado = q['enunciado'] ?? '';
    List<dynamic> opciones = q['opciones'] ?? [];
    
    bool hasEnunciadoPattern = enunciado.toLowerCase().contains('pregunta oficial del tema') ||
        enunciado.toLowerCase().contains('sobre ciencias sociales');
    
    for (var op in opciones) {
      String optStr = op.toString();
      if (optStr.toLowerCase().contains('incorrecta)')) {
        print('Opción que triggerea: $optStr');
        break;
      }
    }
    
    if (hasEnunciadoPattern) {
      print('ENUNCIADO PROBLEMA: $enunciado');
    }
  }
}
