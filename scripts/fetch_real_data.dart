import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  print('Iniciando saneamiento de datos y extracción de teoría...');

  // 1. SANEAMIENTO DE PREGUNTAS
  final preguntasFile = File('assets/data/preguntas.json');
  final String preguntasStr = await preguntasFile.readAsString();
  final List<dynamic> preguntasList = jsonDecode(preguntasStr);
  
  List<Map<String, dynamic>> preguntasSaneadas = [];
  int eliminadas = 0;
  int cruzadasCorregidas = 0;

  for (var p in preguntasList) {
    final mapa = Map<String, dynamic>.from(p);
    final enunciado = mapa['enunciado']?.toString() ?? '';
    final opcionesStr = mapa['opciones']?.toString() ?? '';
    final codigo = mapa['codigo_tema']?.toString() ?? '';
    final materiaOriginal = mapa['materia']?.toString() ?? '';

    // Filtrar basura
    if (enunciado.contains('Pregunta Nro.') || 
        enunciado.contains('Pregunta Académica') ||
        opcionesStr.contains('Afirmación A') ||
        codigo.isEmpty) {
      eliminadas++;
      continue;
    }

    // Corregir materia cruzada preservando la pregunta
    String materiaCorrecta = materiaOriginal;
    if (codigo.startsWith('1.')) materiaCorrecta = 'Matemáticas';
    else if (codigo.startsWith('2.')) materiaCorrecta = 'Lengua y Literatura';
    else if (codigo.startsWith('3.')) materiaCorrecta = 'Ciencias Naturales';
    else if (codigo.startsWith('4.')) materiaCorrecta = 'Ciencias Sociales';
    else if (codigo.startsWith('5.')) materiaCorrecta = 'Razonamiento Abstracto';

    if (materiaCorrecta != materiaOriginal) {
      cruzadasCorregidas++;
      mapa['materia'] = materiaCorrecta;
    }

    preguntasSaneadas.add(mapa);
  }

  await preguntasFile.writeAsString(jsonEncode(preguntasSaneadas));
  print('✅ Preguntas saneadas: ${preguntasSaneadas.length}');
  print('🗑️ Preguntas basura eliminadas: $eliminadas');
  print('🔄 Materias cruzadas corregidas: $cruzadasCorregidas');

  // 2. EXTRACCIÓN DE TEORÍA REAL DE WIKIPEDIA
  final teoriaFile = File('assets/data/teoria.json');
  final String teoriaStr = await teoriaFile.readAsString();
  final List<dynamic> teoriaList = jsonDecode(teoriaStr);
  
  print('Descargando contexto histórico y científico de Wikipedia API...');
  
  for (var i = 0; i < teoriaList.length; i++) {
    final t = Map<String, dynamic>.from(teoriaList[i]);
    final titulo = t['titulo']?.toString() ?? '';
    final codigo = t['codigo_tema']?.toString() ?? '';
    
    // Solo expandimos si el contenido es pobre o genérico
    final contenido = t['contenido_markdown']?.toString() ?? '';
    if (contenido.length < 500 || contenido.contains('Teoría no disponible')) {
      print('Buscando datos reales para: $titulo ($codigo)...');
      try {
        final query = Uri.encodeComponent(titulo);
        final url = Uri.parse('https://es.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro=1&explaintext=1&titles=$query');
        final response = await http.get(url).timeout(const Duration(seconds: 5));
        
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final pages = data['query']?['pages'] as Map<String, dynamic>?;
          if (pages != null && pages.isNotEmpty) {
            final page = pages.values.first;
            if (page.containsKey('extract') && page['extract'].toString().isNotEmpty) {
              final extractoReal = page['extract'].toString();
              // Enriquecer el markdown
              t['contenido_markdown'] = "### Resumen Oficial (Wikipedia)\\n\\n$extractoReal\\n\\n---\\n\\n" + contenido;
              teoriaList[i] = t;
              print('   -> Datos integrados exitosamente.');
            }
          }
        }
      } catch (e) {
        print('   -> Error al descargar API: $e');
      }
    }
  }

  await teoriaFile.writeAsString(jsonEncode(teoriaList));
  print('✅ Teoría enriquecida con datos reales de APIs.');
  print('🚀 Script completado.');
}
