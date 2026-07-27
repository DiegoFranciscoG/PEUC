import 'dart:math';
import '../models/pregunta.dart';

class GeneradorAbstracto {
  static final Random _rand = Random();

  static const List<String> iconos = ['star', 'circle', 'square', 'triangle', 'pentagon', 'hexagon', 'rhombus', 'cross', 'trapezoid', 'ellipse'];
  static const List<String> rellenos = ['lleno', 'contorno', 'rayado', 'punteado'];
  static const List<int> rotaciones = [0, 45, 90, 135, 180, 225, 270, 315];
  static const List<double> tamanos = [30.0, 40.0, 50.0, 60.0];

  static int _ri(int min, int max) => min + _rand.nextInt(max - min + 1);
  static T _randomElement<T>(List<T> list) => list[_rand.nextInt(list.length)];

  static Pregunta? obtenerPreguntaParaSubtema(String codigoTema) {
    switch (codigoTema) {
      case '5.1.1': return generarSemejanzas('5.1.1');
      case '5.1.2': return generarAnalogias('5.1.2');
      case '5.2.1': return generarDeformacion('5.2.1');
      case '5.2.2': return generarCambioPosicional('5.2.2');
      case '5.2.3': return generarComplicacion('5.2.3');
      case '5.3.1': return generarRotativa('5.3.1');
      case '5.3.2': return null; // Desactivado: requiere modelo 3D real
      case '5.3.3': return null; // Desactivado: requiere modelo de perspectiva real
      default: return generarSemejanzas(codigoTema);
    }
  }

