import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  print('Iniciando ensamblado de Expansión Académica...');

  // 1. MANEJO DE PREGUNTAS (Preservación + Inyección)
  final preguntasFile = File('assets/data/preguntas.json');
  final String preguntasStr = await preguntasFile.readAsString();
  final List<dynamic> preguntasList = jsonDecode(preguntasStr);
  
  List<Map<String, dynamic>> preguntasFinales = [];
  int eliminadas = 0;
  
  final codigosContaminados = ['3.7.5', '3.7.6', '3.7.7', '3.7.8'];

  // Preservar todas excepto los códigos contaminados
  for (var p in preguntasList) {
    final mapa = Map<String, dynamic>.from(p);
    final codigo = mapa['codigo_tema']?.toString() ?? '';
    if (codigosContaminados.contains(codigo)) {
      eliminadas++;
    } else {
      preguntasFinales.add(mapa);
    }
  }

  print('🗑️ Preguntas contaminadas eliminadas: $eliminadas');

  // Inyectar nuevas preguntas de Física
  for (var codigo in codigosContaminados) {
    final codigoFlat = codigo.replaceAll('.', '');
    final newFile = File('assets/data/gen_q_$codigoFlat.json');
    if (await newFile.exists()) {
      final List<dynamic> newQ = jsonDecode(await newFile.readAsString());
      for (var p in newQ) {
        preguntasFinales.add(Map<String, dynamic>.from(p));
      }
      print('✅ Inyectadas ${newQ.length} preguntas de Física para $codigo');
    } else {
      print('⚠️ Archivo no encontrado: ${newFile.path}');
    }
  }

  await preguntasFile.writeAsString(jsonEncode(preguntasFinales), encoding: utf8);
  print('✅ preguntas.json ensamblado (Total: ${preguntasFinales.length} preguntas)');

  // 2. MANEJO DE TEORÍA (Reescritura Total)
  List<Map<String, dynamic>> teoriaFinal = [];
  final teoriaFiles = [
    'gen_t_mat.json',
    'gen_t_len.json',
    'gen_t_cn1.json',
    'gen_t_cn2.json',
    'gen_t_cn3.json',
    'gen_t_cn4.json',
    'gen_t_cs1.json',
    'gen_t_cs2.json',
    'gen_t_ra.json',
  ];

  for (var fileName in teoriaFiles) {
    final tFile = File('assets/data/$fileName');
    if (await tFile.exists()) {
      final List<dynamic> list = jsonDecode(await tFile.readAsString());
      for (var t in list) {
        teoriaFinal.add(Map<String, dynamic>.from(t));
      }
      print('✅ Añadidos ${list.length} temas de teoría desde $fileName');
    } else {
      print('⚠️ Archivo de teoría no encontrado: $fileName');
    }
  }

  final teoriaFile = File('assets/data/teoria.json');
  await teoriaFile.writeAsString(jsonEncode(teoriaFinal), encoding: utf8);
  print('✅ teoria.json reescrito desde cero (Total: ${teoriaFinal.length} temas). Peso aproximado: ${(teoriaFile.lengthSync() / 1024).toStringAsFixed(2)} KB');

  // 3. LIMPIEZA
  print('Limpiando archivos temporales...');
  final dataDir = Directory('assets/data');
  final entities = dataDir.listSync();
  for (var entity in entities) {
    if (entity is File && entity.path.contains('gen_')) {
      await entity.delete();
    }
  }

  print('🚀 Ensamblado completado exitosamente.');
}
