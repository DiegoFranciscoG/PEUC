import 'dart:convert';
import 'dart:io';

void main() {
  final path = 'assets/data/preguntas.json';
  if (!File(path).existsSync()) {
    print('No se encontró preguntas.json');
    return;
  }

  final String content = File(path).readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  int totalSociales = 0;
  int placeholders = 0;
  
  Map<String, int> conteoReal = {};
  Map<String, int> conteoPlaceholder = {};

  // Social Science codes: 4.1.1 to 4.11.1
  for (var q in jsonList) {
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    if (codigo.startsWith('4.')) {
      totalSociales++;
      String enunciado = q['enunciado'] ?? '';
      List<dynamic> opciones = q['opciones'] ?? [];
      
      bool isPlaceholder = false;
      if (enunciado.toLowerCase().contains('pregunta oficial del tema') ||
          enunciado.toLowerCase().contains('sobre ciencias sociales')) {
        isPlaceholder = true;
      }
      for (var op in opciones) {
        String optStr = op.toString().toLowerCase();
        if (optStr.contains('opción a (correcta)') || 
            optStr.contains('opción b (incorrecta)') ||
            optStr.contains('opcion a (correcta)') ||
            optStr.contains('incorrecta)')) {
          isPlaceholder = true;
        }
      }

      if (!conteoReal.containsKey(codigo)) {
        conteoReal[codigo] = 0;
        conteoPlaceholder[codigo] = 0;
      }

      if (isPlaceholder) {
        placeholders++;
        conteoPlaceholder[codigo] = conteoPlaceholder[codigo]! + 1;
      } else {
        conteoReal[codigo] = conteoReal[codigo]! + 1;
      }
    }
  }

  print('=== AUDITORIA CIENCIAS SOCIALES ===');
  print('Total preguntas 4.x: $totalSociales');
  print('Placeholders detectados: $placeholders');
  print('Detalle por código (4.x):');
  
  conteoReal.keys.toList()..sort()..forEach((codigo) {
    int reales = conteoReal[codigo] ?? 0;
    int falsas = conteoPlaceholder[codigo] ?? 0;
    if (falsas > 0) {
      print('  $codigo -> REALES: $reales | PLACEHOLDERS: $falsas');
    }
  });

  print('\\nResumen de códigos a reparar:');
  conteoReal.keys.toList()..sort()..forEach((codigo) {
    int reales = conteoReal[codigo] ?? 0;
    int falsas = conteoPlaceholder[codigo] ?? 0;
    if (reales < 20) {
      print('  $codigo necesita ${20 - reales} preguntas nuevas (Reales actuales: $reales).');
    }
  });
}
