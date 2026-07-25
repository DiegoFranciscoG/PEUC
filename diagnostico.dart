import 'dart:convert';
import 'dart:io';

void main() {
  try {
    final t = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
    print("====== TEORIA ======");
    for (int i = 0; i < 3; i++) {
      if (i < t.length) {
        print("T[\$i]: " + t[i]['codigo_tema'].toString() + " | " + t[i]['titulo'].toString());
        print("Markdown corto: " + (t[i]['contenido_markdown']?.toString().substring(0, 50) ?? 'null'));
      }
    }
    
    final p = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
    print("====== PREGUNTAS ======");
    for (int i = 0; i < p.length; i++) {
      if (p[i]['codigo_tema'] == '3.7.5') {
        print("Pregunta 3.7.5:");
        print("Enunciado: " + p[i]['enunciado'].toString());
        break; // Solo la primera
      }
    }
    for (int i = 0; i < p.length; i++) {
      if (p[i]['codigo_tema'] == '1.1.1') {
        print("Pregunta 1.1.1:");
        print("Enunciado: " + p[i]['enunciado'].toString());
        break; 
      }
    }
  } catch (e) {
    print("ERROR: \$e");
  }
}
