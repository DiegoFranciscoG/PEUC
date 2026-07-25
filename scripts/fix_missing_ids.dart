import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  final data = jsonDecode(File('assets/data/preguntas.json').readAsStringSync()) as List;
  int noId = 0;
  final Random rng = Random();
  final List<dynamic> fixed = [];
  
  for (var q in data) {
    final map = Map<String, dynamic>.from(q);
    if (map['id'] == null) {
      noId++;
      // Generate a stable ID from codigo_tema + index
      final ts = DateTime.now().microsecondsSinceEpoch + rng.nextInt(999999);
      map['id'] = 'q_${map['codigo_tema'] ?? 'x'}_$ts';
    }
    fixed.add(map);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(fixed));
  print('Preguntas sin id ANTES: $noId de ${data.length}');
  print('✅ IDs generados y guardados.');
}
