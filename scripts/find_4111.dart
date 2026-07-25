import 'dart:io';
import 'dart:convert';

void main() {
  final c = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List d = jsonDecode(c);
  final res = d.where((q) => q['codigo_tema'] == '4.11.1' || q['codigoTema'] == '4.11.1').toList();
  print('Found ${res.length} for 4.11.1');
  if (res.isNotEmpty) {
    print(jsonEncode(res.first));
  }
}
