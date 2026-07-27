import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync();
  final list = jsonDecode(content) as List;
  
  Map<String, List<Map<String, dynamic>>> byEnunciado = {};
  for (var item in list) {
    if (item['materia'] == 'Razonamiento Abstracto') {
      final en = item['enunciado'];
      byEnunciado.putIfAbsent(en, () => []).add(item);
    }
  }
  
  int duplicadosMostrados = 0;
  for (var entry in byEnunciado.entries) {
    if (entry.value.length > 1) {
      print('--- DUPLICADO ENCONTRADO ---');
      print('Enunciado: ' + entry.key.toString());
      for (var q in entry.value) {
        print('  ID: ' + q['id'].toString());
        if (q['elementos_abstractos'] != null) {
          final elems = jsonDecode(q['elementos_abstractos']) as List;
          if (elems.length >= 2) {
            final e1 = elems[0];
            final e2 = elems[1];
            print('    E1: forma=' + e1['icono'].toString() + ', rot=' + e1['rotacion'].toString() + ', relleno=' + e1['relleno'].toString() + ', tamano=' + e1['tamano'].toString());
            print('    E2: forma=' + e2['icono'].toString() + ', rot=' + e2['rotacion'].toString() + ', relleno=' + e2['relleno'].toString() + ', tamano=' + e2['tamano'].toString());
          }
        }
      }
      duplicadosMostrados++;
      if (duplicadosMostrados >= 3) break;
    }
  }
}
