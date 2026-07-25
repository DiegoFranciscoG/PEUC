import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('assets/data/preguntas.json');
  if (!file.existsSync()) {
    print('No existe preguntas.json');
    return;
  }

  final content = file.readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);

  int placeholderCount = 0;
  int utf8Count = 0;

  final filteredData = data.where((q) {
    final opciones = q['opciones'] ?? [];
    bool isPlaceholder = false;
    
    if (opciones is List) {
      for (var op in opciones) {
        if (op.toString().contains('Opción A (correcta)') || 
            op.toString().contains('Opcin A (correcta)') ||
            op.toString().contains('Opcion A (correcta)')) {
          isPlaceholder = true;
          break;
        }
      }
    }

    if (isPlaceholder) {
      placeholderCount++;
      return false; // Remove
    }
    
    // Check for mojibake just in case
    if (jsonEncode(q).contains('Ã')) {
      utf8Count++;
    }

    return true; // Keep
  }).toList();

  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(filteredData), encoding: utf8);

  print('Removed $placeholderCount placeholder questions.');
  print('Remaining questions: ${filteredData.length}');
  print('Questions with mojibake remaining: $utf8Count');
  
  // Now analyze subjects to see if there's weird data
  final Set<String> subjects = {};
  for (var q in filteredData) {
    subjects.add(q['materia'].toString());
  }
  print('Subjects in DB: $subjects');
}
