import 'dart:convert';
import 'dart:io';

void main() {
  final jsonStr = File('assets/data/preguntas.json').readAsStringSync();
  final List<dynamic> allPreguntas = jsonDecode(jsonStr);

  final areas = [
    'Matemáticas',
    'Lengua y Literatura',
    'Ciencias Naturales',
    'Ciencias Sociales',
    'Razonamiento Abstracto'
  ];

  for (var area in areas) {
    print('\\n==========================================');
    print('ÁREA: $area');
    print('==========================================');
    
    String prefix = '';
    if (area == 'Matemáticas') prefix = '1.';
    else if (area == 'Lengua y Literatura') prefix = '2.';
    else if (area == 'Ciencias Naturales') prefix = '3.';
    else if (area == 'Ciencias Sociales') prefix = '4.';
    else if (area == 'Razonamiento Abstracto') prefix = '5.';

    // Filtrar preguntas de la materia
    final preguntasArea = allPreguntas.where((p) {
      String codigo = p['codigoTema'] ?? p['codigo_tema'] ?? '';
      return codigo.startsWith(prefix);
    }).toList();

    for (int run = 1; run <= 5; run++) {
      print('--- Corrida $run ---');
      
      // Obtener subtemas disponibles con stock
      Map<String, int> stockPorSubtema = {};
      for (var p in preguntasArea) {
        String codigo = p['codigoTema'] ?? p['codigo_tema'];
        stockPorSubtema[codigo] = (stockPorSubtema[codigo] ?? 0) + 1;
      }
      
      List<String> subtemasList = stockPorSubtema.keys.toList();
      subtemasList.shuffle();
      
      int numSubtemas = subtemasList.length;
      int base = 12 ~/ numSubtemas;
      int residuo = 12 % numSubtemas;

      Map<String, int> cuotas = {};
      for (int i = 0; i < numSubtemas; i++) {
        String codigo = subtemasList[i];
        int quota = base + (i < residuo ? 1 : 0);
        cuotas[codigo] = quota;
      }

      List<dynamic> seleccionadas = [];
      int deficitTotal = 0;
      List<String> subtemasSobrantes = [];

      for (String codigo in subtemasList) {
        int quota = cuotas[codigo]!;
        int stock = stockPorSubtema[codigo]!;

        if (quota > stock) {
          deficitTotal += (quota - stock);
          quota = stock;
        } else if (stock > quota) {
          subtemasSobrantes.add(codigo);
        }

        if (quota > 0) {
          final disponibles = preguntasArea.where((p) => (p['codigoTema'] ?? p['codigo_tema']) == codigo).toList();
          disponibles.shuffle();
          seleccionadas.addAll(disponibles.take(quota));
        }
      }

      while (deficitTotal > 0 && subtemasSobrantes.isNotEmpty) {
        subtemasSobrantes.shuffle();
        String subtemaExtra = subtemasSobrantes.first;
        
        List<String> idsSeleccionados = seleccionadas.map((e) => e['id'] as String).toList();
        
        final disponibles = preguntasArea.where((p) => 
          (p['codigoTema'] ?? p['codigo_tema']) == subtemaExtra && 
          !idsSeleccionados.contains(p['id'])
        ).toList();

        if (disponibles.isNotEmpty) {
          disponibles.shuffle();
          seleccionadas.add(disponibles.first);
          deficitTotal--;
        } else {
          subtemasSobrantes.remove(subtemaExtra);
        }
      }
      
      Map<String, int> conteo = {};
      for (var p in seleccionadas) {
        String c = p['codigoTema'] ?? p['codigo_tema'];
        conteo[c] = (conteo[c] ?? 0) + 1;
      }
      
      final keys = conteo.keys.toList()..sort();
      for (var k in keys) {
        int org = cuotas[k] ?? 0;
        int actual = conteo[k]!;
        String extraMarker = actual > org ? ' (+ extra x déficit de otro)' : '';
        print('  Subtema $k: $actual preguntas$extraMarker');
      }
      print('  TOTAL: ${seleccionadas.length}');
    }
  }
}
