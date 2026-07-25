import 'dart:convert';
import 'dart:io';

void main() {
  // 1. Load temario_maestro.json to get the 51 valid official codes (field 'codigo')
  final fileTemario = File('temario_maestro.json');
  if (!fileTemario.existsSync()) {
    print('Error: temario_maestro.json no encontrado.');
    return;
  }
  final temario = jsonDecode(fileTemario.readAsStringSync()) as List;
  final Set<String> codigosOficiales = temario
      .map((t) => t['codigo']?.toString().trim() ?? '')
      .where((c) => c.isNotEmpty)
      .toSet();

  // 2. Load assets/data/preguntas.json as the base list
  final filePreguntas = File('assets/data/preguntas.json');
  List<Map<String, dynamic>> pregs = [];
  if (filePreguntas.existsSync()) {
    final rawPreguntas = jsonDecode(filePreguntas.readAsStringSync()) as List;
    pregs = rawPreguntas
        .map((p) => Map<String, dynamic>.from(p as Map))
        .toList();
  }

  final Set<String> idsExistentes = pregs
      .map((p) => p['id']?.toString().trim() ?? '')
      .where((id) => id.isNotEmpty)
      .toSet();

  // 3. Scan every file in lotes_generados/ that has 'lote_fix_' in its name
  final lotesDir = Directory('lotes_generados');
  List<File> loteFiles = [];
  if (lotesDir.existsSync()) {
    loteFiles = lotesDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.contains('lote_fix_'))
        .toList();
  }

  int insertadas = 0;
  int duplicadasSaltadas = 0;
  int invalidasSaltadas = 0;

  // 4. For each question in those files:
  for (var file in loteFiles) {
    try {
      final lote = jsonDecode(file.readAsStringSync()) as List;
      for (var rawQ in lote) {
        if (rawQ is! Map) {
          invalidasSaltadas++;
          continue;
        }
        final q = Map<String, dynamic>.from(rawQ);

        // Read id
        String id = q['id']?.toString().trim() ?? '';
        if (id.isEmpty) {
          invalidasSaltadas++;
          continue;
        }

        // Read code from 'codigo_tema' OR 'codigoTema' (normalize to 'codigo_tema')
        String codigo = (q['codigo_tema'] ?? q['codigoTema'])?.toString().trim() ?? '';
        if (codigo.isEmpty || !codigosOficiales.contains(codigo)) {
          invalidasSaltadas++;
          continue;
        }

        // Skip if id already exists
        if (idsExistentes.contains(id)) {
          duplicadasSaltadas++;
          continue;
        }

        // Read respuesta from 'respuesta_correcta' OR 'respuestaCorrecta' (normalize to 'respuesta_correcta')
        String respuesta = (q['respuesta_correcta'] ?? q['respuestaCorrecta'])?.toString().trim() ?? '';
        if (respuesta.isEmpty) {
          invalidasSaltadas++;
          continue;
        }

        // Read explicacion from 'explicacion_detallada' OR 'explicacionDetallada' (normalize to 'explicacion_detallada')
        String explicacion = (q['explicacion_detallada'] ?? q['explicacionDetallada'])?.toString() ?? '';

        // Remove the camelCase versions of these keys and normalize
        q['codigo_tema'] = codigo;
        q.remove('codigoTema');

        q['respuesta_correcta'] = respuesta;
        q.remove('respuestaCorrecta');

        q['explicacion_detallada'] = explicacion;
        q.remove('explicacionDetallada');

        // Add to pregs list, add id to the set
        pregs.add(q);
        idsExistentes.add(id);
        insertadas++;
      }
    } catch (e) {
      print('Error leyendo ${file.path}: $e');
    }
  }

  // 5. Save updated list back to assets/data/preguntas.json
  filePreguntas.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(pregs),
  );

  // 6. Count questions per 'codigo_tema'
  Map<String, int> fullCountPerCode = {};
  for (var p in pregs) {
    String c = (p['codigo_tema'] ?? p['codigoTema'])?.toString().trim() ?? '';
    if (c.isNotEmpty) {
      fullCountPerCode[c] = (fullCountPerCode[c] ?? 0) + 1;
    }
  }

  // 7. Compare against temario to find which codes have < 20 questions
  List<String> codesWithLessThan20 = [];
  for (var t in temario) {
    String c = t['codigo']?.toString().trim() ?? '';
    if (c.isEmpty) continue;
    int count = fullCountPerCode[c] ?? 0;
    if (count < 20) {
      codesWithLessThan20.add(c);
    }
  }

  // 8. Save a report to reporte_generacion_v2.json with:
  // total count, inserted, duplicates skipped, invalids skipped, list of codes with < 20 questions, and full count per code
  final reporte = {
    'total_count': pregs.length,
    'inserted': insertadas,
    'duplicates_skipped': duplicadasSaltadas,
    'invalids_skipped': invalidasSaltadas,
    'codes_with_less_than_20': codesWithLessThan20,
    'full_count_per_code': fullCountPerCode,
    // Spanish aliases for maximum compatibility
    'total_preguntas': pregs.length,
    'insertadas': insertadas,
    'duplicadas_saltadas': duplicadasSaltadas,
    'invalidas_saltadas': invalidasSaltadas,
    'codigos_con_menos_de_20': codesWithLessThan20,
    'conteo_por_codigo': fullCountPerCode,
  };

  File('reporte_generacion_v2.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(reporte),
  );

  // 9. Print a summary
  print('==================================================');
  print('RESUMEN DE MERGE Y LIMPIEZA');
  print('==================================================');
  print('Total de preguntas final: ${pregs.length}');
  print('Insertadas: $insertadas');
  print('Duplicadas omitidas: $duplicadasSaltadas');
  print('Inválidas omitidas: $invalidasSaltadas');
  print('Códigos con menos de 20 preguntas: ${codesWithLessThan20.length}');
  if (codesWithLessThan20.isNotEmpty) {
    print('Códigos con < 20 preguntas:');
    for (var c in codesWithLessThan20) {
      print('  - $c (${fullCountPerCode[c] ?? 0}/20)');
    }
  } else {
    print('¡Todos los 51 códigos oficiales cuentan con al menos 20 preguntas!');
  }
  print('Reporte guardado en reporte_generacion_v2.json');
}
