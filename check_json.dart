import 'dart:convert';
import 'dart:io';

void main() {
  final t = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
  print("Primer tema: " + (t[0]['codigo_tema'] ?? t[0]['codigoTema']).toString() + " - " + t[0]['materia'].toString());
  print("Total teoria: " + t.length.toString());
  
  final p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  print("Primera pregunta: " + (p[0]['codigo_tema'] ?? p[0]['codigoTema']).toString() + " - " + p[0]['materia'].toString());
  print("Total preguntas: " + p.length.toString());
}
