import 'dart:math';
import '../models/pregunta.dart';

class GeneradorAlgoritmico {
  static final Random _rand = Random();

  // ── Helpers ──────────────────────────────────────────────────────────────

  static int _ri(int min, int max) => min + _rand.nextInt(max - min + 1);
  static String _ts(num n) => n == n.roundToDouble() ? n.toInt().toString() : n.toStringAsFixed(2);

  static String _ytUrl(String query) =>
      'https://www.youtube.com/results?search_query=${Uri.encodeComponent(query)}';

  // ── 1.1.1 Polinomios ────────────────────────────────────────────────────

  static Pregunta generarPolinomio() {
    final a = _ri(1, 5);
    final b = _ri(1, 5);
    final c = _ri(1, 5);
    final suma = a + b + c;
    final prod = a * b + a * c + b * c;
    final prodTotal = a * b * c;

    final distractores = [suma + 2, suma - 1, suma + 5];
    final opciones = [suma.toString(), ...distractores.map((e) => e.toString())]..shuffle(_rand);

    return Pregunta(
      id: 'gen_111_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.1',
      enunciado:
          'El polinomio P(x) = x³ - ${suma}x² + ${prod}x - $prodTotal tiene raíces reales. ¿Cuál es la suma de sus raíces?',
      opciones: opciones,
      respuestaCorrecta: suma.toString(),
      explicacionDetallada:
          'Por el Teorema de Vieta, la suma de las raíces de un polinomio mónico de grado 3 es igual al coeficiente de x² con signo opuesto. Suma = $a + $b + $c = $suma.',
      pasosResolucion: [
        '**Paso 1 – Identificación:** El polinomio es P(x) = x³ - ${suma}x² + ${prod}x - $prodTotal',
        '**Paso 2 – Teorema de Vieta:** Para P(x) = x³ + px² + qx + r, la suma de raíces = -p',
        '**Paso 3 – Resultado:** Suma de raíces = -(-$suma) = **$suma**',
      ],
      videoExplicativoUrl: _ytUrl('suma raices polinomio Vieta Ecuador bachillerato'),
    );
  }

  // ── 1.1.2 Factorización ─────────────────────────────────────────────────

  static Pregunta generarFactorizacion() {
    final a = _ri(2, 7);
    final b = _ri(2, 7);
    // (x+a)(x+b) = x² + (a+b)x + ab
    final suma = a + b;
    final prod = a * b;

    final factores = '(x + $a)(x + $b)';
    final dist1 = '(x + ${a + 1})(x + ${b - 1})';
    final dist2 = '(x - $a)(x - $b)';
    final dist3 = '(x + $suma)(x + 1)';
    final opciones = [factores, dist1, dist2, dist3]..shuffle(_rand);

    return Pregunta(
      id: 'gen_112_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.2',
      enunciado: 'Factoriza el trinomio: x² + ${suma}x + $prod',
      opciones: opciones,
      respuestaCorrecta: factores,
      explicacionDetallada:
          'Buscamos dos números cuya suma sea $suma y cuyo producto sea $prod. Los números son $a y $b. Por tanto: x² + ${suma}x + $prod = $factores.',
      pasosResolucion: [
        '**Paso 1:** Trinomio de la forma x² + bx + c donde b = $suma, c = $prod',
        '**Paso 2:** Encontrar r₁, r₂ tal que r₁ + r₂ = $suma y r₁·r₂ = $prod → r₁ = $a, r₂ = $b',
        '**Paso 3:** Factorización: **$factores**',
      ],
      videoExplicativoUrl: _ytUrl('factorizacion trinomio cuadrado perfecto bachillerato Ecuador'),
    );
  }

  // ── 1.1.5 Ecuaciones Cuadráticas (Fórmula General) ──────────────────────

