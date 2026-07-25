import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  final qs = data.where((q) => jsonEncode(q).contains('fotosíntesis') || jsonEncode(q).contains('â')).take(10).toList();
  for(var q in qs) {
    print(q['id']);
    print(q['enunciado']);
    print(q['opciones']);
    print('---');
  }
}
