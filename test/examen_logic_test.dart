import 'package:flutter_test/flutter_test.dart';
import 'package:app_ucuenca/providers/examen_provider.dart';
import 'package:app_ucuenca/models/pregunta.dart';
import 'package:app_ucuenca/database/db_helper.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Validar Aleatoriedad y Aislamiento - 100 Simulacros', () async {
    final provider = ExamenProvider();
    int fallosRepeticion = 0;
    int fallosCruceMateria = 0;

    for (int i = 0; i < 100; i++) {
      await provider.iniciarSimulacroIntensivo(materiaFiltro: 'Ciencias Naturales');
      final simulacro = provider.state.preguntasSimulacro;
      
      Set<String> idsUnicos = {};
      for (var p in simulacro) {
        if (p.materia != 'Ciencias Naturales') {
          fallosCruceMateria++;
        }
        if (idsUnicos.contains(p.id)) {
          fallosRepeticion++;
        }
        idsUnicos.add(p.id);
      }
    }

    expect(fallosRepeticion, 0, reason: 'Se detectaron preguntas repetidas en la misma sesión');
    expect(fallosCruceMateria, 0, reason: 'Se detectaron preguntas de materia incorrecta en el filtro de Ciencias Naturales');
  });
}
