import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Falta el nombre del archivo generado.');
    return;
  }
  
  final generatedPath = args[0];
  if (!File(generatedPath).existsSync()) {
    print('ERROR: No se encontró el archivo $generatedPath');
    return;
  }

  final String genContent = File(generatedPath).readAsStringSync();
  List<dynamic> newQuestions;
  try {
    newQuestions = jsonDecode(genContent);
  } catch (e) {
    print('ERROR: El archivo generado no es un JSON válido.');
    return;
  }

  if (newQuestions.length < 15) {
    print('ERROR: Se encontraron muy pocas preguntas: ${newQuestions.length}. Mínimo 15 requerido.');
    return;
  }

  int placeholders = 0;
  for (var q in newQuestions) {
    String enunciado = q['enunciado'] ?? '';
    List<dynamic> opciones = q['opciones'] ?? [];
    
    if (enunciado.toLowerCase().contains('pregunta oficial del tema') ||
        enunciado.toLowerCase().contains('sobre ciencias sociales')) {
      placeholders++;
    }
    for (var op in opciones) {
      String optStr = op.toString().toLowerCase();
      if (optStr.contains('opción a (correcta)') || 
          optStr.contains('opción b (incorrecta)') ||
          optStr.contains('opcion a (correcta)') ||
          optStr.contains('incorrecta)')) {
        placeholders++;
      }
    }
  }

  if (placeholders > 0) {
    print('ERROR: ANTI-PLACEHOLDER DETECTÓ $placeholders FALLOS. Lote rechazado.');
    return;
  }

  // Inject into main database
  final mainPath = 'assets/data/preguntas.json';
  final String mainContent = File(mainPath).readAsStringSync();
  List<dynamic> mainQuestions = jsonDecode(mainContent);
  
  mainQuestions.addAll(newQuestions);
  
  File(mainPath).writeAsStringSync(jsonEncode(mainQuestions));
  print('✅ VALIDACIÓN SUPERADA. 20 preguntas inyectadas exitosamente.');
}
