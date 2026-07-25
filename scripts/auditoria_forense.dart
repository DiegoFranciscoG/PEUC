import 'dart:convert';
import 'dart:io';

void main() {
  final filePreguntas = File('assets/data/preguntas.json');
  final preguntas = jsonDecode(filePreguntas.readAsStringSync()) as List<dynamic>;

  Map<String, int> conteoPreguntas = {};
  for (var p in preguntas) {
    String codigo = (p['codigo_tema'] ?? p['codigoTema'])?.toString().trim() ?? 'NULL';
    conteoPreguntas[codigo] = (conteoPreguntas[codigo] ?? 0) + 1;
  }

  final fileTeoria = File('assets/data/teoria.json');
  final teoria = jsonDecode(fileTeoria.readAsStringSync()) as List<dynamic>;

  Map<String, int> conteoTeoria = {};
  for (var t in teoria) {
    String codigo = (t['codigo_tema'] ?? t['codigoTema'])?.toString().trim() ?? 'NULL';
    conteoTeoria[codigo] = (conteoTeoria[codigo] ?? 0) + 1;
  }

  final fileTemario = File('temario_maestro.json');
  final temario = jsonDecode(fileTemario.readAsStringSync()) as List<dynamic>;
  Set<String> codigosOficiales = temario.map((t) => t['codigo'].toString().trim()).toSet();

  List<String> codigosInvalidosPreguntas = conteoPreguntas.keys.where((k) => !codigosOficiales.contains(k)).toList();
  List<String> codigosInvalidosTeoria = conteoTeoria.keys.where((k) => !codigosOficiales.contains(k)).toList();

  final reporte = {
    'total_preguntas': preguntas.length,
    'codigos_unicos_preguntas': conteoPreguntas.length,
    'conteo_por_codigo_preguntas': conteoPreguntas,
    'codigos_invalidos_preguntas': codigosInvalidosPreguntas,
    'total_teoria': teoria.length,
    'codigos_unicos_teoria': conteoTeoria.length,
    'conteo_por_codigo_teoria': conteoTeoria,
    'codigos_invalidos_teoria': codigosInvalidosTeoria,
    'hallazgo_aleatoriedad': 'En examen_provider.dart o main, no se excluyen las preguntas mostradas o se usa un OrderBy fijo en SQLite, causando repetición.'
  };

  final out = File('C:/Users/diego/.gemini/antigravity/brain/4d14910a-6867-4119-a8da-ef00412cfb33/auditoria_forense.json');
  out.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(reporte));
  print('Auditoría guardada en el directorio de artifacts como auditoria_forense.json');
}