  static Pregunta generarEcuacionCuadratica() {
    // Construir raíces enteras simples: (x - r1)(x - r2) = x² - (r1+r2)x + r1*r2
    final r1 = _ri(1, 8);
    final r2 = _ri(1, 8);
    final b = -(r1 + r2);
    final c = r1 * r2;
    final bAbs = b.abs();
    final signoB = b < 0 ? '-' : '+';

    return Pregunta(
      id: 'gen_115_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.5',
      enunciado: 'Resuelve la ecuación cuadrática: x² $signoB ${bAbs}x + $c = 0',
      opciones: [
        'x₁ = $r1, x₂ = $r2',
        'x₁ = -$r1, x₂ = -$r2',
        'x₁ = $r1, x₂ = -$r2',
        'x₁ = ${r1 + 1}, x₂ = ${r2 - 1}',
      ]..shuffle(_rand),
      respuestaCorrecta: 'x₁ = $r1, x₂ = $r2',
      explicacionDetallada:
          'Aplicando la fórmula general con a=1, b=${b < 0 ? b : bAbs}, c=$c: discriminante Δ = b² - 4c = ${(r1 - r2) * (r1 - r2)}. Las soluciones son x₁=$r1 y x₂=$r2.',
      pasosResolucion: [
        '**Paso 1 – Identificar coeficientes:** a = 1, b = $b, c = $c',
        '**Paso 2 – Discriminante:** Δ = b² - 4ac = ${b * b} - ${4 * c} = ${b * b - 4 * c}',
        '**Paso 3 – Fórmula general:** x = (-b ± √Δ) / 2a',
        '**Paso 4 – Resultado:** x₁ = **$r1**, x₂ = **$r2**',
      ],
      videoExplicativoUrl: _ytUrl('formula general ecuacion cuadratica bachillerato'),
    );
  }

  // ── 1.2.1 Funciones Lineales ─────────────────────────────────────────────

  static Pregunta generarFuncionLineal() {
    final m = _ri(1, 8);
    final b2 = _ri(-5, 10);
    final x = _ri(1, 10);
    final y = m * x + b2;
    final signo = b2 >= 0 ? '+' : '-';
    final bAbs = b2.abs();

    return Pregunta(
      id: 'gen_121_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.2.1',
      enunciado: 'Dada la función f(x) = ${m}x $signo $bAbs, ¿cuál es el valor de f($x)?',
      opciones: [y.toString(), (y + 5).toString(), (y - 3).toString(), (y * 2).toString()]..shuffle(_rand),
      respuestaCorrecta: y.toString(),
      explicacionDetallada: 'Sustituyendo x = $x en f(x) = ${m}x $signo $bAbs: f($x) = $m·$x $signo $bAbs = ${m * x} $signo $bAbs = $y.',
      pasosResolucion: [
        '**Paso 1 – Función:** f(x) = ${m}x $signo $bAbs',
        '**Paso 2 – Sustitución:** f($x) = $m × $x $signo $bAbs = ${m * x} $signo $bAbs',
        '**Paso 3 – Resultado:** f($x) = **$y**',
      ],
      videoExplicativoUrl: _ytUrl('funciones lineales evaluacion bachillerato Ecuador'),
    );
  }

  // ── 1.3.1 Trigonometría ──────────────────────────────────────────────────

  static Pregunta generarTrigonometria() {
    // Common angle ratios
    final angulos = [
      {'grados': 30, 'seno': '1/2', 'coseno': '√3/2', 'tangente': '√3/3'},
      {'grados': 45, 'seno': '√2/2', 'coseno': '√2/2', 'tangente': '1'},
      {'grados': 60, 'seno': '√3/2', 'coseno': '1/2', 'tangente': '√3'},
    ];
    final ang = angulos[_rand.nextInt(3)];
    final funciones = ['seno', 'coseno', 'tangente'];
    final func = funciones[_rand.nextInt(3)];
    final correcta = ang[func] as String;

    return Pregunta(
      id: 'gen_131_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.3.1',
      enunciado: '¿Cuál es el valor del $func de ${ang['grados']}°?',
      opciones: [correcta, '1/2', '√3/2', '√2/2'].toSet().toList()..shuffle(_rand),
      respuestaCorrecta: correcta,
      explicacionDetallada:
          'En el triángulo rectángulo estándar de ${ang['grados']}°: seno = ${ang['seno']}, coseno = ${ang['coseno']}, tangente = ${ang['tangente']}. El $func(${ang['grados']}°) = $correcta.',
      pasosResolucion: [
        '**Paso 1 – Triángulo estándar:** Ángulo = ${ang['grados']}°',
        '**Paso 2 – Razones:** sen=${ang['seno']}, cos=${ang['coseno']}, tan=${ang['tangente']}',
        '**Paso 3 – Resultado:** $func(${ang['grados']}°) = **$correcta**',
      ],
      videoExplicativoUrl: _ytUrl('trigonometria razones trigonometricas ${ang['grados']} bachillerato'),
    );
  }

