import 'dart:convert';
import 'dart:io';

void main() {
  String raw = File('assets/data/preguntas.json').readAsStringSync();
  int index = raw.indexOf('Ã');
  if (index != -1) {
    print('Encontrado Ã en el índice \$index');
    print('Contexto: ' + raw.substring(index > 20 ? index - 20 : 0, index + 20));
  } else {
    print('No se encontró Ã en el archivo');
  }
}
