import 'dart:io';
import 'dart:convert';
void main() {
  final c = File('assets/data/preguntas.json').readAsStringSync();
  final j = jsonDecode(c) as List;
  final m = j.where((e) => e['materia'] == 'Matemáticas').map((e) => e['codigo_tema']).toSet().toList()..sort();
  print('Codigos Matematicas: $m');
}