  // ── 3.7.3 Segunda Ley de Newton ─────────────────────────────────────────

  static Pregunta generarLeyesNewton() {
    final fuerza = _ri(2, 12) * 10;
    final masa = _ri(1, 5) * 5;
    final tiempo = _ri(2, 8);
    final a = fuerza / masa;
    final v = a * tiempo;

    return Pregunta(
      id: 'gen_373_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Ciencias Naturales',
      codigoTema: '3.7.3',
      enunciado:
          'Una fuerza de $fuerza N actúa sobre un objeto de $masa kg en reposo. Calcula la velocidad alcanzada tras $tiempo segundos (sin fricción).',
      opciones: [
        '${_ts(v)} m/s',
        '${_ts(v * 2)} m/s',
        '${_ts(v / 2)} m/s',
        '${_ts(v + 10)} m/s',
      ]..shuffle(_rand),
      respuestaCorrecta: '${_ts(v)} m/s',
      explicacionDetallada:
          '2ª Ley de Newton: a = F/m = $fuerza/$masa = ${_ts(a)} m/s². Cinemática: v = at = ${_ts(a)}×$tiempo = ${_ts(v)} m/s.',
      pasosResolucion: [
        '**Paso 1 – 2ª Ley Newton:** F = m·a → a = F/m = $fuerza / $masa = **${_ts(a)} m/s²**',
        '**Paso 2 – Cinemática (v₀=0):** v = v₀ + at = 0 + ${_ts(a)}×$tiempo',
        '**Paso 3 – Resultado:** v = **${_ts(v)} m/s**',
      ],
      videoExplicativoUrl: _ytUrl('segunda ley Newton aceleración fuerza masa bachillerato Ecuador'),
    );
  }

  // ── 3.7.1 Cinemática MRU ────────────────────────────────────────────────

  static Pregunta generarCinematicaMRU() {
    final v = _ri(2, 15) * 5;
    final t = _ri(2, 10);
    final d = v * t;

    return Pregunta(
      id: 'gen_371_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Ciencias Naturales',
      codigoTema: '3.7.1',
      enunciado:
          'Un automóvil viaja a velocidad constante de $v km/h durante $t horas. ¿Cuántos kilómetros recorre?',
      opciones: [
        '$d km',
        '${d + 50} km',
        '${d - v} km',
        '${d * 2} km',
      ]..shuffle(_rand),
      respuestaCorrecta: '$d km',
      explicacionDetallada:
          'MRU: d = v × t = $v × $t = $d km. El movimiento es rectilíneo uniforme porque la velocidad es constante.',
      pasosResolucion: [
        '**Paso 1 – Fórmula MRU:** d = v × t',
        '**Paso 2 – Sustitución:** d = $v km/h × $t h',
        '**Paso 3 – Resultado:** d = **$d km**',
      ],
      videoExplicativoUrl: _ytUrl('movimiento rectilineo uniforme MRU bachillerato'),
    );
  }

  // ── 3.7.4 Trabajo y Energía ──────────────────────────────────────────────

