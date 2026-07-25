import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  final qs = data.where((q) => jsonEncode(q).contains('6CO')).take(5).toList();
  for(var q in qs) {
    print(q['id'] + ': ' + q['enunciado']);
    print(q['opciones']);
    print('---');
  }
}
