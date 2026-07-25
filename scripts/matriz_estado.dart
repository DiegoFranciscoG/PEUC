import 'dart:convert';
import 'dart:io';

void main() {
  final String content = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> jsonList = jsonDecode(content);

  Map<String, int> counts = {};
  int totalPlaceholders = 0;

  for (var q in jsonList) {
    String codigo = q['codigo_tema'] ?? q['codigoTema'] ?? '';
    counts[codigo] = (counts[codigo] ?? 0) + 1;

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
    if (isPlaceholder) totalPlaceholders++;
  }

  print('=== MATRIZ DE ESTADO COMPLETA ===');
  print('Total preguntas: ${jsonList.length}');
  print('Total placeholders: $totalPlaceholders');
  print('');
  print('Detalle por código:');
  
  final sortedKeys = counts.keys.toList()..sort((a, b) {
    final pa = a.split('.').map(int.tryParse).toList();
    final pb = b.split('.').map(int.tryParse).toList();
    for (int i = 0; i < pa.length && i < pb.length; i++) {
      if ((pa[i] ?? 0) != (pb[i] ?? 0)) return (pa[i] ?? 0).compareTo(pb[i] ?? 0);
    }
    return pa.length.compareTo(pb.length);
  });

  int codesBelow20 = 0;
  for (var k in sortedKeys) {
    final count = counts[k]!;
    final status = count >= 20 ? '✅' : '❌';
    if (count < 20) codesBelow20++;
    print('  $status $k: $count preguntas');
  }

  print('');
  print('Códigos por debajo de 20: $codesBelow20');
  print('Total códigos únicos: ${counts.length}');
}