  static Pregunta generarTrabajoEnergia() {
    final m = _ri(1, 20);
    final h = _ri(1, 15);
    final g = 10;
    final ep = m * g * h;

    return Pregunta(
      id: 'gen_374_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Ciencias Naturales',
      codigoTema: '3.7.4',
      enunciado:
          'Calcula la energía potencial gravitatoria de un objeto de ${m} kg ubicado a ${h} m de altura. (g = 10 m/s²)',
      opciones: [
        '$ep J',
        '${ep + 100} J',
        '${(ep / 2).round()} J',
        '${ep * 2} J',
      ]..shuffle(_rand),
      respuestaCorrecta: '$ep J',
      explicacionDetallada:
          'Ep = m·g·h = $m × 10 × $h = $ep J. La energía potencial depende de la masa, la gravedad y la altura.',
      pasosResolucion: [
        '**Paso 1 – Fórmula:** Ep = m × g × h',
        '**Paso 2 – Datos:** m = ${m} kg, g = 10 m/s², h = ${h} m',
        '**Paso 3 – Cálculo:** Ep = $m × 10 × $h = **$ep J**',
      ],
      videoExplicativoUrl: _ytUrl('energia potencial gravitatoria bachillerato Ecuador física'),
    );
  }

  // ── 1.2.x Evaluación de Funciones ──────────────────────────────────────────
  
  static Pregunta generarEvaluacionFuncion() {
    final a = _ri(1, 5);
    final b = _ri(1, 10);
    final c = _ri(1, 10);
    final x = _ri(2, 6);
    final resultado = a * (x * x) - b * x + c;
    
    return Pregunta(
      id: 'gen_121_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.2.1',
      enunciado: 'Dada la función f(x) = ${a}x² - ${b}x + $c, encuentra el valor de f($x).',
      opciones: [
        '$resultado',
        '${resultado + 5}',
        '${resultado - x}',
        '${resultado + b}',
      ]..shuffle(_rand),
      respuestaCorrecta: '$resultado',
      explicacionDetallada: 'Sustituimos x = $x en la función: f($x) = $a($x)² - $b($x) + $c = $a(${x*x}) - ${b*x} + $c = ${a*x*x} - ${b*x} + $c = $resultado.',
      pasosResolucion: [
        '**Paso 1:** Reemplazar x = $x en f(x)',
        '**Paso 2:** Calcular f($x) = $a($x)² - $b($x) + $c',
        '**Paso 3:** Operar: ${a*x*x} - ${b*x} + $c = **$resultado**'
      ],
      videoExplicativoUrl: _ytUrl('evaluación de funciones matemáticas'),
    );
  }

  // ── 1.4.1 Estadística (Media, Mediana, Moda, Rango) ──────────────────────

  static Pregunta generarEstadisticaBase() {
    // Generar 5 datos
    final base = _ri(10, 20);
    final a = base;
    final b = base + _ri(1, 3);
    final c = base + _ri(1, 3);
    final d = b; // Forzar que 'b' sea la moda
    final e = base + _ri(4, 6);
    
    List<int> datos = [a, b, c, d, e]..shuffle(_rand);
    List<int> ordenados = [...datos]..sort();
    
    final media = (a + b + c + d + e) / 5;
    final mediana = ordenados[2];
    final moda = b;
    final rango = ordenados.last - ordenados.first;
    
    // Aleatoriamente preguntar por una de las 4 medidas
    final tipo = _ri(0, 3);
    String medidaStr = '';
    String resCorrecto = '';
    String expl = '';
    
    switch (tipo) {
      case 0:
        medidaStr = 'la media aritmética (promedio)';
        resCorrecto = _ts(media);
        expl = 'Suma de datos = ${a+b+c+d+e}. Promedio = ${a+b+c+d+e} / 5 = $resCorrecto.';
        break;
      case 1:
        medidaStr = 'la mediana';
        resCorrecto = mediana.toString();
        expl = 'Datos ordenados: ${ordenados.join(", ")}. El valor central es $mediana.';
        break;
      case 2:
        medidaStr = 'la moda';
        resCorrecto = moda.toString();
        expl = 'El dato que más se repite es $moda.';
        break;
      case 3:
        medidaStr = 'el rango';
        resCorrecto = rango.toString();
        expl = 'Rango = Dato mayor - Dato menor = ${ordenados.last} - ${ordenados.first} = $rango.';
        break;
    }

    return Pregunta(
      id: 'gen_141_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.4.1',
      enunciado: 'Dados los siguientes datos: ${datos.join(", ")}. Calcula $medidaStr.',
      opciones: [
        resCorrecto,
        _ts(media + 1),
        (mediana + 1).toString(),
        (rango + 2).toString(),
      ]..shuffle(_rand),
      respuestaCorrecta: resCorrecto,
      explicacionDetallada: expl,
      pasosResolucion: [
        '**Paso 1:** Identificar los datos: ${datos.join(", ")}',
        '**Paso 2:** Aplicar la definición de $medidaStr.',
        '**Paso 3:** Resultado = **$resCorrecto**'
      ],
      videoExplicativoUrl: _ytUrl('media mediana moda rango estadística'),
    );
  }

