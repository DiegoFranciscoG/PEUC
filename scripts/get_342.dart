import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  final qs = data.where((q) => q['codigoTema'] == '3.4.2' || q['codigo_tema'] == '3.4.2').toList();
  for(var q in qs) {
    print(q['id'] + ': ' + q['enunciado']);
  }
}
