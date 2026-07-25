import 'dart:convert';
import 'dart:io';

void main() {
  final content = File('assets/data/teoria.json').readAsStringSync();
  print('Tiene mojibake (U+FFFD)? \${content.contains('\\uFFFD')}');
  print('Tiene mojibake latin (Ã©)? \${content.contains('Ã©')}');
}
