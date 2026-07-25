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
  
  List<dynamic> basura = [];
  List<dynamic> limpias = [];
  Map<String, int> conteoBasuraPorSubtema = {};
  Map<String, int> conteoLimpiasPorSubtema = {};
  
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
    
    String codigo = q['codigoTema'] ?? q['codigo_tema'] ?? '';
    if (esBasura) {
      basura.add(q);
      conteoBasuraPorSubtema[codigo] = (conteoBasuraPorSubtema[codigo] ?? 0) + 1;
    } else {
      limpias.add(q);
      conteoLimpiasPorSubtema[codigo] = (conteoLimpiasPorSubtema[codigo] ?? 0) + 1;
    }
  }
  
  Map<String, dynamic> reporte = {
    'total_preguntas': data.length,
    'total_basura': basura.length,
    'total_limpias': limpias.length,
    'basura_por_subtema': conteoBasuraPorSubtema,
    'limpias_por_subtema': conteoLimpiasPorSubtema,
    'pendientes_de_contenido': conteoLimpiasPorSubtema.entries.where((e) => e.value < 15).map((e) => e.key).toList(),
  };
  
  File('auditoria_preguntas_basura.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(reporte));
  print('Auditoría completada. Revisar auditoria_preguntas_basura.json');
}
