import 'dart:convert';
import 'dart:io';

void main() {
  var p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  var m1 = p.firstWhere((x) => x['codigo_tema'] == '1.1.1', orElse: () => null);
  var s4 = p.firstWhere((x) => x['codigo_tema'] == '4.1.1', orElse: () => null);
  var f3 = p.firstWhere((x) => x['codigo_tema'] == '3.7.6', orElse: () => null);

  print('MATEMÁTICAS 1.1.1: ' + (m1 != null ? m1['enunciado'].toString() : 'N/A'));
  print('SOCIALES 4.1.1: ' + (s4 != null ? s4['enunciado'].toString() : 'N/A'));
  print('FÍSICA 3.7.6: ' + (f3 != null ? f3['enunciado'].toString() : 'N/A'));
}
