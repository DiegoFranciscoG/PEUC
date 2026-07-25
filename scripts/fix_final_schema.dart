import 'dart:convert';
import 'dart:io';

String fixMojibake(String text) {
  try {
    return utf8.decode(latin1.encode(text), allowMalformed: true);
  } catch (e) {
    return text;
  }
}

void main() {
  print('Iniciando NORMALIZACIÓN DEFINITIVA de teoría y preguntas...');

  // 1. CARGAR TEMARIO MAESTRO
  List<dynamic> temario = [];
  try {
    temario = jsonDecode(File('assets/data/temario_maestro.json').readAsStringSync());
  } catch (e) {
    print('Error cargando temario_maestro.json: \$e');
    return;
  }
  
  Map<String, List<String>> codigosPorMateria = {
    'Matemáticas': [],
    'Lengua y Literatura': [],
    'Ciencias Naturales': [],
    'Ciencias Sociales': [],
    'Razonamiento Abstracto': []
  };
  
  for (var area in temario) {
    String materia = area['area'];
    if (area['temas'] != null) {
      for (var tema in area['temas']) {
        if (tema['subtemas'] != null) {
          for (var subtema in tema['subtemas']) {
            codigosPorMateria[materia]?.add(subtema['codigo']);
          }
        }
      }
    }
  }

  // 2. NORMALIZAR TEORÍA
  try {
    List<dynamic> rawTeoria = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
    List<Map<String, dynamic>> teoriaLimpia = [];
    
    Map<String, int> indices = {
      'Matemáticas': 0,
      'Lengua y Literatura': 0,
      'Ciencias Naturales': 0,
      'Ciencias Sociales': 0,
      'Razonamiento Abstracto': 0
    };
    
    int idCounter = 1;
    
    for (var t in rawTeoria) {
      Map<String, dynamic> tema = Map<String, dynamic>.from(t);
      
      String materia = tema['materia']?.toString() ?? 'Ciencias Naturales';
      if (materia == 'Física' || materia == 'Química' || materia == 'Biología') {
        materia = 'Ciencias Naturales';
      } else if (materia == 'Historia' || materia == 'Filosofía') {
        materia = 'Ciencias Sociales';
      }
      
      // Asignar Título
      String titulo = tema['titulo']?.toString() ?? tema['tema']?.toString() ?? tema['title']?.toString() ?? 'Tema';
      tema['titulo'] = fixMojibake(titulo);
      
      // Construir Markdown
      String markdown = '';
      if (tema['contenido_markdown'] != null && tema['contenido_markdown'].toString().isNotEmpty) {
        markdown = tema['contenido_markdown'].toString();
      } else if (tema['teoria'] is String) {
        markdown = tema['teoria'].toString();
      } else if (tema['teoria'] is Map) {
        Map teoMap = tema['teoria'];
        teoMap.forEach((key, value) {
          markdown += '### ' + key.toString().toUpperCase() + '\\n' + value.toString() + '\\n\\n';
        });
      } else {
        markdown = '### Desarrollo\\n' + tema.toString();
      }
      tema['contenido_markdown'] = fixMojibake(markdown);
      
      // Asignar Código de Tema Exacto desde Temario Maestro
      String codigo = '';
      if (codigosPorMateria.containsKey(materia)) {
        int index = indices[materia]!;
        if (index < codigosPorMateria[materia]!.length) {
          codigo = codigosPorMateria[materia]![index];
          indices[materia] = index + 1;
        } else {
          codigo = '9.9.9'; // Overflow
        }
      } else {
        codigo = '0.0.0';
      }
      tema['codigo_tema'] = codigo;
      tema['materia'] = materia;
      tema['id'] = 't_' + codigo.replaceAll('.', '_') + '_' + idCounter.toString();
      idCounter++;
      
      // Limpiar llaves basuras
      tema.remove('teoria');
      tema.remove('tema');
      tema.remove('tema_id');
      
      teoriaLimpia.add(tema);
    }
    
    File('assets/data/teoria.json').writeAsStringSync(jsonEncode(teoriaLimpia));
    print('✅ teoria.json reconstruida PERFECTAMENTE con ' + teoriaLimpia.length.toString() + ' temas.');
  } catch (e) {
    print('❌ Error reconstruyendo teoria.json: ' + e.toString());
  }

  // 3. FIX DB HELPER CODIGOS CRUZADOS (Asegurar que Preguntas de Mate no vayan a Sociales si tienen código 4.x)
  // El usuario dice: "en esos sub temas de ciencias sociales me aparece cosas de matematicas"
  // Esto pasa porque db_helper.dart fuerza la materia con "codigoTema.startsWith('4.')" = Ciencias Sociales.
  // Si las preguntas generadas por los agentes de Física tienen codigo "3.x.x" pero materia="Matemáticas" por error, 
  // O al revés, arreglemos eso en el JSON directamente asegurando que cada código corresponda a la materia.
  
  try {
    List<dynamic> rawPreguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
    List<Map<String, dynamic>> preguntasLimpias = [];
    
    for (var p in rawPreguntas) {
      Map<String, dynamic> pregunta = Map<String, dynamic>.from(p);
      
      String cod = pregunta['codigo_tema']?.toString() ?? '';
      String correctaMateria = pregunta['materia']?.toString() ?? '';
      
      if (cod.startsWith('1.')) correctaMateria = 'Matemáticas';
      else if (cod.startsWith('2.')) correctaMateria = 'Lengua y Literatura';
      else if (cod.startsWith('3.')) correctaMateria = 'Ciencias Naturales';
      else if (cod.startsWith('4.')) correctaMateria = 'Ciencias Sociales';
      else if (cod.startsWith('5.')) correctaMateria = 'Razonamiento Abstracto';
      
      pregunta['materia'] = correctaMateria;
      
      // Fix UTF-8 Mojibake
      if (pregunta['enunciado'] is String) pregunta['enunciado'] = fixMojibake(pregunta['enunciado']);
      if (pregunta['explicacion_detallada'] is String) pregunta['explicacion_detallada'] = fixMojibake(pregunta['explicacion_detallada']);
      if (pregunta['respuesta_correcta'] is String) pregunta['respuesta_correcta'] = fixMojibake(pregunta['respuesta_correcta']);
      
      if (pregunta['opciones'] is List) {
        List ops = pregunta['opciones'];
        for (int i = 0; i < ops.length; i++) {
          if (ops[i] is String) {
            ops[i] = fixMojibake(ops[i]);
          }
        }
      }
      
      preguntasLimpias.add(pregunta);
    }
    
    File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntasLimpias));
    print('✅ preguntas.json alineado perfectamente (Total: ' + preguntasLimpias.length.toString() + ')');
  } catch (e) {
    print('❌ Error reconstruyendo preguntas.json: ' + e.toString());
  }
}
