import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  final apiKey = Platform.environment['GEMINI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    print('ERROR: Debes proveer GEMINI_API_KEY en el entorno para la generación masiva.');
    exit(1);
  }

  final temarioFile = File('temario_maestro.json');
  List<dynamic> temarioData = jsonDecode(temarioFile.readAsStringSync());

  for (var t in temarioData) {
    String codigo = t['codigo'];
    String area = t['area'];
    String titulo = t['titulo_oficial'];

    print('Generando contenido para $codigo - $titulo...');
    
    // Aquí implementamos la llamada directa a la API de Gemini
    final prompt = '''
Genera un lote JSON de 15 preguntas de opción múltiple EXCLUSIVAMENTE para:
- Materia: $area
- Código de subtema: $codigo
- Título oficial EXACTO: "$titulo"

Reglas: Cero metatexto. Usa datos duros. 4 opciones. 
Devuelve SOLO un array JSON válido sin bloques markdown.
Estructura: {"id": "${codigo.replaceAll('.','')}_01", "materia": "$area", "codigoTema": "$codigo", "tituloSubtema": "$titulo", "enunciado": "...", "opciones": ["A","B","C","D"], "respuesta_correcta": "A", "explicacion_detallada": "...", "pasos_resolucion": [], "video_explicativo_url": "https://youtube.com..."}
''';

    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [{"parts": [{"text": prompt}]}],
        "generationConfig": {"temperature": 0.2}
      })
    );

    if (response.statusCode == 200) {
      final jsonResp = jsonDecode(response.body);
      String text = jsonResp['candidates'][0]['content']['parts'][0]['text'];
      text = text.replaceAll('```json', '').replaceAll('```', '').trim();
      
      File loteFile = File('lotes_tmp/lote_$codigo.json');
      if (!Directory('lotes_tmp').existsSync()) Directory('lotes_tmp').createSync();
      loteFile.writeAsStringSync(text);

      // Ejecutar validadores en shell
      final resInt = Process.runSync('dart', ['scripts/validar_integridad.dart', loteFile.path]);
      final resAli = Process.runSync('dart', ['scripts/validar_alineacion.dart', loteFile.path]);
      
      if (resInt.exitCode == 0 && resAli.exitCode == 0) {
        print('✅ Lote $codigo aprobado y validado.');
      } else {
        print('❌ Lote $codigo falló validación. Reintentar manualmente.');
      }
    } else {
      print('Error API: ${response.body}');
    }
    
    // Pausa para evitar rate limits
    await Future.delayed(Duration(seconds: 15));
  }
}
