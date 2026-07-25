import 'dart:io';
import 'dart:convert';
void main() {
  final f = File('assets/data/preguntas.json');
  var c = f.readAsStringSync(encoding: utf8);
  c = c.replaceAll('â‚ ', '₁');
  f.writeAsStringSync(c, encoding: utf8);
  print('Done');
}
