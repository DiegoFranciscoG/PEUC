import 'dart:io';
import 'dart:convert';

void main() {
  final j = jsonDecode(File('assets/data/temario_maestro.json').readAsStringSync());
  final codes = ['3.1.1','3.4.1','4.1.1','4.2.1','4.3.1','4.5.2','4.11.1'];
  for (var area in j) {
    if (area['temas'] == null) continue;
    for (var t in area['temas']) {
      if (t['subtemas'] == null) continue;
      for (var st in t['subtemas']) {
        if (codes.contains(st['codigo'])) {
          final cod = st['codigo'];
          final nom = st['nombre'];
          final tnom = t['nombre'];
          print('\$cod -> \$nom (TEMA: \$tnom)');
        }
      }
    }
  }
}
