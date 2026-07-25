import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  for (String codigo in ['4.4.1', '4.1.2']) {
    final pregunta = jsonList.firstWhere(
      (q) => (q['codigo_tema'] ?? q['codigoTema'] ?? '') == codigo,
      orElse: () => null,
    );
    if (pregunta == null) {
      print('$codigo: NO ENCONTRADO');
      continue;
    }
    print('=================================================');
    print('CÓDIGO: $codigo');
    print('ENUNCIADO: ${pregunta['enunciado']}');
    print('OPCIONES:');
    final opciones = pregunta['opciones'] as List;
    for (int i = 0; i < opciones.length; i++) {
      print('  ${String.fromCharCode(65+i)}) ${opciones[i]}');
    }
    print('RESPUESTA CORRECTA: ${pregunta['respuesta_correcta']}');
    print('');
  }
}
