import 'dart:convert';
import 'dart:io';

void main() {
  print('=== VERIFICANDO ENCODING EN DB JSON ===');
  
  bool errorEncontrado = false;
  
  void verificarArchivo(String path) {
    try {
      String raw = File(path).readAsStringSync();
      if (raw.contains('Ã©') || raw.contains('Ã±') || raw.contains('Ã')) {
        print('❌ ERROR FATAL: Mojibake detectado en ' + path);
        errorEncontrado = true;
      } else {
        print('✅ Encoding limpio en ' + path);
      }
    } catch (e) {
      print('❌ ERROR: No se pudo leer ' + path);
      errorEncontrado = true;
    }
  }

  verificarArchivo('assets/data/preguntas.json');
  verificarArchivo('assets/data/teoria.json');
  verificarArchivo('assets/data/temario_maestro.json');

  if (errorEncontrado) {
    print('\\n❌ EL BUILD FUE CANCELADO PORQUE SE DETECTÓ MOJIBAKE (Encoding Corrupto).');
    print('Por favor, repara los JSON usando scripts/clean_data.dart antes de compilar.');
    exit(1);
  } else {
    print('\\n✅ Verificación de Encoding pasada exitosamente. Puedes proceder a compilar.');
    exit(0);
  }
}
