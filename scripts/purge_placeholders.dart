import 'dart:convert';
import 'dart:io';

void main() {
  final path = 'assets/data/preguntas.json';
  final String content = File(path).readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  List<dynamic> newList = [];
  int removed = 0;

  for (var q in jsonList) {
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    
    bool isPlaceholder = false;
    if (codigo.startsWith('4.')) {
      String enunciado = q['enunciado'] ?? '';
      List<dynamic> opciones = q['opciones'] ?? [];
      
      if (enunciado.toLowerCase().contains('pregunta oficial del tema') ||
          enunciado.toLowerCase().contains('sobre ciencias sociales')) {
        isPlaceholder = true;
      }
      for (var op in opciones) {
        String optStr = op.toString().toLowerCase();
        if (optStr.contains('opción a (correcta)') || 
            optStr.contains('opción b (incorrecta)') ||
            optStr.contains('opcion a (correcta)') ||
            optStr.contains('incorrecta)')) {
          isPlaceholder = true;
        }
      }
    }

    if (isPlaceholder) {
      removed++;
    } else {
      newList.add(q);
    }
  }

  File(path).writeAsStringSync(jsonEncode(newList));
  print('✅ Purga completada. Se eliminaron $removed preguntas placeholder.');
}
