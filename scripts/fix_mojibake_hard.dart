import 'dart:convert';
import 'dart:io';

String hardFixMojibake(String text) {
  return text
    .replaceAll('Ã¡', 'á')
    .replaceAll('Ã©', 'é')
    .replaceAll('Ã³', 'ó')
    .replaceAll('Ãº', 'ú')
    .replaceAll('Ã±', 'ñ')
    .replaceAll('Ã\xAD', 'í') // Ã followed by soft hyphen or similar
    .replaceAll('Ã±', 'ñ')
    .replaceAll('Ã‘', 'Ñ')
    .replaceAll('Ã\x81', 'Á')
    .replaceAll('Ã\x89', 'É')
    .replaceAll('Ã\x8D', 'Í')
    .replaceAll('Ã\x93', 'Ó')
    .replaceAll('Ã\x9A', 'Ú')
    .replaceAll('Ã³', 'ó')
    .replaceAll('fÃ³rmula', 'fórmula')
    .replaceAll('Ã', 'í'); // Fallback for floating Ã which usually meant í
}

void main() {
  String raw = File('assets/data/preguntas.json').readAsStringSync();
  String fixed = hardFixMojibake(raw);
  File('assets/data/preguntas.json').writeAsStringSync(fixed);
  
  String rawTeoria = File('assets/data/teoria.json').readAsStringSync();
  String fixedTeoria = hardFixMojibake(rawTeoria);
  File('assets/data/teoria.json').writeAsStringSync(fixedTeoria);
  
  print('Mojibake hardcore arreglado por reemplazo de strings.');
}
