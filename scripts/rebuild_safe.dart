import 'dart:convert';
import 'dart:io';

void main() {
  print('Iniciando NORMALIZACIÓN TOTAL de datos...');
  
  // 1. NORMALIZAR TEORÍA
  try {
    List<dynamic> rawTeoria = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
    List<Map<String, dynamic>> teoriaLimpia = [];
    int idCounter = 1;
    
    for (var t in rawTeoria) {
      Map<String, dynamic> tema = Map<String, dynamic>.from(t);
      
      // Extraer y unificar codigo_tema
      String codigo = tema['codigo_tema']?.toString() ?? tema['codigoTema']?.toString() ?? tema['tema_id']?.toString() ?? '';
      if (codigo.startsWith('0.0')) codigo = ''; // Remover el fallback fallido anterior
      
      if (codigo.isEmpty) {
        codigo = 'gen_\${idCounter}';
      } else {
        // Limpiar si vino como "3.7.8 El campo..."
        codigo = codigo.split(' ').first;
      }
      tema['codigo_tema'] = codigo;
      
      // Asegurar ID único y válido
      tema['id'] = 't_' + codigo.replaceAll('.', '_') + '_' + idCounter.toString();
      idCounter++;
      
      teoriaLimpia.add(tema);
    }
    
    File('assets/data/teoria.json').writeAsStringSync(jsonEncode(teoriaLimpia));
    print('✅ teoria.json normalizada con \${teoriaLimpia.length} temas.');
  } catch (e) {
    print('❌ Error normalizando teoria.json: \$e');
  }

  // 2. NORMALIZAR PREGUNTAS
  try {
    List<dynamic> rawPreguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
    List<Map<String, dynamic>> preguntasLimpias = [];
    int idCounter = 1;
    
    for (var p in rawPreguntas) {
      Map<String, dynamic> pregunta = Map<String, dynamic>.from(p);
      
      // Extraer y unificar campos (Soporte para llaves en Inglés de los subagentes)
      String codigo = pregunta['codigo_tema']?.toString() ?? pregunta['codigoTema']?.toString() ?? pregunta['topic']?.toString() ?? '';
      if (codigo.isNotEmpty) {
        codigo = codigo.split(' ').first; // Extraer solo "3.7.8" de "3.7.8 El campo magnético"
      } else {
        codigo = '0.0.0';
      }
      pregunta['codigo_tema'] = codigo;
      
      // ID Seguro
      pregunta['id'] = 'p_' + codigo.replaceAll('.', '_') + '_' + idCounter.toString();
      idCounter++;
      
      // Enunciado
      if (pregunta['enunciado'] == null && pregunta['question'] != null) {
        pregunta['enunciado'] = pregunta['question'];
      }
      
      // Opciones
      if (pregunta['opciones'] == null && pregunta['options'] != null) {
        pregunta['opciones'] = pregunta['options'];
      }
      
      // Respuesta Correcta
      if (pregunta['respuesta_correcta'] == null && pregunta['correct_answer'] != null) {
        // A veces correct_answer es el índice (0, 1, 2)
        var ca = pregunta['correct_answer'];
        if (ca is int && pregunta['opciones'] is List) {
          if (ca >= 0 && ca < pregunta['opciones'].length) {
            pregunta['respuesta_correcta'] = pregunta['opciones'][ca];
          }
        } else {
          pregunta['respuesta_correcta'] = ca.toString();
        }
      }
      
      // Explicación
      if (pregunta['explicacion_detallada'] == null && pregunta['explanation'] != null) {
        pregunta['explicacion_detallada'] = pregunta['explanation'];
      }
      
      // Materia
      if (pregunta['materia'] == null && pregunta['subject'] != null) {
        pregunta['materia'] = pregunta['subject'];
      }
      
      preguntasLimpias.add(pregunta);
    }
    
    File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntasLimpias));
    print('✅ preguntas.json normalizada con \${preguntasLimpias.length} preguntas.');
  } catch (e) {
    print('❌ Error normalizando preguntas.json: \$e');
  }
}
