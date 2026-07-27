import 'dart:io';
import 'dart:convert';

void main() {
  final j = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  final a = j.firstWhere((e) => e['materia'] == 'Lengua y Literatura', orElse: () => null);
  print(jsonEncode(a));
}