  // Generadores base que retornan Pregunta
  // 5.1.1 Semejanzas y diferencias (Matriz 3x3 donde falta una figura con lógica de relleno/forma)
  static Pregunta generarSemejanzas([String tema = '5.1.1']) {
    final shape1 = _randomElement(iconos);
    final shape2 = _randomElement(iconos.where((e) => e != shape1).toList());
    
    // Lógica: La forma cambia en cada columna, el relleno en cada fila.
    final fill1 = _randomElement(rellenos);
    final fill2 = _randomElement(rellenos.where((e) => e != fill1).toList());
    
    List<Map<String, dynamic>> elementos = [];
    for (int i = 0; i < 8; i++) {
      elementos.add({
        'icono': (i % 2 == 0) ? shape1 : shape2,
        'rotacion': 0,
        'relleno': (i < 4) ? fill1 : fill2,
        'tamano': 40.0
      });
    }

    // La correcta (posición 9, i=8)
    final correctIcon = shape1;
    final correctFill = fill2;
    
    final correctMap = {'icono': correctIcon, 'rotacion': 0, 'relleno': correctFill, 'tamano': 40.0};
    
    final distractores = [
      {'icono': shape2, 'rotacion': 0, 'relleno': fill1, 'tamano': 40.0},
      {'icono': shape1, 'rotacion': 90, 'relleno': fill1, 'tamano': 40.0},
      {'icono': shape2, 'rotacion': 0, 'relleno': correctFill, 'tamano': 40.0},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    final respuestaCorrectaIdx = opcionesMap.indexOf(correctMap).toString();
    
    return _construirPregunta(tema, 'matriz3x3', 'Identifica la figura que completa la secuencia matricial:', elementos, opcionesMap, respuestaCorrectaIdx);
  }

  // 5.1.2 Analogías gráficas (A es a B como C es a D)
  static Pregunta generarAnalogias([String tema = '5.1.2']) {
    final baseIcon = _randomElement(iconos);
    final transIcon = _randomElement(iconos.where((e) => e != baseIcon).toList());
    final rot = _randomElement([90, 180, 270]);
    
    List<Map<String, dynamic>> elementos = [
      {'icono': baseIcon, 'rotacion': 0, 'relleno': 'contorno', 'tamano': 40.0},
      {'icono': baseIcon, 'rotacion': rot, 'relleno': 'lleno', 'tamano': 40.0},
      {'icono': transIcon, 'rotacion': 0, 'relleno': 'contorno', 'tamano': 40.0},
    ];

    final correctMap = {'icono': transIcon, 'rotacion': rot, 'relleno': 'lleno', 'tamano': 40.0};
    
    final distractores = [
      {'icono': transIcon, 'rotacion': 0, 'relleno': 'lleno', 'tamano': 40.0},
      {'icono': baseIcon, 'rotacion': rot, 'relleno': 'rayado', 'tamano': 40.0},
      {'icono': transIcon, 'rotacion': rot, 'relleno': 'contorno', 'tamano': 40.0},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta(tema, 'analogia', 'Determina la figura que completa la analogía gráfica:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.1 Deformación de objetos (cambio de tamaño y contorno)
  static Pregunta generarDeformacion([String tema = '5.2.1']) {
    final base = _randomElement(iconos);
    final isCreciendo = _rand.nextBool();
    final rellenoBase = _randomElement(['contorno', 'lleno']); // para duplicar la entropía
    
    final t1 = isCreciendo ? 30.0 : 60.0;
    final t2 = isCreciendo ? 40.0 : 50.0;
    final t3 = isCreciendo ? 50.0 : 40.0;
    final t4 = isCreciendo ? 60.0 : 30.0;
    
    List<Map<String, dynamic>> elementos = [
      {'icono': base, 'rotacion': 0, 'relleno': rellenoBase, 'tamano': t1},
      {'icono': base, 'rotacion': 0, 'relleno': rellenoBase, 'tamano': t2},
      {'icono': base, 'rotacion': 0, 'relleno': rellenoBase, 'tamano': t3},
    ];

    final correctMap = {'icono': base, 'rotacion': 0, 'relleno': rellenoBase, 'tamano': t4};
    
    final distractores = [
      {'icono': base, 'rotacion': 90, 'relleno': rellenoBase, 'tamano': t4},
      {'icono': base, 'rotacion': 0, 'relleno': rellenoBase == 'contorno' ? 'lleno' : 'contorno', 'tamano': t4},
      {'icono': _randomElement(iconos.where((e)=>e!=base).toList()), 'rotacion': 0, 'relleno': rellenoBase, 'tamano': t4},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta(tema, 'secuencia', 'Encuentra la figura que sigue la secuencia de deformación y escalado:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.2 Cambio posicional de figuras (Rotación secuencial)
  static Pregunta generarCambioPosicional([String tema = '5.2.2']) {
    final icon = _randomElement(iconos);
    final startRot = _randomElement([0, 45, 90]);
    final step = _randomElement([45, 90, 135]);
    
    List<Map<String, dynamic>> elementos = [];
    for(int i=0; i<3; i++) {
      elementos.add({'icono': icon, 'rotacion': (startRot + i*step)%360, 'relleno': 'contorno', 'tamano': 40.0});
    }

    final correctRot = (startRot + 3*step)%360;
    final correctMap = {'icono': icon, 'rotacion': correctRot, 'relleno': 'contorno', 'tamano': 40.0};
    
    final distractores = [
      {'icono': icon, 'rotacion': (correctRot + step)%360, 'relleno': 'contorno', 'tamano': 40.0},
      {'icono': icon, 'rotacion': (correctRot - step)%360, 'relleno': 'contorno', 'tamano': 40.0},
      {'icono': icon, 'rotacion': correctRot, 'relleno': 'lleno', 'tamano': 40.0},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta(tema, 'secuencia', '¿Qué figura sigue en la secuencia de rotación?', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.3 Complicación y simplificación
  static Pregunta generarComplicacion([String tema = '5.2.3']) {
    // Simulamos complicacion alternando rellenos (blanco -> rayado -> lleno) o inverso
    final icon = _randomElement(iconos);
    final pRelleno = ['contorno', 'rayado', 'lleno', 'punteado'];
    final isComplicando = _rand.nextBool();
    final tamBase = _randomElement([30.0, 40.0]); // para duplicar entropía
    
    final r1 = isComplicando ? 0 : 3;
    final r2 = isComplicando ? 1 : 2;
    final r3 = isComplicando ? 2 : 1;
    final r4 = isComplicando ? 3 : 0;
    
    List<Map<String, dynamic>> elementos = [
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[r1], 'tamano': tamBase},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[r2], 'tamano': tamBase},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[r3], 'tamano': tamBase},
    ];

    final correctMap = {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[r4], 'tamano': tamBase};
    
    final distractores = [
      {'icono': icon, 'rotacion': 90, 'relleno': correctMap['relleno'], 'tamano': tamBase},
      {'icono': _randomElement(iconos.where((e)=>e!=icon).toList()), 'rotacion': 0, 'relleno': correctMap['relleno'], 'tamano': tamBase},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[r1], 'tamano': tamBase}, // el primero repetido
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta(tema, 'secuencia', 'Determina el patrón de adición/sustracción de elementos (relleno) y selecciona la siguiente figura:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.3.1 Figura rotativa
  static Pregunta generarRotativa([String tema = '5.3.1']) {
    return generarCambioPosicional(tema); // Usa el mismo principio base
  }

  static Pregunta _construirPregunta(String tema, String tipo, String enunciado, List<Map<String, dynamic>> elementos, List<Map<String, dynamic>> opcionesMap, String correctIdx) {
    
    Map<String, String> iconNames = {
      'star': 'estrella', 'circle': 'círculo', 'square': 'cuadrado', 
      'triangle': 'triángulo', 'pentagon': 'pentágono', 'hexagon': 'hexágono',
      'rhombus': 'rombo', 'cross': 'cruz', 'trapezoid': 'trapecio', 'ellipse': 'elipse'
    };
    
    // Determinar dinámicamente qué cambió en los elementos (si hay al menos 2)
    List<String> cambios = [];
    String descripcionCambio;
    if (elementos.length >= 2) {
      final e1 = elementos[0];
      final e2 = elementos[1];
      if (e1['icono'] != e2['icono']) cambios.add("forma (de ${iconNames[e1['icono']] ?? e1['icono']} a ${iconNames[e2['icono']] ?? e2['icono']})");
      if (e1['rotacion'] != e2['rotacion']) cambios.add("rotación (de ${e1['rotacion']}° a ${e2['rotacion']}°)");
      if (e1['relleno'] != e2['relleno']) cambios.add("relleno (de ${e1['relleno']} a ${e2['relleno']})");
      if (e1['tamano'] != e2['tamano']) cambios.add("escala (de ${e1['tamano']} a ${e2['tamano']})");
      
      String base = "base: ${iconNames[e1['icono']] ?? e1['icono']}, rot ${e1['rotacion']}°, ${e1['relleno']}, tam ${e1['tamano']}";
      descripcionCambio = cambios.isNotEmpty 
          ? " considerando un cambio en " + cambios.join(' y ') + " [$base]"
          : " analizando la progresión lógica [$base]";
    } else {
      descripcionCambio = " analizando la progresión lógica";
    }

    String enunciadoFinal;
    if (tipo == 'matriz') {
      enunciadoFinal = 'Identifica la figura que completa la matriz$descripcionCambio.';
    } else if (tipo == 'secuencia') {
      enunciadoFinal = 'Determina qué figura sigue en la secuencia geométrica$descripcionCambio.';
    } else {
      enunciadoFinal = 'Selecciona la opción que resuelve la analogía gráfica$descripcionCambio.';
    }

    return Pregunta(
      id: 'gen_abs_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(9999999)}',
      materia: 'Razonamiento Abstracto',
      codigoTema: tema,
      enunciado: enunciadoFinal,
      esOpcionesImagen: true,
      opciones: ['0', '1', '2', '3'],
      respuestaCorrecta: correctIdx,
      explicacionDetallada: 'La secuencia o matriz sigue un patrón lógico predecible de transformación en la figura geométrica.',
      pasosResolucion: [
        '**Paso 1:** Analizar el cambio progresivo entre las figuras dadas.',
        '**Paso 2:** Identificar la variable que cambia (rotación, forma, tamaño o relleno).',
        '**Paso 3:** Aplicar la regla a la última figura para encontrar la respuesta correcta.'
      ],
      videoExplicativoUrl: null,
      tipoEjercicioAbstracto: tipo,
      elementosAbstractos: elementos.map((e) => ElementoAbstracto.fromMap(e)).toList(),
      opcionesAbstractas: opcionesMap.map((e) => ElementoAbstracto.fromMap(e)).toList()
    );
  }
}
