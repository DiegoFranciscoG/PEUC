import 'dart:io';
import 'dart:convert';

void main() {
  final files = ['preguntas_clean.json', 'preguntas.json'];
  
  for (var fileName in files) {
    print('\nAnalizando $fileName:');
    try {
      final file = File('assets/data/$fileName');
      if (!file.existsSync()) {
        print('  No existe.');
        continue;
      }
      final content = file.readAsStringSync();
      final list = jsonDecode(content) as List;

      final Map<String, int> totalPerSubject = {};
      final Map<String, Set<String>> uniquePerSubject = {};

      for (var item in list) {
        final materia = item['materia']?.toString() ?? 'NULA';
        final enunciado = item['enunciado']?.toString() ?? 'NULO';

        totalPerSubject[materia] = (totalPerSubject[materia] ?? 0) + 1;
        uniquePerSubject.putIfAbsent(materia, () => <String>{});
        uniquePerSubject[materia]!.add(enunciado);
      }

      for (final materia in totalPerSubject.keys) {
        final total = totalPerSubject[materia]!;
        final uniques = uniquePerSubject[materia]!.length;
        print('  $materia -> Total: $total | Únicas: $uniques');
      }
    } catch (e) {
      print('  Error: $e');
    }
  }
}
