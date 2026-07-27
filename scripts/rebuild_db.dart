import 'dart:io';
import 'dart:convert';
import '../lib/utils/generador_algoritmico.dart';
import '../lib/utils/generador_lenguaje.dart';
import '../lib/utils/generador_abstracto.dart';
import '../lib/models/pregunta.dart';

void main() {
  final Map<String, List<String>> codigosPorMateria = {};
  
  // 1. Cargar el temario
  final temarioContent = File('assets/data/temario_maestro.json').readAsStringSync();
  final temario = jsonDecode(temarioContent) as List;
  for (var item in temario) {
    String area = item['area'] as String;
    if (area.contains('Matem') || area.contains('Matemǭticas')) area = 'Matemáticas';
    if (area.contains('Lengua')) area = 'Lengua y Literatura';
    if (area.contains('Naturales')) area = 'Ciencias Naturales';
    if (area.contains('Sociales')) area = 'Ciencias Sociales';
    if (area.contains('Abstracto') || area.contains('abstracto')) area = 'Razonamiento Abstracto';
    
    codigosPorMateria.putIfAbsent(area, () => []);
    codigosPorMateria[area]!.add(item['codigo'] as String);
  }

  // 2. Extraer todas las preguntas crudas
  final dirsToScan = [
    Directory('assets/data'),
    Directory('lotes_generados'),
    Directory('.')
  ];

  final Map<String, Map<String, dynamic>> rawQuestionsByEnunciado = {};

  for (final dir in dirsToScan) {
    if (!dir.existsSync()) continue;
    final files = dir.listSync().whereType<File>().where((f) => 
      f.path.endsWith('.json') && 
      (!f.path.endsWith('preguntas.json') || f.path.contains('preguntas_backup')) && 
      !f.path.contains('preguntas_clean.json') && 
      !f.path.contains('teoria.json') && 
      !f.path.contains('temario') && 
      !f.path.contains('mock')
    );

    for (final file in files) {
      try {
        final content = file.readAsStringSync();
        final decoded = jsonDecode(content);
        
        List list = [];
        if (decoded is List) list = decoded;
        else if (decoded is Map && decoded.containsKey('preguntas')) list = decoded['preguntas'];

        for (var item in list) {
          if (item is! Map) continue;
          final materia = item['materia']?.toString();
          final codigoTema = item['codigo_tema']?.toString() ?? item['codigo_subtema']?.toString();
          
          var enunciado = item['enunciado']?.toString();
          if (enunciado != null) {
            final RegExp regex = RegExp(r'Ejercicio de Matemáticas - Código \d\.\d\.\d(?:, variante \d+)?\.\s*');
            enunciado = enunciado.replaceAll(regex, '');
            item['enunciado'] = enunciado;
          }
          
          if (materia != null && enunciado != null && enunciado.length > 10 && !enunciado.contains('Pregunta de') && !enunciado.contains('Pregunta comodín') && codigoTema != null) {
             // Asegurar ID y fuente
             if (item['id'] == null) {
               item['id'] = 'rescued_\${DateTime.now().microsecondsSinceEpoch}';
             }
             item['fuente'] = 'PDF_original_2026';
             rawQuestionsByEnunciado[enunciado] = item as Map<String, dynamic>;
          }
        }
      } catch (e) {}
    }
  }

  // 3. Agrupar por materia y codigo_tema
  final Map<String, Map<String, List<Map<String, dynamic>>>> db = {};
  for (final m in codigosPorMateria.keys) {
    db[m] = {};
    for (final c in codigosPorMateria[m]!) {
      db[m]![c] = [];
    }
  }

  for (final q in rawQuestionsByEnunciado.values) {
    final m = q['materia'];
    final c = q['codigo_tema'];
    if (db.containsKey(m) && db[m]!.containsKey(c)) {
      db[m]![c]!.add(q);
    }
  }

  // 4. Llenar los vacíos hasta tener exactamente 20 por subtema
  final List<dynamic> finalJson = [];
  int totalReales = 0;
  int totalGeneradas = 0;

  for (final m in codigosPorMateria.keys) {
    for (final c in codigosPorMateria[m]!) {
      final questions = db[m]![c]!;
      // Toma hasta 20 preguntas reales
      int seleccionadas = 0;
      final Set<String> enunciadosUsados = {};

      for (var q in questions) {
        if (seleccionadas >= 20) break;
        if (!enunciadosUsados.contains(q['enunciado'])) {
          finalJson.add(q);
          enunciadosUsados.add(q['enunciado'] as String);
          seleccionadas++;
          totalReales++;
        }
      }

      // Si faltan, generar procedimentalmente
      int intentos = 0;
      while (seleccionadas < 20) {
        Pregunta? p;
        if (m == 'Matemáticas') p = GeneradorAlgoritmico.obtenerPreguntaParaSubtema(c);
        else if (m == 'Lengua y Literatura') p = GeneradorLenguaje.obtenerPreguntaParaSubtema(c);
        else if (m == 'Razonamiento Abstracto' || m == 'Razonamiento abstracto') p = GeneradorAbstracto.obtenerPreguntaParaSubtema(c);
        
        if (p != null) {
          if (!enunciadosUsados.contains(p.enunciado)) {
            final Map<String, dynamic> pMap = {
              'id': p.id,
              'materia': p.materia,
              'codigo_tema': p.codigoTema,
              'enunciado': p.enunciado,
              'opciones': p.opciones != null ? jsonEncode(p.opciones) : null,
              'respuesta_correcta': p.respuestaCorrecta,
              'explicacion_detallada': p.explicacionDetallada,
              'es_opciones_imagen': p.esOpcionesImagen,
              'elementos_abstractos': p.elementosAbstractos != null ? jsonEncode(p.elementosAbstractos!.map((e)=>e.toMap()).toList()) : null,
              'opciones_abstractas': p.opcionesAbstractas != null ? jsonEncode(p.opcionesAbstractas!.map((e)=>e.toMap()).toList()) : null,
              'tipo_ejercicio_abstracto': p.tipoEjercicioAbstracto,
              'fuente': 'generado_plantilla',
            };

            finalJson.add(pMap);
            enunciadosUsados.add(p.enunciado);
            seleccionadas++;
            totalGeneradas++;
          }
        }
        intentos++;
        if (intentos > 2000) {
          break; // Salir si no hay generador para alcanzar 20
        }
      }
    }
  }

  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(finalJson));
  print('✅ Base de datos reconstruida.');
  print('  Preguntas reales recuperadas: $totalReales');
  print('  Preguntas algorítmicas generadas: $totalGeneradas');
  print('  Total inyectado: ${finalJson.length}');
}
