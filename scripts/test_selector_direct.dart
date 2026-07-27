import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  final dbFactory = databaseFactoryFfi;
  final dbPath = 'C:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/.dart_tool/sqflite_common_ffi/databases/peuc_v6.db';
  
  if (!File(dbPath).existsSync()) {
    print('DB no existe en \$dbPath');
    return;
  }
  
  final db = await dbFactory.openDatabase(dbPath);

  final areas = [
    'Matemáticas',
    'Lengua y Literatura',
    'Ciencias Naturales',
    'Ciencias Sociales',
    'Razonamiento Abstracto'
  ];

  for (var area in areas) {
    print('\\n==========================================');
    print('ÁREA: \$area');
    print('==========================================');
    
    String prefix = '';
    if (area == 'Matemáticas') prefix = '1.%';
    else if (area == 'Lengua y Literatura') prefix = '2.%';
    else if (area == 'Ciencias Naturales') prefix = '3.%';
    else if (area == 'Ciencias Sociales') prefix = '4.%';
    else if (area == 'Razonamiento Abstracto') prefix = '5.%';

    for (int run = 1; run <= 5; run++) {
      print('--- Corrida \$run ---');
      
      // RUN THE EXACT LOGIC AS DB_HELPER
      final resSubtemas = await db.rawQuery(
        'SELECT codigo_tema, COUNT(*) as qty FROM preguntas WHERE codigo_tema LIKE ? GROUP BY codigo_tema HAVING qty > 0',
        [prefix]
      );

      List<Map<String, dynamic>> subtemasList = List<Map<String, dynamic>>.from(resSubtemas);
      subtemasList.shuffle();
      
      int numSubtemas = subtemasList.length;
      int base = 12 ~/ numSubtemas;
      int residuo = 12 % numSubtemas;

      Map<String, int> cuotas = {};
      for (int i = 0; i < numSubtemas; i++) {
        String codigo = subtemasList[i]['codigo_tema'] as String;
        int quota = base + (i < residuo ? 1 : 0);
        cuotas[codigo] = quota;
      }

      List<Map<String, dynamic>> seleccionadas = [];
      int deficitTotal = 0;
      List<String> subtemasSobrantes = [];

      for (var row in subtemasList) {
        String codigo = row['codigo_tema'] as String;
        int quota = cuotas[codigo]!;
        int stock = row['qty'] as int;

        if (quota > stock) {
          deficitTotal += (quota - stock);
          quota = stock;
        } else if (stock > quota) {
          subtemasSobrantes.add(codigo);
        }

        if (quota > 0) {
          final resPreguntas = await db.query(
            'preguntas',
            where: 'codigo_tema = ?',
            whereArgs: [codigo],
            orderBy: 'RANDOM()',
            limit: quota,
          );
          seleccionadas.addAll(resPreguntas);
        }
      }

      while (deficitTotal > 0 && subtemasSobrantes.isNotEmpty) {
        subtemasSobrantes.shuffle();
        String subtemaExtra = subtemasSobrantes.first;
        
        List<String> idsSeleccionados = seleccionadas.map((e) => e['id'] as String).toList();
        String placeholders = idsSeleccionados.map((e) => '?').join(',');
        
        final resExtra = await db.query(
          'preguntas',
          where: 'codigo_tema = ? AND id NOT IN (\$placeholders)',
          whereArgs: [subtemaExtra, ...idsSeleccionados],
          orderBy: 'RANDOM()',
          limit: 1,
        );

        if (resExtra.isNotEmpty) {
          seleccionadas.add(resExtra.first);
          deficitTotal--;
        } else {
          subtemasSobrantes.remove(subtemaExtra);
        }
      }
      
      Map<String, int> conteo = {};
      for (var p in seleccionadas) {
        String c = p['codigo_tema'] as String;
        conteo[c] = (conteo[c] ?? 0) + 1;
      }
      
      final keys = conteo.keys.toList()..sort();
      for (var k in keys) {
        // Find if this key got extra
        int org = cuotas[k] ?? 0;
        int actual = conteo[k]!;
        String extraMarker = actual > org ? ' (+ extra x déficit)' : '';
        print('  Subtema \$k: \$actual preguntas\$extraMarker');
      }
      print('  TOTAL: \${seleccionadas.length}');
    }
  }
}
