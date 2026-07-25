import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  
  Set<String> subtemas = {};
  for(var q in data) {
    subtemas.add(q['codigoTema'] ?? q['codigo_tema'] ?? '');
  }
  
  print('Total subtemas: ' + subtemas.length.toString());
  
  final cs = subtemas.where((s) => s.startsWith('4.')).toList()..sort();
  print('CS Subtemas: ' + cs.toString());
  
  final cn = subtemas.where((s) => s.startsWith('3.')).toList()..sort();
  print('CN Subtemas: ' + cn.toString());
  
  final badQs = data.where((q) => jsonEncode(q).contains('â')).take(5).toList();
  print('Questions with â: ' + badQs.length.toString());
  for (var q in badQs) {
    print(q['id'] + ': ' + q['enunciado']);
  }
}
