import 'dart:io';
import 'dart:convert';
void main() {
  final j = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  final counts = {};
  for (var p in j) {
    if (p['materia'] == 'Matemáticas') {
      counts[p['codigo_tema']] = (counts[p['codigo_tema']] ?? 0) + 1;
    }
  }
  print(counts);
}