  // ── Sucesiones ─────────────────────────────────────────────────────────
  
  static Pregunta generarSucesionAritmetica() {
    final a1 = _ri(2, 10);
    final d = _ri(2, 6);
    final n = _ri(5, 8); // Preguntar por el término n
    
    final an = a1 + (n - 1) * d;
    
    List<int> terminos = [];
    for (int i=0; i<4; i++) {
      terminos.add(a1 + i * d);
    }
    
    return Pregunta(
      id: 'gen_suc_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.1',
      enunciado: 'Dada la sucesión aritmética: ${terminos.join(", ")}, ... ¿Cuál es el término en la posición $n?',
      opciones: [
        an.toString(),
        (an + d).toString(),
        (an - d).toString(),
        (an + 2).toString(),
      ]..shuffle(_rand),
      respuestaCorrecta: an.toString(),
      explicacionDetallada: 'El primer término es a₁ = $a1 y la diferencia es d = $d. La fórmula es an = a₁ + (n-1)d = $a1 + ($n-1)$d = $a1 + ${(n-1)*d} = $an.',
      pasosResolucion: [
        '**Paso 1:** Identificar a₁ = $a1 y d = $d',
        '**Paso 2:** Usar an = a₁ + (n-1)d para n=$n',
        '**Paso 3:** an = $a1 + (${n-1})×$d = **$an**'
      ],
      videoExplicativoUrl: _ytUrl('sucesiones aritmeticas termino general'),
    );
  }

  // ── 1.3.1 Geometría Analítica (Distancia entre 2 puntos) ───────────────
  
  static Pregunta generarGeometriaAnalitica() {
    // Para que la distancia sea entera, usamos ternas pitagóricas (ej 3,4,5 o 6,8,10 o 5,12,13)
    final ternas = [
      [3, 4, 5],
      [6, 8, 10],
      [5, 12, 13]
    ];
    final t = ternas[_rand.nextInt(ternas.length)];
    final dx = t[0];
    final dy = t[1];
    final dist = t[2];
    
    final x1 = _ri(1, 5);
    final y1 = _ri(1, 5);
    final x2 = x1 + dx;
    final y2 = y1 + dy;

    return Pregunta(
      id: 'gen_131_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.3.1',
      enunciado: 'En el plano cartesiano, calcula la distancia entre los puntos A($x1, $y1) y B($x2, $y2).',
      opciones: [
        dist.toString(),
        (dist + 1).toString(),
        (dist - 1).toString(),
        (dist * 2).toString(),
      ]..shuffle(_rand),
      respuestaCorrecta: dist.toString(),
      explicacionDetallada: 'Distancia = √[(x₂ - x₁)² + (y₂ - y₁)²] = √[($x2 - $x1)² + ($y2 - $y1)²] = √[$dx² + $dy²] = √[${dx*dx} + ${dy*dy}] = √${dx*dx + dy*dy} = $dist.',
      pasosResolucion: [
        '**Paso 1:** d = √[(x₂-x₁)² + (y₂-y₁)²]',
        '**Paso 2:** d = √[($x2-$x1)² + ($y2-$y1)²] = √[$dx² + $dy²]',
        '**Paso 3:** d = √${dx*dx + dy*dy} = **$dist**'
      ],
      videoExplicativoUrl: _ytUrl('distancia entre dos puntos geometria analitica'),
    );
  }

