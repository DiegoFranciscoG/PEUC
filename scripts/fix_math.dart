import 'dart:io';
import 'dart:convert';
import '../lib/utils/generador_algoritmico.dart';

void main() {
  final file = File('assets/data/preguntas.json');
  final content = file.readAsStringSync();
  final list = jsonDecode(content) as List;

  int count = 0;
  final List<dynamic> newList = [];

  for (var i = 0; i < list.length; i++) {
    final item = list[i] as Map<String, dynamic>;
    if (item['materia'] == 'Matemáticas') {
      final codigo = item['codigo_tema'];
      final p = GeneradorAlgoritmico.obtenerPreguntaParaSubtema(codigo);
      
      final Map<String, dynamic> pMap = {
        'id': p.id,
        'materia': p.materia,
        'codigo_tema': p.codigoTema,
        'enunciado': p.enunciado,
        'opciones': jsonEncode(p.opciones),
        'respuesta_correcta': p.respuestaCorrecta,
        'explicacion_detallada': p.explicacionDetallada,
        'dificultad': p.dificultad,
        'nivel_cognitivo': p.nivelCognitivo,
        'competencia': p.competencia,
        'tiempo_estimado': p.tiempoEstimado,
        'origen': p.origen,
      };

      if (p.pasosResolucion != null) {
        pMap['pasos_resolucion'] = jsonEncode(p.pasosResolucion);
      }
      if (p.videoExplicativoUrl != null) {
        pMap['video_explicativo_url'] = p.videoExplicativoUrl;
      }
      
      newList.add(pMap);
      count++;
    } else {
      newList.add(item);
    }
  }

  file.writeAsStringSync(jsonEncode(newList));
  print('✅ Corregidas $count preguntas de Matemáticas usando el generador algorítmico.');
}
