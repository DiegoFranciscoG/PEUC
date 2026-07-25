import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  
  Map<String, int> countPerSubtema = {};
  Map<String, String> materiaPerSubtema = {};
  
  for(var q in data) {
    String codigo = q['codigoTema'] ?? q['codigo_tema'] ?? '';
    String materia = q['materia'] ?? '';
    countPerSubtema[codigo] = (countPerSubtema[codigo] ?? 0) + 1;
    materiaPerSubtema[codigo] = materia;
  }
  
  final temasOficiales = {
    'Matemáticas': ['1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6', '1.1.7', '1.2.1', '1.3.1'],
    'Lengua y Literatura': ['2.1.1', '2.2.1', '2.3.1', '2.4.1', '2.5.1'],
    'Ciencias Naturales': [
      '3.1.1', '3.1.2', '3.1.3', '3.2.1', '3.3.1', '3.3.2',
      '3.4.1', '3.4.2', '3.4.3', '3.4.4', '3.4.5', '3.4.6',
      '3.5.1', '3.6.1',
      '3.7.1', '3.7.2', '3.7.3', '3.7.4', '3.7.5', '3.7.6', '3.7.7', '3.7.8',
      '3.8.1', '3.9.1', '3.10.1'
    ],
    'Ciencias Sociales': [
      '4.1.1', '4.1.2', '4.1.3', '4.2.1', '4.3.1', '4.4.1',
      '4.5.1', '4.5.2', '4.5.3', '4.6.1', '4.7.1', '4.8.1', '4.9.1', '4.10.1', '4.11.1'
    ],
    'Razonamiento Abstracto': ['5.1.1', '5.1.2', '5.2.1', '5.2.2', '5.2.3', '5.3.1', '5.3.2', '5.3.3'],
  };
  
  int totalFaltantes = 0;
  
  temasOficiales.forEach((materia, codigos) {
    print('--- ' + materia + ' ---');
    for (var codigo in codigos) {
      int count = countPerSubtema[codigo] ?? 0;
      String estado = count >= 20 ? 'OK' : ('FALTAN ' + (20 - count).toString());
      print('  ' + codigo + ': ' + count.toString() + ' preguntas -> ' + estado);
      if (count < 20) totalFaltantes += (20 - count);
    }
  });
  
  print('');
  print('Total preguntas actuales: ' + data.length.toString());
  print('Total preguntas faltantes para llegar a 20/subtema: ' + totalFaltantes.toString());
}
