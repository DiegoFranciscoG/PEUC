import 'dart:io';

void main() {
  final file = File('lib/utils/generador_algoritmico.dart');
  String content = file.readAsStringSync();

  // Polinomio
  content = content.replaceAll('final a = _ri(1, 5);', 'final a = _ri(1, 12);');
  content = content.replaceAll('final b = _ri(1, 5);', 'final b = _ri(1, 12);');
  content = content.replaceAll('final c = _ri(1, 5);', 'final c = _ri(1, 12);');

  // Factorizacion
  content = content.replaceAll('final a = _ri(2, 7);', 'final a = _ri(2, 15);');
  content = content.replaceAll('final b = _ri(2, 7);', 'final b = _ri(2, 15);');

  // Ecuacion Cuadratica
  content = content.replaceAll('final r1 = _ri(1, 8);', 'final r1 = _ri(1, 15);');
  content = content.replaceAll('final r2 = _ri(1, 8);', 'final r2 = _ri(1, 15);');

  // Funcion Lineal
  content = content.replaceAll('final m = _ri(1, 8);', 'final m = _ri(-8, 12);');
  content = content.replaceAll('final b2 = _ri(-5, 10);', 'final b2 = _ri(-15, 15);');
  content = content.replaceAll('final x = _ri(1, 10);', 'final x = _ri(-10, 15);');

  // Evaluacion Funcion
  content = content.replaceAll('final a = _ri(1, 5);', 'final a = _ri(1, 12);'); // Wait, conflicts with polinomio? Replace carefully. No, it's fine if both get 1,12.
  content = content.replaceAll('final b = _ri(1, 10);', 'final b = _ri(-10, 15);');
  content = content.replaceAll('final c = _ri(1, 10);', 'final c = _ri(-10, 15);');
  content = content.replaceAll('final x = _ri(2, 6);', 'final x = _ri(-5, 10);');

  // Sucesion Aritmetica
  content = content.replaceAll('final a1 = _ri(2, 10);', 'final a1 = _ri(-10, 20);');
  content = content.replaceAll('final d = _ri(2, 6);', 'final d = _ri(2, 12);');
  content = content.replaceAll('final n = _ri(5, 8);', 'final n = _ri(5, 20);');

  // Geometria Analitica
  content = content.replaceAll('final x1 = _ri(1, 5);', 'final x1 = _ri(-10, 10);');
  content = content.replaceAll('final y1 = _ri(1, 5);', 'final y1 = _ri(-10, 10);');

  // Exponencial
  content = content.replaceAll('final base = _ri(2, 5);', 'final base = _ri(2, 9);');
  content = content.replaceAll('final exp = _ri(2, 4);', 'final exp = _ri(2, 5);');

  // Cuadratica (Vertice)
  content = content.replaceAll('final vx = _ri(-4, 4);', 'final vx = _ri(-12, 12);');
  content = content.replaceAll('final vy = _ri(-5, 5);', 'final vy = _ri(-15, 15);');

  // Inecuacion
  content = content.replaceAll('final a = _ri(2, 5);', 'final a = _ri(2, 12);');
  content = content.replaceAll('final b = _ri(2, 10);', 'final b = _ri(-10, 15);');
  content = content.replaceAll('final c = _ri(2, 5);', 'final c = _ri(-10, 15);');
  content = content.replaceAll('final x = _ri(1, 5);', 'final x = _ri(-10, 15);');

  // Matrices
  content = content.replaceAll('final m11 = _ri(1, 5);', 'final m11 = _ri(-8, 10);');
  content = content.replaceAll('final m12 = _ri(1, 5);', 'final m12 = _ri(-8, 10);');
  content = content.replaceAll('final m21 = _ri(1, 5);', 'final m21 = _ri(-8, 10);');
  content = content.replaceAll('final m22 = _ri(1, 5);', 'final m22 = _ri(-8, 10);');

  file.writeAsStringSync(content);
  print('Generador actualizado con rangos ampliados.');
}
