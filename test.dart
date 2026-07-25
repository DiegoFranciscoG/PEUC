import 'dart:convert';
import 'dart:io';

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  for (var i = 0; i < data.length; i++) {
    var rawMap = data[i];
    final preguntaMap = Map<String, dynamic>.from(rawMap);
    
    // Check type of tiempoEstimado
    var te = preguntaMap['tiempoEstimado'] ?? preguntaMap['tiempo_estimado'] ?? 60;
    if (te != null && te is! int) {
      print('Item \$i has non-int tiempo_estimado: \$te (\${te.runtimeType})');
    }
    
    // Check es_opciones_imagen
    var eo = preguntaMap['esOpcionesImagen'] ?? preguntaMap['es_opciones_imagen'] ?? false;
    if (eo != null && eo is! bool && eo is! int) {
      print('Item \$i has non-bool/int es_opciones_imagen: \$eo (\${eo.runtimeType})');
    }
  }
  
  final tdata = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
  for (var i = 0; i < tdata.length; i++) {
    var rawMap = tdata[i];
    final tMap = Map<String, dynamic>.from(rawMap);
    // ...
  }
  print('Done checking types.');
}
