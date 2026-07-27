import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/database/db_helper.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('Prueba de distribución proporcional del selector por materia (5 corridas x 5 áreas)', () async {
    final db = DBHelper();
    
    // Forzar inicialización
    await db.database;

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
      for (int i = 1; i <= 5; i++) {
        print('--- Corrida \$i ---');
        final preguntas = await db.getSimulacroPorMateria(area, 12);
        
        expect(preguntas.length, 12, reason: 'Debe retornar exactamente 12 preguntas');

        Map<String, int> conteo = {};
        for (var p in preguntas) {
          conteo[p.codigoTema] = (conteo[p.codigoTema] ?? 0) + 1;
        }
        
        final keys = conteo.keys.toList()..sort();
        for (var k in keys) {
          print('  Subtema \$k: \${conteo[k]} preguntas');
        }
        print('  TOTAL: \${preguntas.length}\\n');
      }
    }
  });
}
