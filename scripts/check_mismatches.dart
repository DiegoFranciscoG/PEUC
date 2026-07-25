import 'dart:convert';
import 'dart:io';

void main() {
  final filePreguntas = File('assets/data/preguntas.json');
  final preguntas = jsonDecode(filePreguntas.readAsStringSync()) as List<dynamic>;
  
  final fileTemario = File('temario_maestro.json');
  final temario = jsonDecode(fileTemario.readAsStringSync()) as List<dynamic>;
  
  Map<String, String> matOficial = {};
  for(var o in temario) {
    matOficial[o['codigo']] = o['area'];
  }
  
  int mismatches = 0;
  for(var q in preguntas) {
    String c = (q['codigo_tema'] ?? q['codigoTema']).toString().trim();
    if(matOficial[c] != null && matOficial[c] != q['materia']) {
      print('Mismatch: ID ${q['id']} - Codigo $c - Oficial ${matOficial[c]} - JSON ${q['materia']}');
      mismatches++;
    }
  }
  print('Total mismatches: $mismatches');
}
