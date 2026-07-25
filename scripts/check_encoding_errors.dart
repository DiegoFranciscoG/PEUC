import 'dart:convert';
import 'dart:io';

void main() {
  var p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  int repChar = p.where((x) => x['enunciado'].toString().contains('\uFFFD')).length;
  int mojibake = p.where((x) => x['enunciado'].toString().contains('Ã')).length;
  
  print('Con replacement char (\\uFFFD): ' + repChar.toString());
  print('Con mojibake latino (Ã): ' + mojibake.toString());
}
