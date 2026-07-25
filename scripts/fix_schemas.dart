import 'dart:convert';
import 'dart:io';

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  final List<dynamic> fixedData = [];
  
  for (int i = 0; i < data.length; i++) {
    Map<String, dynamic> q = Map<String, dynamic>.from(data[i]);
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    
    if (codigo == '4.5.2') {
      if (q['pregunta'] != null && q['enunciado'] == null) {
        q['enunciado'] = q['pregunta'];
        q.remove('pregunta');
      }
    }
    
    if (codigo == '4.5.3' || codigo == '4.6.1') {
      if (q['opciones'] is List && q['opciones'].isNotEmpty && q['opciones'][0] is Map) {
        List<String> newOps = [];
        String correcta = '';
        for (var opObj in q['opciones']) {
          newOps.add(opObj['texto'] ?? opObj['opcion'] ?? '');
          if (opObj['correcta'] == true || opObj['es_correcta'] == true || opObj['isCorrect'] == true) {
            correcta = opObj['texto'] ?? opObj['opcion'] ?? '';
          }
        }
        q['opciones'] = newOps;
        q['respuesta_correcta'] = correcta;
      }
    }
    
    if (codigo == '4.7.1') {
      if (q['opcion_a'] != null) {
        q['opciones'] = [
          q['opcion_a'],
          q['opcion_b'],
          q['opcion_c'],
          q['opcion_d']
        ];
        String correctKey = q['respuesta_correcta'] ?? q['respuestaCorrecta'] ?? '';
        if (correctKey.startsWith('opcion_')) {
          q['respuesta_correcta'] = q[correctKey];
        }
        q.remove('opcion_a');
        q.remove('opcion_b');
        q.remove('opcion_c');
        q.remove('opcion_d');
      }
    }
    
    if (q['id'] == 'q_4.5.1_1784965653643006') {
      q['opciones'][0] = "El Principado mantuvo la ficción republicana con el emperador como 'primero entre iguales', mientras que el Dominado era una monarquía abiertamente absoluta y divina, donde el emperador se presentaba como un dios viviente con ceremonial oriental.";
    }
    
    if (q['id'] == 'q_4.8.1_1784965653392243') {
      q['opciones'][0] = "Las mujeres obreras participaron masivamente en las fábricas con salarios inferiores a los hombres, mientras que el ideal burgués de la 'mujer del hogar' ('ángel del hogar' victoriana) excluía a las mujeres de clase media del trabajo remunerado como marca de estatus.";
    }
    
    fixedData.add(q);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(fixedData));
  print('✅ Esquemas normalizados.');
}
