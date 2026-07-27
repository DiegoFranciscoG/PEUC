import 'dart:io';
import 'dart:convert';
void main() {
  final c = File('assets/data/temario_maestro.json').readAsStringSync();
  final j = jsonDecode(c) as Map;
  for (var k in j.keys) {
    final t = j[k];
    if (t['subtemas'] != null) {
      for (var s in t['subtemas']) {
        if (['1.1.3', '1.1.4', '1.1.6', '1.1.7'].contains(s['codigo'])) {
          print('${s['codigo']} : ${s['nombre']}');
        }
      }
    }
  }
}
