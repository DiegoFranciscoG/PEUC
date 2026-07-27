import 'dart:io';
import 'dart:convert';
import '../lib/utils/generador_algoritmico.dart';

void main() {
  final file = File('assets/data/preguntas.json');
  final content = file.readAsStringSync();
  final list = jsonDecode(content) as List;

  int count = 0;
  final List<dynamic> newList = [];

  // Track unique enunciados to avoid repetition within Math
  final Set<String> enunciadosUnicos = {};
  
  // First, add all non-Math questions to the list
  for (var i = 0; i < list.length; i++) {
    final item = list[i] as Map<String, dynamic>;
    if (item['materia'] != 'Matemáticas') {
      newList.add(item);
    }
  }

  // Define Math topics
  final mathTopics = [
    '1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5',
    '1.1.6', '1.1.7', '1.2.1', '1.3.1'
  ];

  // Generate 20 absolutely unique questions per math topic
  for (final codigo in mathTopics) {
    int generadasParaTema = 0;
    while (generadasParaTema < 20) {
      final p = GeneradorAlgoritmico.obtenerPreguntaParaSubtema(codigo);
      
      // If the enunciado is already generated, skip and retry
      if (enunciadosUnicos.contains(p.enunciado)) {
        continue;
      }
      
      enunciadosUnicos.add(p.enunciado);
      
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
      generadasParaTema++;
      count++;
    }
  }

  file.writeAsStringSync(jsonEncode(newList));
  print('✅ Generadas $count preguntas de Matemáticas TOTALMENTE ÚNICAS.');
}
