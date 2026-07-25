import ''dart:convert'';
import ''dart:io'';

void main() {
  final fileTemario = File(''temario_maestro.json'');
  final temario = jsonDecode(fileTemario.readAsStringSync()) as List;
  Set<String> codigosOficiales = temario.map((t) => t[''codigo''].toString().trim()).toSet();

  final filePreguntas = File(''assets/data/preguntas.json'');
  final preguntas = (jsonDecode(filePreguntas.readAsStringSync()) as List)
      .map((p) => Map<String, dynamic>.from(p))
      .toList();
  Set<String> idsExistentes = preguntas.map((p) => p[''id'']?.toString() ?? '''').toSet();

  final lotesDir = Directory(''lotes_generados'');
  final loteFiles = lotesDir.listSync()
      .whereType<File>()
      .where((f) => f.path.contains(''lote_fix_''))
      .toList();

  int insertadas = 0; int duplicadas = 0; int invalidas = 0;
  List<String> errores = [];

  for (var file in loteFiles) {
    try {
      final lote = jsonDecode(file.readAsStringSync()) as List;
      for (var rawQ in lote) {
        final q = Map<String, dynamic>.from(rawQ);
        String id = q[''id'']?.toString() ?? '''';
        String codigo = (q[''codigo_tema''] ?? q[''codigoTema''])?.toString().trim() ?? '''';
        q[''codigo_tema''] = codigo;
        q.remove(''codigoTema'');
        if (id.isEmpty || !codigosOficiales.contains(codigo)) { invalidas++; continue; }
        if (idsExistentes.contains(id)) { duplicadas++; continue; }
        String respuesta = (q[''respuesta_correcta''] ?? q[''respuestaCorrecta''])?.toString() ?? '''';
        if (respuesta.isEmpty) { invalidas++; continue; }
        q[''respuesta_correcta''] = respuesta;
        q.remove(''respuestaCorrecta'');
        q[''explicacion_detallada''] = (q[''explicacion_detallada''] ?? q[''explicacionDetallada''])?.toString() ?? '''';
        q.remove(''explicacionDetallada'');
        preguntas.add(q);
        idsExistentes.add(id);
        insertadas++;
      }
    } catch (e) { errores.add(''Error: ${file.path}: $e''); }
  }

  filePreguntas.writeAsStringSync(const JsonEncoder.withIndent(''  '').convert(preguntas));

  Map<String, int> conteoFinal = {};
  for (var p in preguntas) {
    String c = p[''codigo_tema'']?.toString() ?? '''';
    conteoFinal[c] = (conteoFinal[c] ?? 0) + 1;
  }

  List<String> faltantes = [];
  List<String> completos = [];
  for (var t in temario) {
    String c = t[''codigo''];
    int count = conteoFinal[c] ?? 0;
    if (count >= 20) completos.add(c);
    else faltantes.add(''$c: $count/20'');
  }

  final reporte = {
    ''timestamp'': DateTime.now().toIso8601String(),
    ''total_preguntas'': preguntas.length,
    ''insertadas'': insertadas,
    ''duplicadas_ignoradas'': duplicadas,
    ''invalidas_rechazadas'': invalidas,
    ''errores_muestra'': errores.take(10).toList(),
    ''subtemas_completos_ge20'': completos.length,
    ''subtemas_faltantes'': faltantes,
    ''conteo_por_subtema'': conteoFinal,
  };

  File(''reporte_generacion_v2.json'').writeAsStringSync(const JsonEncoder.withIndent(''  '').convert(reporte));
  print(''Total: ${preguntas.length} | Insertadas: $insertadas | Dup: $duplicadas | Inv: $invalidas'');
  print(''Subtemas >=20: ${completos.length}/51'');
  if (faltantes.isEmpty) print(''TODOS los 51 subtemas >=20 preguntas!'');
  else print(''FALTANTES: $faltantes'');
}