  // ── 1.1.3 Función exponencial y logarítmica ──────────────────────────────
  static Pregunta generarExponencialLogaritmica() {
    final base = _ri(2, 5);
    final exp = _ri(2, 4);
    final val = pow(base, exp).toInt();
    
    return Pregunta(
      id: 'gen_113_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.3',
      enunciado: 'Resuelve la ecuación logarítmica: log_($base)($val) = x',
      opciones: [
        exp.toString(),
        (exp + 1).toString(),
        (exp - 1).toString(),
        (exp * 2).toString(),
      ]..shuffle(_rand),
      respuestaCorrecta: exp.toString(),
      explicacionDetallada: 'Por definición de logaritmo, log_a(b) = c implica que a^c = b. En este caso, $base^x = $val. Sabemos que $base^$exp = $val, por lo tanto x = $exp.',
      pasosResolucion: [
        '**Paso 1:** Convertir a forma exponencial: $base^x = $val',
        '**Paso 2:** Expresar $val como potencia de $base: $base^x = $base^$exp',
        '**Paso 3:** Igualar exponentes: x = **$exp**'
      ],
      videoExplicativoUrl: _ytUrl('ecuaciones logaritmicas bachillerato'),
    );
  }

  // ── 1.1.4 Función cuadrática (Vértice) ──────────────────────────────────
  static Pregunta generarFuncionCuadratica() {
    final vx = _ri(-4, 4);
    final vy = _ri(-5, 5);
    final a = _rand.nextBool() ? 1 : -1;
    // Forma canónica: a(x-vx)^2 + vy = a(x^2 - 2vx + vx^2) + vy
    final b = -2 * a * vx;
    final c = a * vx * vx + vy;
    
    final signoB = b < 0 ? '-' : '+';
    final bAbs = b.abs();
    final signoC = c < 0 ? '-' : '+';
    final cAbs = c.abs();
    final aStr = a == 1 ? '' : '-';
    
    final verticeCorrecto = '($vx, $vy)';
    
    return Pregunta(
      id: 'gen_114_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.4',
      enunciado: 'Encuentra las coordenadas del vértice de la parábola dada por f(x) = ${aStr}x² $signoB ${bAbs}x $signoC $cAbs.',
      opciones: [
        verticeCorrecto,
        '(${-vx}, $vy)',
        '($vx, ${-vy})',
        '(${-vx}, ${-vy})',
      ]..shuffle(_rand),
      respuestaCorrecta: verticeCorrecto,
      explicacionDetallada: 'La coordenada x del vértice es x_v = -b/(2a). Aquí a=$a, b=$b. x_v = -($b)/(2*$a) = $vx. Evaluando en la función, y_v = f($vx) = $vy. El vértice es $verticeCorrecto.',
      pasosResolucion: [
        '**Paso 1:** Identificar a=$a, b=$b',
        '**Paso 2:** Calcular x_v = -b/(2a) = -($b)/(${2*a}) = $vx',
        '**Paso 3:** Calcular y_v = f($vx) = $vy',
        '**Paso 4:** Resultado: **$verticeCorrecto**'
      ],
      videoExplicativoUrl: _ytUrl('vertice parabola funcion cuadratica'),
    );
  }

  // ── 1.1.6 Intervalos e inecuaciones ──────────────────────────────────────
  static Pregunta generarInecuacion() {
    final a = _ri(2, 5);
    final b = _ri(2, 10);
    final c = _ri(2, 5);
    final x = _ri(1, 5);
    // Para que salga entero: a*x - b > c --> a*x > c + b --> ax = c+b --> a = a, c+b = a*x
    final valDer = a * x - b;
    final simbolo = _rand.nextBool() ? '>' : '<';
    final xSol = (valDer + b) / a;
    
    final correcta = simbolo == '>' ? 'x > $x' : 'x < $x';
    
    return Pregunta(
      id: 'gen_116_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.6',
      enunciado: 'Resuelve la inecuación lineal: ${a}x - $b $simbolo $valDer',
      opciones: [
        correcta,
        simbolo == '>' ? 'x < $x' : 'x > $x',
        simbolo == '>' ? 'x > ${x+1}' : 'x < ${x+1}',
        'x = $x',
      ]..shuffle(_rand),
      respuestaCorrecta: correcta,
      explicacionDetallada: 'Sumamos $b a ambos lados: ${a}x $simbolo ${valDer + b}. Luego dividimos entre $a: x $simbolo $x.',
      pasosResolucion: [
        '**Paso 1:** ${a}x - $b $simbolo $valDer',
        '**Paso 2:** ${a}x $simbolo $valDer + $b',
        '**Paso 3:** ${a}x $simbolo ${valDer + b}',
        '**Paso 4:** x $simbolo ${valDer + b} / $a = **$x**'
      ],
      videoExplicativoUrl: _ytUrl('inecuaciones lineales primer grado'),
    );
  }

