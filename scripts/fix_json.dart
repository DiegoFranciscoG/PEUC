import 'dart:convert';
import 'dart:io';

Future<void> sanitizeAndSave(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    print('⚠️ \$path no existe.');
    return;
  }
  
  String content = await file.readAsString();
  
  // Si el JSON ya es válido y puede ser decodificado:
  List<dynamic> data;
  try {
    data = jsonDecode(content);
    print('✅ \$path es JSON VÁLIDO. Procediendo a re-codificar para máxima seguridad.');
  } catch (e) {
    print('❌ ERROR en \$path: \$e. Intentando reparar...');
    
    // Heurística de reparación: escapar barras invertidas que no estén seguidas de caracteres válidos de escape
    content = content.replaceAll(RegExp(r'\\(?=[^"\\/bfnrt])'), r'\\');
    
    try {
      data = jsonDecode(content);
      print('✅ \$path reparado exitosamente.');
    } catch (e2) {
      print('❌ ERROR FATAL en \$path: \$e2');
      return;
    }
  }

  // Recorrer los datos para asegurarse de que todos los campos string estén limpios
  // (Aunque jsonEncode ya se encarga de escapar las cosas correctamente para el estándar JSON)
  String cleanJson = jsonEncode(data);
  
  // Guardar sobreescribiendo en UTF-8 puro
  await file.writeAsString(cleanJson, encoding: utf8);
  print('✅ \$path reescrito exitosamente de forma segura.');
}

Future<void> main() async {
  print('Iniciando saneamiento profundo de JSON...');
  await sanitizeAndSave('assets/data/teoria.json');
  await sanitizeAndSave('assets/data/preguntas.json');
  print('🚀 Saneamiento finalizado.');
}
