import 'dart:math';
import '../models/pregunta.dart';

class GeneradorAbstracto {
  static final Random _rand = Random();

  static const List<String> iconos = ['star', 'circle', 'square', 'triangle', 'pentagon', 'hexagon'];
  static const List<String> rellenos = ['lleno', 'contorno', 'rayado', 'punteado'];
  static const List<int> rotaciones = [0, 45, 90, 135, 180, 225, 270, 315];
  static const List<double> tamanos = [30.0, 40.0, 50.0];

  static int _ri(int min, int max) => min + _rand.nextInt(max - min + 1);
  static T _randomElement<T>(List<T> list) => list[_rand.nextInt(list.length)];

  static Pregunta obtenerPreguntaParaSubtema(String codigoTema) {
    switch (codigoTema) {
      case '5.1.1': return generarSemejanzas();
      case '5.1.2': return generarAnalogias();
      case '5.2.1': return generarDeformacion();
      case '5.2.2': return generarCambioPosicional();
      case '5.2.3': return generarComplicacion();
      case '5.3.1': return generarRotativa();
      case '5.3.2': return generarTransformacion2D3D(); // Simplificado a patrón 2D
      case '5.3.3': return generarPerspectiva(); // Simplificado a matriz 3x3 visual
      default: return generarSemejanzas();
    }
  }

  // Generadores base que retornan Pregunta
  // 5.1.1 Semejanzas y diferencias (Matriz 3x3 donde falta una figura con lógica de relleno/forma)
  static Pregunta generarSemejanzas() {
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
    
    return _construirPregunta('5.1.1', 'matriz3x3', 'Identifica la figura que completa la secuencia matricial:', elementos, opcionesMap, respuestaCorrectaIdx);
  }

  // 5.1.2 Analogías gráficas (A es a B como C es a D)
  static Pregunta generarAnalogias() {
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
    return _construirPregunta('5.1.2', 'analogia', 'Determina la figura que completa la analogía gráfica:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.1 Deformación de objetos (cambio de tamaño y contorno)
  static Pregunta generarDeformacion() {
    final base = _randomElement(iconos);
    
    List<Map<String, dynamic>> elementos = [
      {'icono': base, 'rotacion': 0, 'relleno': 'contorno', 'tamano': 30.0},
      {'icono': base, 'rotacion': 0, 'relleno': 'rayado', 'tamano': 40.0},
      {'icono': base, 'rotacion': 0, 'relleno': 'lleno', 'tamano': 50.0},
    ];

    final correctMap = {'icono': base, 'rotacion': 0, 'relleno': 'contorno', 'tamano': 60.0};
    
    final distractores = [
      {'icono': base, 'rotacion': 90, 'relleno': 'lleno', 'tamano': 60.0},
      {'icono': base, 'rotacion': 0, 'relleno': 'rayado', 'tamano': 60.0},
      {'icono': _randomElement(iconos.where((e)=>e!=base).toList()), 'rotacion': 0, 'relleno': 'contorno', 'tamano': 60.0},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta('5.2.1', 'secuencia', 'Encuentra la figura que sigue la secuencia de deformación y escalado:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.2 Cambio posicional de figuras (Rotación secuencial)
  static Pregunta generarCambioPosicional() {
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
    return _construirPregunta('5.2.2', 'secuencia', '¿Qué figura sigue en la secuencia de rotación?', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.2.3 Complicación y simplificación
  static Pregunta generarComplicacion() {
    // Simulamos complicacion alternando rellenos (blanco -> rayado -> lleno)
    final icon = _randomElement(iconos);
    final pRelleno = ['contorno', 'rayado', 'lleno', 'punteado'];
    final startIdx = _ri(0, 1);
    
    List<Map<String, dynamic>> elementos = [
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[startIdx], 'tamano': 40.0},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[startIdx+1], 'tamano': 40.0},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[startIdx+2], 'tamano': 40.0},
    ];

    final correctMap = {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[startIdx+3 > 3 ? 0 : startIdx+3], 'tamano': 40.0};
    
    final distractores = [
      {'icono': icon, 'rotacion': 90, 'relleno': correctMap['relleno'], 'tamano': 40.0},
      {'icono': _randomElement(iconos.where((e)=>e!=icon).toList()), 'rotacion': 0, 'relleno': correctMap['relleno'], 'tamano': 40.0},
      {'icono': icon, 'rotacion': 0, 'relleno': pRelleno[startIdx], 'tamano': 40.0},
    ];
    
    final opcionesMap = [correctMap, ...distractores]..shuffle(_rand);
    return _construirPregunta('5.2.3', 'secuencia', 'Determina el patrón de adición de elementos (relleno) y selecciona la siguiente figura:', elementos, opcionesMap, opcionesMap.indexOf(correctMap).toString());
  }

  // 5.3.1 Figura rotativa
  static Pregunta generarRotativa() {
    return generarCambioPosicional(); // Usa el mismo principio base
  }

  // 5.3.2 y 5.3.3 usando variantes de matrices
  static Pregunta generarTransformacion2D3D() {
    return generarSemejanzas(); 
  }
  
  static Pregunta generarPerspectiva() {
    return generarAnalogias();
  }

  static Pregunta _construirPregunta(String tema, String tipo, String enunciado, List<Map<String, dynamic>> elementos, List<Map<String, dynamic>> opcionesMap, String correctIdx) {
    return Pregunta(
      id: 'gen_abs_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(9999999)}',
      materia: 'Razonamiento Abstracto',
      codigoTema: tema,
      enunciado: enunciado,
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
