import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  List<dynamic> data = jsonDecode(content);
  
  final regexes = [
    RegExp(r'Pregunta Académica Nro\.?\s*\d+', caseSensitive: false),
    RegExp(r'principios fundamentales de (el|la|los|las)?\s*(tema|el tema)', caseSensitive: false),
    RegExp(r'afirmación fundamentada en los principios teóricos', caseSensitive: false),
    RegExp(r'postulado incorrecto que contradice', caseSensitive: false),
    RegExp(r'hipótesis descartada por la comunidad científica', caseSensitive: false),
    RegExp(r'aseveración que confunde los conceptos', caseSensitive: false),
  ];
  
  List<dynamic> limpias = [];
  int purgados = 0;
  
  for (var q in data) {
    bool esBasura = false;
    String enunciado = q['enunciado'] ?? '';
    String opcionesStr = (q['opciones'] != null && q['opciones'] is List) ? q['opciones'].join(' ') : '';
    String fullText = '$enunciado $opcionesStr';
    
    for (var regex in regexes) {
      if (regex.hasMatch(fullText)) {
        esBasura = true;
        break;
      }
    }
    
    if (esBasura) {
      purgados++;
    } else {
      limpias.add(q);
    }
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(limpias));
  print('Purga completada. Se eliminaron $purgados reactivos basura. Quedan ${limpias.length} preguntas reales.');
}
