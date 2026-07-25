import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);

  final weirdQuestions = data.where((q) => jsonEncode(q).contains('Ã')).take(3).toList();
  print(const JsonEncoder.withIndent('  ').convert(weirdQuestions));
}
