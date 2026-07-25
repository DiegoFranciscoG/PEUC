import 'dart:convert';
import 'dart:io';

void main() {
  print('=== DIAGNÓSTICO V15 ===');
  
  // 1. REVISAR PREGUNTAS
  try {
    List<dynamic> p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
    print('Total preguntas: ' + p.length.toString());
    
    int mathInSocial = 0;
    for (var q in p) {
      if (q['materia'] == 'Ciencias Sociales') {
        String enun = q['enunciado'].toString();
        if (enun.contains('\$') || enun.contains('ecuación') || enun.contains('f(x)')) {
          mathInSocial++;
          print('Posible cruzada: ' + q['codigo_tema'] + ' - ' + enun.substring(0, 30));
        }
      }
    }
    print('Preguntas cruzadas encontradas en Sociales: ' + mathInSocial.toString());
    
  } catch(e) {
    print('Error: ' + e.toString());
  }

  // 2. REVISAR TEORÍA
  try {
    List<dynamic> t = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
    print('Total teoria: ' + t.length.toString());
    
    bool has375 = false;
    for (var teo in t) {
      if (teo['codigo_tema'] == '3.7.5') has375 = true;
    }
    print('¿Existe teoría para 3.7.5?: ' + has375.toString());
    
  } catch(e) {}
}
