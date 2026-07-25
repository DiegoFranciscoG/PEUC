import 'dart:io';
import 'dart:convert';

void main() {
  final content = File('assets/data/preguntas.json').readAsStringSync(encoding: utf8);
  final List<dynamic> data = jsonDecode(content);
  
  Set<String> subtemasDB = {};
  for(var q in data) {
    subtemasDB.add(q['codigoTema'] ?? q['codigo_tema'] ?? '');
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
  
  temasOficiales.forEach((materia, codigos) {
    for (var codigo in codigos) {
      if (!subtemasDB.contains(codigo)) {
        print(materia + ': ' + codigo);
      }
    }
  });
}
