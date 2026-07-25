import 'dart:convert';
import 'dart:io';

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  
  for (String code in ['4.5.2', '4.5.3', '4.6.1', '4.7.1', '4.5.1', '4.8.1']) {
    print('--- Example for $code ---');
    for (var q in data) {
      if ((q['codigo_tema'] ?? q['codigoTema']) == code) {
        if (code == '4.5.1' && !(q['id'] ?? '').toString().startsWith('q_')) continue;
        if (code == '4.8.1' && !(q['id'] ?? '').toString().startsWith('q_')) continue;
        
        print(jsonEncode(q));
        break;
      }
    }
  }
}
