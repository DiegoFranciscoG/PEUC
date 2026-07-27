void main() {
  final enunciados = [
    "Ejercicio de Matemáticas - Código 1.1.1, variante 0. Evalúa el concepto correspondiente al límite.",
    "Ejercicio de Matemáticas - Código 1.1.1, variante 12. Calcula la integral de la función.",
    "Ejercicio de Matemáticas - Código 1.2.1, variante 5. Resuelve la ecuación polinómica.",
    "Ejercicio de Matemáticas - Código 1.3.1. Halla la derivada de la siguiente función.",
    "Resuelve el siguiente problema de optimización sin código explícito."
  ];

  final RegExp regex = RegExp(r'Ejercicio de Matemáticas - Código \d\.\d\.\d(?:, variante \d+)?\.\s*');

  for (var rawText in enunciados) {
    final limpio = rawText.replaceAll(regex, '');
    print('ANTES:   ' + rawText);
    print('DESPUÉS: ' + limpio);
    print('-');
  }
}
