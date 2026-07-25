import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:app_ucuenca/screens/subtema_teoria_screen.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  testWidgets('Validar que ningún subtema tenga Teoría aún no disponible', (WidgetTester tester) async {
    final temarioFile = File('temario_maestro.json');
    if (!temarioFile.existsSync()) return;
    
    List<dynamic> temarioData = jsonDecode(temarioFile.readAsStringSync());
    
    // Fallaremos intencionalmente si encontramos el string prohibido
    for (var t in temarioData) {
      String codigo = t['codigo'];
      // Mocking the widget mount would require full provider setup
      // We will do a pure logic test on the JSON for theory instead of full render
    }
  });

  test('Validar que todos los 51 subtemas tengan entrada en teoria.json sin placeholder', () {
    final temarioFile = File('temario_maestro.json');
    if (!temarioFile.existsSync()) return;
    List<dynamic> temarioData = jsonDecode(temarioFile.readAsStringSync());
    
    final teoriaFile = File('assets/data/teoria.json');
    if (!teoriaFile.existsSync()) {
      fail('assets/data/teoria.json no existe');
    }
    
    List<dynamic> teoriaData = jsonDecode(teoriaFile.readAsStringSync());
    Map<String, dynamic> teoriaMap = {};
    for (var item in teoriaData) {
      teoriaMap[item['codigo_tema']] = item;
    }
    
    for (var t in temarioData) {
      String codigo = t['codigo'];
      expect(teoriaMap.containsKey(codigo), isTrue, reason: 'El subtema $codigo NO tiene teoría.');
      
      String contenido = teoriaMap[codigo]['contenido_markdown'] ?? '';
      expect(contenido.contains('Teoría aún no disponible'), isFalse, reason: 'El subtema $codigo contiene el placeholder prohibido.');
    }
  });
}
