import 'dart:io';
import 'dart:convert';

void main() {
  final dirsToScan = [
    Directory('assets/data'),
    Directory('lotes_generados'),
    Directory('.')
  ];

  final Map<String, Set<String>> uniquePerSubject = {};
  int totalQuestionsFound = 0;

  for (final dir in dirsToScan) {
    if (!dir.existsSync()) continue;
    
    final files = dir.listSync().whereType<File>().where((f) => 
      f.path.endsWith('.json') && 
      !f.path.contains('preguntas.json') && 
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
        if (decoded is List) {
          list = decoded;
        } else if (decoded is Map && decoded.containsKey('preguntas')) {
          list = decoded['preguntas'];
        } else {
          continue;
        }

        for (var item in list) {
          if (item is! Map) continue;
          final materia = item['materia']?.toString();
          final enunciado = item['enunciado']?.toString();
          
          if (materia != null && enunciado != null && enunciado.length > 10 && !enunciado.contains('Pregunta de')) {
            uniquePerSubject.putIfAbsent(materia, () => <String>{});
            uniquePerSubject[materia]!.add(enunciado);
            totalQuestionsFound++;
          }
        }
      } catch (e) {
        // ignore
      }
    }
  }

  print('\n--- Preguntas ÚNICAS y REALES en TODOS los JSONs del proyecto ---');
  for (final materia in uniquePerSubject.keys) {
    print('  $materia -> Únicas reales: ${uniquePerSubject[materia]!.length}');
  }
}