  // ── 1.1.7 Matrices reales ────────────────────────────────────────────────
  static Pregunta generarMatriz() {
    final m11 = _ri(1, 5);
    final m12 = _ri(1, 5);
    final m21 = _ri(1, 5);
    final m22 = _ri(1, 5);
    final det = m11 * m22 - m12 * m21;
    
    return Pregunta(
      id: 'gen_117_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(1000000)}}',
      materia: 'Matemáticas',
      codigoTema: '1.1.7',
      enunciado: 'Calcula el determinante de la matriz A = [[$m11, $m12], [$m21, $m22]]',
      opciones: [
        det.toString(),
        (det + 2).toString(),
        (det - 3).toString(),
        (m11 * m21 - m12 * m22).toString(), // error común
      ]..shuffle(_rand),
      respuestaCorrecta: det.toString(),
      explicacionDetallada: 'El determinante de una matriz 2x2 [[a, b], [c, d]] es (a*d - b*c). En este caso: ($m11 * $m22) - ($m12 * $m21) = ${m11*m22} - ${m12*m21} = $det.',
      pasosResolucion: [
        '**Paso 1:** Fórmula: det(A) = ad - bc',
        '**Paso 2:** Sustituir: det(A) = ($m11)($m22) - ($m12)($m21)',
        '**Paso 3:** Resultado: ${m11*m22} - ${m12*m21} = **$det**'
      ],
      videoExplicativoUrl: _ytUrl('determinante matriz 2x2 algebra lineal'),
    );
  }

  // ── Dispatcher de Subtemas ───────────────────────────────────────────────

  static Pregunta obtenerPreguntaParaSubtema(String codigo) {
    switch (codigo) {
      case '1.1.1': return _rand.nextBool() ? generarPolinomio() : generarSucesionAritmetica();
      case '1.1.2': return generarFactorizacion();
      case '1.1.3': return generarExponencialLogaritmica();
      case '1.1.4': return generarFuncionCuadratica();
      case '1.1.5': return generarEcuacionCuadratica();
      case '1.1.6': return generarInecuacion();
      case '1.1.7': return generarMatriz();
      case '1.2.1': return _rand.nextBool() ? generarFuncionLineal() : generarEvaluacionFuncion();
      case '1.3.1': return _rand.nextBool() ? generarTrigonometria() : generarGeometriaAnalitica();
      case '1.4.1': return generarEstadisticaBase();
      case '3.7.1': return generarCinematicaMRU();
      case '3.7.3': return generarLeyesNewton();
      case '3.7.4': return generarTrabajoEnergia();
      default:     return generarEcuacionCuadratica();
    }
  }

  static Pregunta obtenerPreguntaAleatoria() {
    final generadores = [
      generarPolinomio,
      generarFactorizacion,
      generarExponencialLogaritmica,
      generarFuncionCuadratica,
      generarEcuacionCuadratica,
      generarInecuacion,
      generarMatriz,
      generarFuncionLineal,
      generarEvaluacionFuncion,
      generarTrigonometria,
      generarGeometriaAnalitica,
      generarEstadisticaBase,
      generarSucesionAritmetica,
      generarCinematicaMRU,
      generarLeyesNewton,
      generarTrabajoEnergia,
    ];
    return generadores[_rand.nextInt(generadores.length)]();
  }
}
