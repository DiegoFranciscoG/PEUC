import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Un proyectil es lanzado con una velocidad inicial $v_0$ y un ángulo $\\theta$ respecto a la horizontal. ¿Cuál es la expresión para la componente horizontal de la velocidad inicial?",
    "opciones": [
      "A) $v_0 \\sin(\\theta)$",
      "B) $v_0 \\cos(\\theta)$",
      "C) $v_0 \\tan(\\theta)$",
      "D) $v_0 / \\cos(\\theta)$"
    ],
    "respuesta_correcta": "B) $v_0 \\cos(\\theta)$",
    "explicacion_detallada": "En el movimiento parabólico, la velocidad inicial se descompone en dos ejes. La componente adyacente al ángulo de lanzamiento respecto a la horizontal está dada por el coseno, por lo tanto $v_{0x} = v_0 \\cos(\\theta)$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Si se desprecia la resistencia del aire, ¿qué tipo de movimiento experimenta un proyectil en el eje horizontal?",
    "opciones": [
      "A) Movimiento Rectilíneo Uniformemente Acelerado",
      "B) Movimiento Caótico",
      "C) Movimiento Rectilíneo Uniforme",
      "D) Movimiento Circular Uniforme"
    ],
    "respuesta_correcta": "C) Movimiento Rectilíneo Uniforme",
    "explicacion_detallada": "Al no existir fuerzas horizontales actuando sobre el proyectil (despreciando la fricción del aire), la aceleración en el eje x es cero. Esto significa que la velocidad horizontal permanece constante, siendo un Movimiento Rectilíneo Uniforme (MRU)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "¿Cuál es la aceleración de un proyectil en su punto de máxima altura (despreciando la resistencia del aire)?",
    "opciones": [
      "A) Cero",
      "B) Igual a la gravedad, dirigida hacia arriba",
      "C) Igual a la gravedad, dirigida hacia abajo",
      "D) Depende de la masa del proyectil"
    ],
    "respuesta_correcta": "C) Igual a la gravedad, dirigida hacia abajo",
    "explicacion_detallada": "Durante todo el vuelo, la única fuerza que actúa sobre el proyectil es su peso. Por lo tanto, la aceleración es siempre constante e igual a $g$ (aceleración de la gravedad, aproximadamente $9.8 \\text{ m/s}^2$) dirigida hacia abajo, incluso en la altura máxima."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "En un movimiento parabólico completo que inicia y termina a la misma altura, ¿con qué ángulo de lanzamiento se obtiene el máximo alcance horizontal?",
    "opciones": [
      "A) $30^{\\circ}$",
      "B) $45^{\\circ}$",
      "C) $60^{\\circ}$",
      "D) $90^{\\circ}$"
    ],
    "respuesta_correcta": "B) $45^{\\circ}$",
    "explicacion_detallada": "La fórmula del alcance máximo es $R = (v_0^2 \\sin(2\\theta)) / g$. El valor máximo de $\\sin(2\\theta)$ es 1, lo cual ocurre cuando $2\\theta = 90^{\\circ}$, es decir, cuando $\\theta = 45^{\\circ}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Dos proyectiles se lanzan con la misma rapidez inicial desde el mismo punto. Uno a $30^{\\circ}$ y otro a $60^{\\circ}$. ¿Cómo son sus alcances horizontales?",
    "opciones": [
      "A) El de $60^{\\circ}$ tiene mayor alcance",
      "B) El de $30^{\\circ}$ tiene mayor alcance",
      "C) Ambos tienen el mismo alcance",
      "D) Falta conocer la masa para determinarlo"
    ],
    "respuesta_correcta": "C) Ambos tienen el mismo alcance",
    "explicacion_detallada": "Para un mismo valor de rapidez inicial, los ángulos complementarios (aquellos que suman $90^{\\circ}$) producen el mismo alcance horizontal. En este caso, $30^{\\circ} + 60^{\\circ} = 90^{\\circ}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "¿Qué magnitud de la velocidad del proyectil es cero en el punto más alto de su trayectoria?",
    "opciones": [
      "A) La velocidad total",
      "B) La componente horizontal de la velocidad",
      "C) La componente vertical de la velocidad",
      "D) La aceleración"
    ],
    "respuesta_correcta": "C) La componente vertical de la velocidad",
    "explicacion_detallada": "En la altura máxima, el proyectil deja de subir y comienza a bajar. En ese instante, su velocidad vertical ($v_y$) es cero. Sin embargo, su velocidad horizontal ($v_x$) sigue siendo constante y distinta de cero."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Si un objeto se lanza horizontalmente desde cierta altura, ¿cuánto tiempo tarda en caer al suelo respecto a un objeto que se deja caer libremente desde la misma altura al mismo tiempo?",
    "opciones": [
      "A) Tarda más tiempo en caer",
      "B) Tarda menos tiempo en caer",
      "C) Tardan exactamente lo mismo",
      "D) Depende de la velocidad horizontal inicial"
    ],
    "respuesta_correcta": "C) Tardan exactamente lo mismo",
    "explicacion_detallada": "El movimiento vertical y el horizontal son independientes. Dado que ambos objetos no tienen velocidad inicial vertical y están sujetos a la misma aceleración gravitatoria desde la misma altura, el tiempo de caída es idéntico: $t = \\sqrt{2h/g}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "En el Movimiento Circular Uniforme (MCU), la rapidez tangencial es constante. ¿Existe aceleración en este movimiento?",
    "opciones": [
      "A) No, porque la rapidez es constante",
      "B) Sí, la aceleración tangencial que aumenta la velocidad",
      "C) Sí, la aceleración centrípeta debida al cambio de dirección",
      "D) No, porque el movimiento es en dos dimensiones"
    ],
    "respuesta_correcta": "C) Sí, la aceleración centrípeta debida al cambio de dirección",
    "explicacion_detallada": "Aunque la magnitud de la velocidad (rapidez) es constante en el MCU, la dirección del vector velocidad cambia continuamente. Este cambio de dirección implica la existencia de una aceleración dirigida hacia el centro de la trayectoria, llamada aceleración centrípeta."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "¿Cuál es la fórmula correcta para la aceleración centrípeta $a_c$ en función de la rapidez tangencial $v$ y el radio de curvatura $r$?",
    "opciones": [
      "A) $a_c = v^2 \\cdot r$",
      "B) $a_c = v / r^2$",
      "C) $a_c = v^2 / r$",
      "D) $a_c = \\sqrt{v / r}$"
    ],
    "respuesta_correcta": "C) $a_c = v^2 / r$",
    "explicacion_detallada": "La magnitud de la aceleración centrípeta se define por el cuadrado de la rapidez tangencial dividido por el radio de la trayectoria circular: $a_c = v^2 / r$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Un balón es pateado con un ángulo de elevación de $40^{\\circ}$ y un tiempo de vuelo de $4$ s. ¿Cuánto tiempo le tomó alcanzar su altura máxima?",
    "opciones": [
      "A) $4$ s",
      "B) $1$ s",
      "C) $2$ s",
      "D) $8$ s"
    ],
    "respuesta_correcta": "C) $2$ s",
    "explicacion_detallada": "En un movimiento parabólico simétrico (sale y llega al mismo nivel horizontal), el tiempo que tarda en alcanzar la altura máxima es exactamente la mitad del tiempo de vuelo total. Así, $t_{\\text{subida}} = 4 \\text{ s} / 2 = 2 \\text{ s}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "La trayectoria geométrica de un objeto lanzado con un ángulo oblicuo (despreciando la resistencia del aire) describe una:",
    "opciones": [
      "A) Hipérbola",
      "B) Elipse",
      "C) Línea recta",
      "D) Parábola"
    ],
    "respuesta_correcta": "D) Parábola",
    "explicacion_detallada": "La combinación de un movimiento uniforme horizontal y un movimiento uniformemente acelerado vertical da como resultado una ecuación dependiente de $x^2$ para la posición $y$ ($y = Ax - Bx^2$), que corresponde matemáticamente a una parábola cóncava hacia abajo."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "En un Movimiento Circular Uniforme (MCU), ¿cómo se relaciona la velocidad angular $\\omega$ con la frecuencia $f$?",
    "opciones": [
      "A) $\\omega = 2\\pi / f$",
      "B) $\\omega = 2\\pi f$",
      "C) $\\omega = f / 2\\pi$",
      "D) $\\omega = \\pi f^2$"
    ],
    "respuesta_correcta": "B) $\\omega = 2\\pi f$",
    "explicacion_detallada": "La frecuencia $f$ mide las revoluciones por segundo. Como cada revolución equivale a $2\\pi$ radianes, la velocidad angular (radianes por segundo) es $\\omega = 2\\pi f$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "¿Qué magnitud vectorial es siempre tangente a la trayectoria en cualquier punto del movimiento circular?",
    "opciones": [
      "A) La fuerza centrípeta",
      "B) La aceleración centrípeta",
      "C) El vector posición",
      "D) La velocidad lineal o tangencial"
    ],
    "respuesta_correcta": "D) La velocidad lineal o tangencial",
    "explicacion_detallada": "El vector velocidad instantánea indica la dirección del movimiento en un punto dado, por lo tanto, por definición geométrica del movimiento en curvas, es siempre tangente a la trayectoria en ese instante."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Si se duplica la velocidad de lanzamiento inicial $v_0$ de un proyectil (manteniendo el mismo ángulo), ¿qué ocurre con su alcance máximo horizontal?",
    "opciones": [
      "A) Se duplica",
      "B) Se reduce a la mitad",
      "C) Se cuadruplica",
      "D) Permanece igual"
    ],
    "respuesta_correcta": "C) Se cuadruplica",
    "explicacion_detallada": "El alcance horizontal es directamente proporcional al cuadrado de la velocidad inicial: $R = v_0^2 \\sin(2\\theta)/g$. Si $v_0$ se multiplica por $2$, entonces $(2v_0)^2 = 4v_0^2$. El alcance se cuadruplica."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Para el caso de un objeto en movimiento circular uniforme con un periodo $T$, el objeto completa una revolución entera. ¿Cuál es el desplazamiento angular en ese tiempo?",
    "opciones": [
      "A) $\\pi$ radianes",
      "B) $2\\pi$ radianes",
      "C) $0$ radianes",
      "D) $360$ radianes"
    ],
    "respuesta_correcta": "B) $2\\pi$ radianes",
    "explicacion_detallada": "Una revolución completa equivale a una circunferencia completa. En términos de medida angular en el Sistema Internacional (radianes), el desplazamiento angular es $2\\pi$ rad, que es igual a $360^{\\circ}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Un automóvil toma una curva plana a velocidad constante. ¿Qué fuerza proporciona la aceleración centrípeta necesaria para mantener el movimiento circular?",
    "opciones": [
      "A) La fuerza gravitacional",
      "B) La fuerza normal",
      "C) La fuerza de fricción estática entre las llantas y el pavimento",
      "D) La fuerza centrífuga"
    ],
    "respuesta_correcta": "C) La fuerza de fricción estática entre las llantas y el pavimento",
    "explicacion_detallada": "En una curva no peraltada, la única fuerza radial que puede apuntar hacia el centro de la curvatura es el rozamiento estático lateral que las llantas ejercen contra el asfalto. Si esta fuerza falta (como sobre hielo), el auto sigue en línea recta."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "¿Qué principio de la mecánica clásica permite analizar el movimiento parabólico dividiéndolo en sus ejes x e y?",
    "opciones": [
      "A) Principio de superposición (o independencia de movimientos simultáneos)",
      "B) Tercera ley de Newton",
      "C) Ley de conservación del momentum",
      "D) Principio de Pascal"
    ],
    "respuesta_correcta": "A) Principio de superposición (o independencia de movimientos simultáneos)",
    "explicacion_detallada": "Postulado por Galileo, el principio de independencia establece que si un cuerpo tiene un movimiento compuesto, cada uno de los movimientos componentes actúa de forma independiente al otro. Así estudiamos x con MRU y y con caída libre (MRUA)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Una partícula describe una trayectoria circular de $5$ m de radio. Si su velocidad angular es de $2$ rad/s, ¿cuál es su rapidez tangencial?",
    "opciones": [
      "A) $10$ m/s",
      "B) $2.5$ m/s",
      "C) $20$ m/s",
      "D) $7$ m/s"
    ],
    "respuesta_correcta": "A) $10$ m/s",
    "explicacion_detallada": "La relación fundamental entre rapidez tangencial y angular es $v = \\omega \\cdot r$. Sustituyendo los valores: $v = (2 \\text{ rad/s})(5 \\text{ m}) = 10 \\text{ m/s}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Se lanza horizontalmente una piedra desde un acantilado de $20$ m de altura. Si la gravedad se toma como $10 \\text{ m/s}^2$, ¿cuánto es el tiempo de caída?",
    "opciones": [
      "A) $1$ s",
      "B) $2$ s",
      "C) $4$ s",
      "D) $20$ s"
    ],
    "respuesta_correcta": "B) $2$ s",
    "explicacion_detallada": "Usando la ecuación de caída libre $y = \\frac{1}{2} g t^2$. Despejando el tiempo $t = \\sqrt{2y / g}$. Reemplazando $t = \\sqrt{2(20) / 10} = \\sqrt{4} = 2 \\text{ s}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.2",
    "enunciado": "Durante un movimiento parabólico ideal, la energía cinética en el punto más alto del lanzamiento:",
    "opciones": [
      "A) Es máxima",
      "B) Es nula, porque la velocidad se hace cero",
      "C) Es igual a la energía cinética inicial",
      "D) Es mínima pero distinta de cero, ya que existe velocidad horizontal"
    ],
    "respuesta_correcta": "D) Es mínima pero distinta de cero, ya que existe velocidad horizontal",
    "explicacion_detallada": "En la altura máxima, la componente vertical de la velocidad se anula, lo que hace que la velocidad total alcance su valor mínimo (solo hay $v_x$). Por ende, la energía cinética ($K = \\frac{1}{2} m v^2$) es mínima en ese punto, pero no es cero."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    // Normalizar la respuesta correcta
    String letra = p['respuesta_correcta'].toString().replaceAll(')', '').trim();
    if (letra.length > 2) letra = letra.substring(0, 1);
    for (var op in p['opciones']) {
      if (op.startsWith(letra + ')')) {
        p['respuesta_correcta'] = op;
        break;
      }
    }
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.7.2.');
}
