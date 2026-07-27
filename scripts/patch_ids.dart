import 'dart:io';
void main() {
  final f = File('lib/utils/generador_algoritmico.dart');
  var c = f.readAsStringSync();
  c = c.replaceAll('DateTime.now().millisecondsSinceEpoch', 'DateTime.now().microsecondsSinceEpoch}_\${_rand.nextInt(1000000)}');
  f.writeAsStringSync(c);
  print('Generador parcheado.');
}
