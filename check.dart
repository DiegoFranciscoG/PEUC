import 'dart:convert';
import 'dart:io';

void main() {
  final t = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
  print("Tema 0 keys: " + t[0].keys.toString());
  print("Tema 0: " + t[0].toString());
}
