import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> nuevasPreguntas = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un bloque de masa \$m\$ se desliza sin fricción hacia abajo por un plano inclinado que forma un ángulo \$\\theta\$ con la horizontal. La magnitud de su aceleración es:",
      "opciones": [
        "A) \$g \\sin\\theta\$",
        "B) \$g \\cos\\theta\$",
        "C) \$g \\tan\\theta\$",
        "D) \$g\$"
      ],
      "respuesta_correcta": "A) \$g \\sin\\theta\$",
      "explicacion_detallada": "En un plano inclinado sin fricción, la componente del peso paralela al plano es \$mg \\sin\\theta\$. Aplicando la segunda ley de Newton en esa dirección (\$F = ma\$), tenemos \$mg \\sin\\theta = ma\$. Al cancelar la masa \$m\$, se obtiene que la aceleración es \$a = g \\sin\\theta\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un bloque de 5 kg se encuentra sobre una superficie horizontal lisa (sin fricción). Se le aplica una fuerza de 20 N que forma un ángulo de 37° con la horizontal hacia arriba. ¿Cuál es la magnitud de la aceleración del bloque? (Considere \$\\cos 37^\\circ = 0.8\$ y \$\\sin 37^\\circ = 0.6\$)",
      "opciones": [
        "A) 4.0 m/s²",
        "B) 3.2 m/s²",
        "C) 2.4 m/s²",
        "D) 1.6 m/s²"
      ],
      "respuesta_correcta": "B) 3.2 m/s²",
      "explicacion_detallada": "La componente horizontal de la fuerza aplicada es la que produce la aceleración. \$F_x = F \\cos 37^\\circ = 20(0.8) = 16 \\text{ N}\$. Aplicando la segunda ley de Newton en el eje horizontal: \$F_x = ma \\Rightarrow 16 = 5a \\Rightarrow a = 3.2 \\text{ m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "En la situación del problema anterior (bloque de 5 kg sobre superficie horizontal tirado por una fuerza de 20 N a 37° hacia arriba), ¿cuál es la magnitud de la fuerza normal que ejerce la superficie sobre el bloque? (Considere \$g = 10 \\text{ m/s}^2\$)",
      "opciones": [
        "A) 50 N",
        "B) 38 N",
        "C) 62 N",
        "D) 20 N"
      ],
      "respuesta_correcta": "B) 38 N",
      "explicacion_detallada": "Aplicando la primera ley de Newton en el eje vertical (donde no hay aceleración): \$N + F_y - mg = 0\$. La componente vertical de la fuerza es \$F_y = F \\sin 37^\\circ = 20(0.6) = 12 \\text{ N}\$. El peso es \$mg = 5(10) = 50 \\text{ N}\$. Por lo tanto, \$N = mg - F_y = 50 - 12 = 38 \\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un objeto de masa \$m\$ está en reposo sobre un plano inclinado un ángulo \$\\theta\$. Si \$\\mu_s\$ es el coeficiente de fricción estática entre el objeto y el plano, la condición límite para que el objeto no resbale es:",
      "opciones": [
        "A) \$\\mu_s \\ge \\tan\\theta\$",
        "B) \$\\mu_s \\ge \\sin\\theta\$",
        "C) \$\\mu_s \\le \\tan\\theta\$",
        "D) \$\\mu_s = \\cos\\theta\$"
      ],
      "respuesta_correcta": "A) \$\\mu_s \\ge \\tan\\theta\$",
      "explicacion_detallada": "Para que no resbale, la fuerza de fricción estática máxima debe ser mayor o igual a la componente del peso paralela al plano: \$\\mu_s N \\ge mg \\sin\\theta\$. Como \$N = mg \\cos\\theta\$, sustituyendo se tiene \$\\mu_s mg \\cos\\theta \\ge mg \\sin\\theta\$, lo que simplifica a \$\\mu_s \\ge \\tan\\theta\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un cuerpo se desliza hacia abajo por un plano inclinado 30° respecto a la horizontal. Si el coeficiente de fricción cinética es \$0.2\$, ¿cuál es aproximadamente su aceleración? (Considere \$g = 10 \\text{ m/s}^2\$, \$\\sqrt{3} \\approx 1.73\$)",
      "opciones": [
        "A) \$3.27 \\text{ m/s}^2\$",
        "B) \$5.00 \\text{ m/s}^2\$",
        "C) \$1.73 \\text{ m/s}^2\$",
        "D) \$6.73 \\text{ m/s}^2\$"
      ],
      "respuesta_correcta": "A) \$3.27 \\text{ m/s}^2\$",
      "explicacion_detallada": "La fuerza neta paralela al plano es \$F_{neta} = mg \\sin 30^\\circ - \\mu_k mg \\cos 30^\\circ = ma\$. Cancelando la masa \$m\$, la aceleración es \$a = g (\\sin 30^\\circ - \\mu_k \\cos 30^\\circ)\$. Sustituyendo: \$a = 10 (0.5 - 0.2 \\times 1.73 / 2) = 10 (0.5 - 0.173) = 10(0.327) = 3.27 \\text{ m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un semáforo de masa \$M\$ está suspendido en equilibrio por dos cables idénticos que forman un ángulo \$\\theta\$ con la horizontal. La magnitud de la tensión \$T\$ en cada cable es:",
      "opciones": [
        "A) \$\\frac{Mg}{2\\sin\\theta}\$",
        "B) \$\\frac{Mg}{2\\cos\\theta}\$",
        "C) \$Mg \\sin\\theta\$",
        "D) \$Mg \\cos\\theta\$"
      ],
      "respuesta_correcta": "A) \$\\frac{Mg}{2\\sin\\theta}\$",
      "explicacion_detallada": "La suma de fuerzas verticales debe ser cero. Cada cable aporta una componente vertical de \$T \\sin\\theta\$. Con dos cables, tenemos \$2T \\sin\\theta = Mg\$. Despejando \$T\$, obtenemos \$T = \\frac{Mg}{2\\sin\\theta}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un automóvil de 1000 kg toma una curva plana y horizontal de 50 m de radio. Si el coeficiente de fricción estática entre las llantas y el pavimento es 0.5, ¿cuál es la rapidez máxima con la que puede tomar la curva sin derrapar? (Considere \$g = 10 \\text{ m/s}^2\$)",
      "opciones": [
        "A) 15.8 m/s",
        "B) 25.0 m/s",
        "C) 50.0 m/s",
        "D) 22.3 m/s"
      ],
      "respuesta_correcta": "A) 15.8 m/s",
      "explicacion_detallada": "La fuerza centrípeta es provista por la fricción estática máxima: \$m \\frac{v^2}{R} = \\mu_s N = \\mu_s mg\$. Cancelando \$m\$ y despejando \$v\$, obtenemos \$v_{max} = \\sqrt{\\mu_s R g}\$. Sustituyendo: \$v_{max} = \\sqrt{0.5 \\times 50 \\times 10} = \\sqrt{250} \\approx 15.81 \\text{ m/s}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Para que un automóvil pueda tomar una curva de radio \$R\$ a una rapidez \$v\$ sin depender de la fricción para mantenerse en la trayectoria, el ángulo de peralte \$\\theta\$ de la curva debe cumplir la relación:",
      "opciones": [
        "A) \$\\tan\\theta = \\frac{v^2}{Rg}\$",
        "B) \$\\sin\\theta = \\frac{v^2}{Rg}\$",
        "C) \$\\cos\\theta = \\frac{v^2}{Rg}\$",
        "D) \$\\tan\\theta = \\frac{Rg}{v^2}\$"
      ],
      "respuesta_correcta": "A) \$\\tan\\theta = \\frac{v^2}{Rg}\$",
      "explicacion_detallada": "En un peralte sin fricción, la componente horizontal de la normal provee la fuerza centrípeta (\$N \\sin\\theta = m v^2 / R\$) y la componente vertical equilibra el peso (\$N \\cos\\theta = mg\$). Dividiendo ambas ecuaciones, se obtiene \$\\tan\\theta = \\frac{v^2}{Rg}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Una pequeña masa \$m\$ gira en un círculo horizontal sostenida por un hilo, formando un péndulo cónico. Si el hilo forma un ángulo \$\\theta\$ con la vertical, la magnitud de la tensión en el hilo es:",
      "opciones": [
        "A) \$\\frac{mg}{\\cos\\theta}\$",
        "B) \$\\frac{mg}{\\sin\\theta}\$",
        "C) \$mg \\cos\\theta\$",
        "D) \$mg \\sin\\theta\$"
      ],
      "respuesta_correcta": "A) \$\\frac{mg}{\\cos\\theta}\$",
      "explicacion_detallada": "En el péndulo cónico, no hay movimiento en el eje vertical, por lo que la componente vertical de la tensión equilibra al peso: \$T_y = T \\cos\\theta = mg\$. Despejando \$T\$, se obtiene \$T = \\frac{mg}{\\cos\\theta}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Dos bloques de masas \$m_1 = 2 \\text{ kg}\$ y \$m_2 = 3 \\text{ kg}\$ están en contacto sobre una superficie horizontal lisa. Se aplica una fuerza horizontal de 10 N sobre \$m_1\$, empujando al sistema. ¿Cuál es la magnitud de la fuerza de contacto entre los dos bloques?",
      "opciones": [
        "A) 4 N",
        "B) 6 N",
        "C) 10 N",
        "D) 0 N"
      ],
      "respuesta_correcta": "B) 6 N",
      "explicacion_detallada": "Primero calculamos la aceleración del sistema: \$a = \\frac{F_{total}}{m_1 + m_2} = \\frac{10}{5} = 2 \\text{ m/s}^2\$. La fuerza de contacto es la única fuerza que empuja a \$m_2\$, así que aplicando la segunda ley a \$m_2\$: \$F_{contacto} = m_2 \\cdot a = 3 \\cdot 2 = 6 \\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un bloque de masa \$m\$ se lanza hacia arriba por un plano inclinado un ángulo \$\\theta\$ respecto a la horizontal. Si el coeficiente de fricción cinética es \$\\mu_k\$, la magnitud de su aceleración de frenado es:",
      "opciones": [
        "A) \$g(\\sin\\theta + \\mu_k \\cos\\theta)\$",
        "B) \$g(\\sin\\theta - \\mu_k \\cos\\theta)\$",
        "C) \$g(\\cos\\theta + \\mu_k \\sin\\theta)\$",
        "D) \$g \\sin\\theta\$"
      ],
      "respuesta_correcta": "A) \$g(\\sin\\theta + \\mu_k \\cos\\theta)\$",
      "explicacion_detallada": "Al moverse hacia arriba, tanto la componente del peso (\$mg \\sin\\theta\$) como la fuerza de fricción cinética (\$\\mu_k mg \\cos\\theta\$) actúan hacia abajo por el plano. La fuerza neta es \$F = mg \\sin\\theta + \\mu_k mg \\cos\\theta\$. Dividiendo entre \$m\$, la aceleración de frenado es \$a = g(\\sin\\theta + \\mu_k \\cos\\theta)\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un pequeño bloque atado a una cuerda de longitud \$R\$ gira en un círculo vertical. La rapidez mínima que debe tener el bloque en el punto más alto del círculo para mantener la trayectoria circular es:",
      "opciones": [
        "A) \$\\sqrt{Rg}\$",
        "B) \$\\sqrt{2Rg}\$",
        "C) \$\\sqrt{5Rg}\$",
        "D) \$Rg\$"
      ],
      "respuesta_correcta": "A) \$\\sqrt{Rg}\$",
      "explicacion_detallada": "En el punto más alto, la tensión mínima es cero en el límite de mantener la trayectoria. La única fuerza centrípeta es el peso: \$mg = m \\frac{v^2}{R}\$. Despejando \$v\$, obtenemos la rapidez crítica \$v = \\sqrt{Rg}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Una esfera de 0.2 kg está atada a una cuerda y gira en un círculo vertical de 1 m de radio. Si la rapidez de la esfera en el punto más bajo es de 5 m/s, ¿cuál es la tensión de la cuerda en ese punto? (Considere \$g = 10 \\text{ m/s}^2\$)",
      "opciones": [
        "A) 7 N",
        "B) 3 N",
        "C) 5 N",
        "D) 2 N"
      ],
      "respuesta_correcta": "A) 7 N",
      "explicacion_detallada": "En el punto más bajo, la fuerza centrípeta apunta hacia el centro (arriba): \$T - mg = m \\frac{v^2}{R}\$. Sustituyendo valores: \$T - 0.2(10) = 0.2 \\frac{5^2}{1} \\Rightarrow T - 2 = 0.2(25) \\Rightarrow T - 2 = 5 \\Rightarrow T = 7 \\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "En una máquina en la que un bloque de masa \$M\$ reposa sobre una mesa horizontal con coeficiente de fricción cinética \$\\mu_k\$, y está unido por una cuerda ideal a otro bloque colgante de masa \$m\$, la aceleración del sistema, asumiendo que se mueve, es:",
      "opciones": [
        "A) \$\\frac{mg - \\mu_k Mg}{M + m}\$",
        "B) \$\\frac{Mg - \\mu_k mg}{M + m}\$",
        "C) \$\\frac{mg}{M + m}\$",
        "D) \$\\frac{(m - M)g}{M + m}\$"
      ],
      "respuesta_correcta": "A) \$\\frac{mg - \\mu_k Mg}{M + m}\$",
      "explicacion_detallada": "Las ecuaciones de movimiento son \$mg - T = ma\$ (para el colgante) y \$T - \\mu_k Mg = Ma\$ (para el bloque en la mesa). Sumando ambas se elimina \$T\$: \$mg - \\mu_k Mg = (M + m)a\$. Despejando \$a\$, se obtiene \$a = \\frac{mg - \\mu_k Mg}{M + m}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Se presiona fuertemente un borrador de masa \$m\$ contra una pared vertical con una fuerza horizontal \$F\$. Si el coeficiente de fricción estática entre el borrador y la pared es \$\\mu_s\$, ¿cuál es el valor mínimo de \$F\$ para evitar que el borrador caiga?",
      "opciones": [
        "A) \$\\frac{mg}{\\mu_s}\$",
        "B) \$\\mu_s mg\$",
        "C) \$mg\$",
        "D) \$\\frac{\\mu_s}{mg}\$"
      ],
      "respuesta_correcta": "A) \$\\frac{mg}{\\mu_s}\$",
      "explicacion_detallada": "Para que no caiga, la fuerza de fricción estática máxima debe igualar al peso: \$f_s = mg\$. Como la fuerza normal es igual a la fuerza aplicada \$F\$ (por equilibrio horizontal), tenemos \$\\mu_s F = mg\$. Despejando \$F\$, resulta \$F = \\frac{mg}{\\mu_s}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un bloque de 10 kg se encuentra en reposo en un plano inclinado de 45° respecto a la horizontal. El valor de la fuerza de fricción estática que actúa sobre el bloque es: (Considere \$g = 10 \\text{ m/s}^2\$ y \$\\sin 45^\\circ = \\cos 45^\\circ = 0.707\$)",
      "opciones": [
        "A) 70.7 N",
        "B) 100.0 N",
        "C) 50.0 N",
        "D) 0 N"
      ],
      "respuesta_correcta": "A) 70.7 N",
      "explicacion_detallada": "Dado que el bloque está en reposo, la fuerza de fricción estática iguala exactamente a la componente paralela del peso para mantener el equilibrio. \$f_s = mg \\sin 45^\\circ = 10 \\times 10 \\times 0.707 = 70.7 \\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "En un juego mecánico cilíndrico de radio \$R\$ que gira sobre su eje vertical, un pasajero no cae cuando el piso desciende si la rapidez angular \$\\omega\$ es suficiente. Si el coeficiente de fricción estática es \$\\mu_s\$, la condición que se debe cumplir es:",
      "opciones": [
        "A) \$\\omega \\ge \\sqrt{\\frac{g}{\\mu_s R}}\$",
        "B) \$\\omega \\ge \\sqrt{\\frac{\\mu_s g}{R}}\$",
        "C) \$\\omega \\le \\sqrt{\\frac{g}{\\mu_s R}}\$",
        "D) \$\\omega = \\frac{g}{\\mu_s R}\$"
      ],
      "respuesta_correcta": "A) \$\\omega \\ge \\sqrt{\\frac{g}{\\mu_s R}}\$",
      "explicacion_detallada": "La fuerza normal provee la aceleración centrípeta: \$N = m\\omega^2R\$. Para no caer, la fricción debe soportar el peso: \$\\mu_s N \\ge mg\$. Sustituyendo \$N\$, \$\\mu_s (m\\omega^2R) \\ge mg\$. Simplificando y despejando \$\\omega\$, se obtiene \$\\omega \\ge \\sqrt{\\frac{g}{\\mu_s R}}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Dos masas \$m_1 = 4 \\text{ kg}\$ (en un plano inclinado de 30° sin fricción) y \$m_2 = 6 \\text{ kg}\$ (colgando verticalmente) están conectadas por una cuerda que pasa por una polea ideal en el ápice del plano. La aceleración del sistema es: (Considere \$g = 10 \\text{ m/s}^2\$)",
      "opciones": [
        "A) 4.0 m/s²",
        "B) 6.0 m/s²",
        "C) 2.0 m/s²",
        "D) 8.0 m/s²"
      ],
      "respuesta_correcta": "A) 4.0 m/s²",
      "explicacion_detallada": "Fuerza impulsora neta es el peso de \$m_2\$ menos la componente paralela del peso de \$m_1\$: \$F_{neta} = m_2 g - m_1 g \\sin 30^\\circ = 60 - 40(0.5) = 60 - 20 = 40 \\text{ N}\$. Masa total a mover = \$6+4=10 \\text{ kg}\$. Aceleración \$a = \\frac{F_{neta}}{m_{total}} = \\frac{40}{10} = 4.0 \\text{ m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "Un bloque de masa \$m\$ es arrastrado sobre un piso rugoso horizontal empujándolo con una fuerza \$F\$ dirigida con un ángulo \$\\phi\$ por debajo de la horizontal. Si el coeficiente de fricción cinética es \$\\mu_k\$, la magnitud de la fuerza de fricción es:",
      "opciones": [
        "A) \$\\mu_k (mg + F \\sin\\phi)\$",
        "B) \$\\mu_k (mg - F \\sin\\phi)\$",
        "C) \$\\mu_k (mg + F \\cos\\phi)\$",
        "D) \$\\mu_k mg\$"
      ],
      "respuesta_correcta": "A) \$\\mu_k (mg + F \\sin\\phi)\$",
      "explicacion_detallada": "Al empujar hacia abajo, la componente vertical de la fuerza, \$F \\sin\\phi\$, se suma al peso. Por lo tanto, la fuerza normal se incrementa y es \$N = mg + F \\sin\\phi\$. La fuerza de fricción cinética es \$f_k = \\mu_k N = \\mu_k (mg + F \\sin\\phi)\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.4",
      "enunciado": "En el diagrama de cuerpo libre para un objeto en movimiento circular uniforme que se desliza sobre una mesa horizontal sin fricción, atado a un poste central, la fuerza neta en la dirección radial es:",
      "opciones": [
        "A) Igual a la tensión de la cuerda y apunta al centro",
        "B) Cero, porque el movimiento es a rapidez constante",
        "C) Igual al peso del objeto",
        "D) Igual a la fuerza normal"
      ],
      "respuesta_correcta": "A) Igual a la tensión de la cuerda y apunta al centro",
      "explicacion_detallada": "En el plano horizontal, el peso se cancela con la normal. La única fuerza radial (horizontal) que actúa sobre el objeto es la tensión de la cuerda, la cual provee la fuerza centrípeta necesaria para el movimiento circular y siempre apunta hacia el centro del círculo."
    }
  ];

  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < nuevasPreguntas.length; i++) {
    var p = nuevasPreguntas[i];
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
  print('20 preguntas inyectadas para el código 3.7.4 mediante Dart List.');
}
