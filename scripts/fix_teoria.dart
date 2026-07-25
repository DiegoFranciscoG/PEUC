import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  print('Iniciando pulido final: UTF-8 y Saneamiento de Materias en Teoría...');

  final temarioFile = File('assets/data/temario_maestro.json');
  final List<dynamic> temarioList = jsonDecode(await temarioFile.readAsString());
  Map<String, String> materiaOficialPorCodigo = {};
  for (var t in temarioList) {
    materiaOficialPorCodigo[t['codigo'].toString()] = t['area'].toString();
  }

  final teoriaFile = File('assets/data/teoria.json');
  final String teoriaStr = await teoriaFile.readAsString();
  
  // Arreglar caracteres rotos antes de decodificar JSON (si es posible)
  // Reemplazos de doble codificación UTF-8
  String fixedStr = teoriaStr
      .replaceAll('Ã¡', 'á')
      .replaceAll('Ã©', 'é')
      .replaceAll('Ã\xad', 'í')
      .replaceAll('Ã³', 'ó')
      .replaceAll('Ãº', 'ú')
      .replaceAll('Ã±', 'ñ')
      .replaceAll('Ã\x81', 'Á')
      .replaceAll('Ã\x89', 'É')
      .replaceAll('Ã\x8d', 'Í')
      .replaceAll('Ã\x93', 'Ó')
      .replaceAll('Ã\x9a', 'Ú')
      .replaceAll('Ã\x91', 'Ñ')
      .replaceAll('Ã³', 'ó')
      .replaceAll('filosofÃa', 'filosofía')
      .replaceAll('SÃ³crates', 'Sócrates')
      .replaceAll('ArjÃ©', 'Arjé')
      .replaceAll('ǭ', 'á')
      .replaceAll('Ǹ', 'é')
      .replaceAll('ǧ', 'ú');
      
  // Decodificar
  List<dynamic> teoriaListJson;
  try {
    teoriaListJson = jsonDecode(fixedStr);
  } catch (e) {
    teoriaListJson = jsonDecode(teoriaStr);
  }

  for (var i = 0; i < teoriaListJson.length; i++) {
    final t = Map<String, dynamic>.from(teoriaListJson[i]);
    final codigo = t['codigo_tema']?.toString() ?? '';
    
    // 3. SANEAMIENTO DE MATERIAS
    String materiaCorrecta = t['materia'] ?? '';
    if (codigo.startsWith('1.')) materiaCorrecta = 'Matemáticas';
    else if (codigo.startsWith('2.')) materiaCorrecta = 'Lengua y Literatura';
    else if (codigo.startsWith('3.')) materiaCorrecta = 'Ciencias Naturales';
    else if (codigo.startsWith('4.')) materiaCorrecta = 'Ciencias Sociales';
    else if (codigo.startsWith('5.')) materiaCorrecta = 'Razonamiento Abstracto';
    
    // Validar cruzamiento
    if (t['materia'] != materiaCorrecta) {
      print("Corrigiendo materia cruzada en \$codigo: \${t['materia']} -> \$materiaCorrecta");
      t['materia'] = materiaCorrecta;
    }

    // Refetch de Wikipedia si sigue habiendo ''
    String contenido = t['contenido_markdown']?.toString() ?? '';
    if (contenido.contains('')) {
      print('Detectado  en \$codigo, recuperando de Wikipedia...');
      try {
        final titulo = t['titulo']?.toString() ?? materiaCorrecta;
        final query = Uri.encodeComponent(titulo);
        final url = Uri.parse('https://es.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro=1&explaintext=1&titles=\$query');
        final response = await http.get(url).timeout(const Duration(seconds: 5));
        
        if (response.statusCode == 200) {
          final data = jsonDecode(utf8.decode(response.bodyBytes));
          final pages = data['query']?['pages'] as Map<String, dynamic>?;
          if (pages != null && pages.isNotEmpty) {
            final page = pages.values.first;
            if (page.containsKey('extract') && page['extract'].toString().isNotEmpty) {
              t['contenido_markdown'] = "### Resumen Oficial\\n\\n" + page['extract'].toString();
              print('   -> Recuperado exitosamente.');
            }
          }
        }
      } catch (e) {
        print('   -> Error al recuperar de Wikipedia: \$e');
      }
    }

    teoriaListJson[i] = t;
  }

  // Escribir estrictamente en UTF-8
  await teoriaFile.writeAsString(jsonEncode(teoriaListJson), encoding: utf8);
  print('✅ teoria.json saneado y guardado en UTF-8.');
}
