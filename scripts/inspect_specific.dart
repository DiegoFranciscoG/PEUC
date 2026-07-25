import 'dart:convert';
import 'dart:io';

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  print('=== 1193 ===');
  print(jsonEncode(data[1193]));
  print('=== 1237 ===');
  print(jsonEncode(data[1237]));
  
  for (var q in data) {
    if ((q['codigo_tema'] ?? q['codigoTema']) == '4.5.2') {
      print('=== 4.5.2 example ===');
      print(jsonEncode(q));
      break;
    }
  }
}
