import 'dart:convert';
import 'dart:io';

void main() {
  print('Iniciando INYECCIÓN DE YOUTUBE LINKS V15');

  try {
    List<dynamic> t = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
    int actualizados = 0;
    
    for (var teo in t) {
      if (teo['video_url'] == null || teo['video_url'].toString().isEmpty) {
        String query = teo['materia'].toString() + ' ' + teo['titulo'].toString() + ' bachillerato ecuador';
        String encoded = Uri.encodeComponent(query);
        teo['video_url'] = 'https://www.youtube.com/results?search_query=' + encoded;
        actualizados++;
      }
    }
    
    File('assets/data/teoria.json').writeAsStringSync(jsonEncode(t));
    print('✅ Links inyectados con éxito. Actualizados: ' + actualizados.toString());

  } catch (e) {
    print('❌ Error inyectando links: ' + e.toString());
  }
}
