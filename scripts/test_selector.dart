import '../lib/database/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  final db = DBHelper();
  
  for (int i = 1; i <= 3; i++) {
    print('--- Corrida \$i ---');
    final preguntas = await db.getSimulacroPorMateria('Razonamiento Abstracto', 12);
    Map<String, int> conteo = {};
    for (var p in preguntas) {
      conteo[p.codigoTema] = (conteo[p.codigoTema] ?? 0) + 1;
    }
    
    // Sort keys
    final keys = conteo.keys.toList()..sort();
    for (var k in keys) {
      print('  Subtema \$k: \${conteo[k]} preguntas');
    }
  }
}
