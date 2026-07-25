import 'dart:convert';
import 'dart:io';

void main() {
  final fileTemario = File('temario_maestro.json');
  final temario = jsonDecode(fileTemario.readAsStringSync()) as List<dynamic>;
  Set<String> codigosOficiales = temario.map((t) => t['codigo'].toString().trim()).toSet();

  // 1. Limpiar preguntas.json
  final filePreguntas = File('assets/data/preguntas.json');
  final preguntas = jsonDecode(filePreguntas.readAsStringSync()) as List<dynamic>;
  
  List<Map<String, dynamic>> preguntasLimpias = [];
  for (var p in preguntas) {
    Map<String, dynamic> q = Map<String, dynamic>.from(p);
    
    // Normalizar llave
    String codigo = (q['codigo_tema'] ?? q['codigoTema'])?.toString().trim() ?? '';
    
    // Eliminar llave antigua y asegurar codigo_tema
    q.remove('codigoTema');
    q['codigo_tema'] = codigo;
    
    if (codigosOficiales.contains(codigo)) {
      preguntasLimpias.add(q);
    }
  }
  
  filePreguntas.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(preguntasLimpias));
  print('preguntas.json limpiado. Quedan ${preguntasLimpias.length} preguntas válidas.');

  // 2. Limpiar teoria.json
  final fileTeoria = File('assets/data/teoria.json');
  final teoria = jsonDecode(fileTeoria.readAsStringSync()) as List<dynamic>;
  
  List<Map<String, dynamic>> teoriaLimpia = [];
  for (var t in teoria) {
    Map<String, dynamic> q = Map<String, dynamic>.from(t);
    
    String codigo = (q['codigo_tema'] ?? q['codigoTema'])?.toString().trim() ?? '';
    q.remove('codigoTema');
    q['codigo_tema'] = codigo;
    
    if (codigosOficiales.contains(codigo)) {
      teoriaLimpia.add(q);
    }
  }
  
  fileTeoria.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(teoriaLimpia));
  print('teoria.json limpiado. Quedan ${teoriaLimpia.length} entradas válidas.');
}
