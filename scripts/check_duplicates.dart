import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('assets/data/preguntas.json');
  final content = file.readAsStringSync();
  final list = jsonDecode(content) as List;

  final Map<String, int> totalPerSubject = {};
  final Map<String, Set<String>> uniquePerSubject = {};
  int nullEnunciados = 0;
  int nullMaterias = 0;

  for (var item in list) {
    final materia = item['materia']?.toString();
    final enunciado = item['enunciado']?.toString();
    final id = item['id']?.toString() ?? 'NO_ID';

    if (materia == null) {
      nullMaterias++;
      print('ALERTA: Materia nula en ID: $id');
      continue;
    }
    if (enunciado == null) {
      nullEnunciados++;
      print('ALERTA: Enunciado nulo en ID: $id, Materia: $materia');
      continue;
    }

    totalPerSubject[materia] = (totalPerSubject[materia] ?? 0) + 1;
    
    uniquePerSubject.putIfAbsent(materia, () => <String>{});
    uniquePerSubject[materia]!.add(enunciado);
  }

  print('\n--- Reporte de Preguntas ---');
  for (final materia in totalPerSubject.keys) {
    final total = totalPerSubject[materia]!;
    final uniques = uniquePerSubject[materia]!.length;
    final duplicates = total - uniques;
    
    print('Materia: $materia');
    print('  Total: $total');
    print('  Únicas: $uniques');
    print('  Duplicadas: $duplicates');
  }

  print('\nErrores Críticos:');
  print('  Materias nulas: $nullMaterias');
  print('  Enunciados nulos: $nullEnunciados');
}
