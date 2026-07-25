import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> nuevasPreguntas = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "¿Qué establece la Primera Ley de Newton, también conocida como ley de la inercia?",
      "opciones": [
        "A) Todo cuerpo persevera en su estado de reposo o movimiento rectilíneo uniforme a no ser que sea obligado a cambiar su estado por fuerzas impresas sobre él.",
        "B) El cambio de movimiento es directamente proporcional a la fuerza motriz impresa y ocurre según la línea recta a lo largo de la cual aquella fuerza se imprime.",
        "C) Con toda acción ocurre siempre una reacción igual y contraria.",
        "D) La aceleración de un objeto es inversamente proporcional a la fuerza neta que actúa sobre él."
      ],
      "respuesta_correcta": "A) Todo cuerpo persevera en su estado de reposo o movimiento rectilíneo uniforme a no ser que sea obligado a cambiar su estado por fuerzas impresas sobre él.",
      "explicacion_detallada": "La Primera Ley de Newton o Ley de la Inercia indica que un cuerpo mantendrá su estado (reposo o velocidad constante) si la fuerza neta que actúa sobre él es nula."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Una fuerza neta de \$20\\text{ N}\$ actúa sobre un cuerpo de \$5\\text{ kg}\$ de masa. ¿Cuál es su aceleración?",
      "opciones": [
        "A) \$100\\text{ m/s}^2\$",
        "B) \$4\\text{ m/s}^2\$",
        "C) \$15\\text{ m/s}^2\$",
        "D) \$0,25\\text{ m/s}^2\$"
      ],
      "respuesta_correcta": "B) \$4\\text{ m/s}^2\$",
      "explicacion_detallada": "Aplicando la Segunda Ley de Newton, \$F = m \\cdot a\$. Despejando la aceleración: \$a = F / m = 20 / 5 = 4\\text{ m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Si una persona empuja una pared con una fuerza de \$50\\text{ N}\$, ¿qué fuerza ejerce la pared sobre la persona?",
      "opciones": [
        "A) \$0\\text{ N}\$ porque la pared no se mueve.",
        "B) \$50\\text{ N}\$ en la misma dirección del empuje.",
        "C) \$50\\text{ N}\$ en dirección opuesta.",
        "D) Depende de la masa de la pared."
      ],
      "respuesta_correcta": "C) \$50\\text{ N}\$ en dirección opuesta.",
      "explicacion_detallada": "Según la Tercera Ley de Newton (acción y reacción), si se ejerce una fuerza sobre un objeto, este ejerce una fuerza de igual magnitud pero en sentido contrario sobre el primero."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "¿Cuál es la relación matemática que describe la Segunda Ley de Newton?",
      "opciones": [
        "A) \$v = d / t\$",
        "B) \$W = F \\cdot d\$",
        "C) \$\\sum F = m \\cdot a\$",
        "D) \$E = m \\cdot c^2\$"
      ],
      "respuesta_correcta": "C) \$\\sum F = m \\cdot a\$",
      "explicacion_detallada": "La Segunda Ley de Newton establece que la suma de las fuerzas sobre un objeto es igual a su masa multiplicada por su aceleración."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un objeto se mueve en el espacio exterior (lejos de cualquier influencia gravitacional) a velocidad constante. Podemos afirmar que:",
      "opciones": [
        "A) Una fuerza constante lo empuja.",
        "B) Su inercia es cero.",
        "C) La fuerza neta sobre el objeto es cero.",
        "D) Está experimentando una aceleración."
      ],
      "respuesta_correcta": "C) La fuerza neta sobre el objeto es cero.",
      "explicacion_detallada": "Por la Primera Ley de Newton, para que un objeto mantenga velocidad constante (MRU), la fuerza neta que actúa sobre él debe ser cero."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un automóvil de \$1000\\text{ kg}\$ frena con una aceleración constante de \$-3\\text{ m/s}^2\$. ¿Cuál es la magnitud de la fuerza neta aplicada sobre el vehículo?",
      "opciones": [
        "A) \$333\\text{ N}\$",
        "B) \$3000\\text{ N}\$",
        "C) \$1000\\text{ N}\$",
        "D) \$30\\text{ N}\$"
      ],
      "respuesta_correcta": "B) \$3000\\text{ N}\$",
      "explicacion_detallada": "Por la Segunda Ley de Newton: \$F = m \\cdot a = 1000 \\cdot |-3| = 3000\\text{ N}\$. La magnitud de la fuerza es \$3000\\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "El peso de un objeto es un ejemplo de una fuerza. Su magnitud en la Tierra se calcula multiplicando la masa del objeto por:",
      "opciones": [
        "A) La constante gravitacional universal \$G\$.",
        "B) La aceleración de la gravedad \$g\$.",
        "C) La velocidad del objeto en caída.",
        "D) La densidad del objeto."
      ],
      "respuesta_correcta": "B) La aceleración de la gravedad \$g\$.",
      "explicacion_detallada": "El peso se define como \$P = m \\cdot g\$, donde \$m\$ es la masa y \$g\$ es la aceleración debida a la gravedad (\$9.8\\text{ m/s}^2\$ en la superficie de la Tierra)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Se aplican dos fuerzas sobre un bloque: \$F_1 = 10\\text{ N}\$ hacia la derecha y \$F_2 = 4\\text{ N}\$ hacia la izquierda. Si la masa del bloque es \$2\\text{ kg}\$, ¿cuál es su aceleración?",
      "opciones": [
        "A) \$7\\text{ m/s}^2\$ a la derecha",
        "B) \$3\\text{ m/s}^2\$ a la derecha",
        "C) \$3\\text{ m/s}^2\$ a la izquierda",
        "D) \$14\\text{ m/s}^2\$ a la derecha"
      ],
      "respuesta_correcta": "B) \$3\\text{ m/s}^2\$ a la derecha",
      "explicacion_detallada": "Fuerza neta \$= 10 - 4 = 6\\text{ N}\$ hacia la derecha. Aceleración \$= F_{\\text{neta}} / m = 6 / 2 = 3\\text{ m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Dos cuerpos de distinta masa están sujetos a la misma fuerza neta constante. ¿Cuál adquirirá mayor aceleración?",
      "opciones": [
        "A) El de mayor masa.",
        "B) El de menor masa.",
        "C) Ambos adquirirán la misma aceleración.",
        "D) Depende de sus velocidades iniciales."
      ],
      "respuesta_correcta": "B) El de menor masa.",
      "explicacion_detallada": "Según \$a = F / m\$, si la fuerza es constante, la aceleración es inversamente proporcional a la masa. Por lo tanto, menor masa implica mayor aceleración."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "De acuerdo con la Tercera Ley de Newton, ¿por qué un caballo puede tirar de una carreta hacia adelante si la carreta tira del caballo hacia atrás con una fuerza igual y opuesta?",
      "opciones": [
        "A) Porque el caballo aplica una fuerza sobre el suelo y este sobre el caballo, y las fuerzas de acción-reacción actúan en cuerpos diferentes.",
        "B) Porque la fuerza del caballo es ligeramente mayor que la de la reacción de la carreta.",
        "C) Porque la Tercera Ley no aplica a objetos en movimiento acelerado.",
        "D) Porque la masa del caballo es mayor que la de la carreta."
      ],
      "respuesta_correcta": "A) Porque el caballo aplica una fuerza sobre el suelo y este sobre el caballo, y las fuerzas de acción-reacción actúan en cuerpos diferentes.",
      "explicacion_detallada": "Las fuerzas del par acción-reacción se aplican sobre cuerpos distintos. Para analizar el movimiento del caballo, importa la fuerza que el suelo ejerce sobre él hacia adelante (reacción al empuje de las pezuñas hacia atrás) y la fuerza que la carreta ejerce hacia atrás. Si la fuerza del suelo es mayor, el caballo acelera."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Si un astronauta lanza una llave inglesa en el espacio exterior (sin fricción), la llave:",
      "opciones": [
        "A) Se detendrá después de recorrer cierta distancia debido a su inercia.",
        "B) Continuará moviéndose en línea recta con velocidad constante para siempre.",
        "C) Perderá velocidad gradualmente hasta detenerse.",
        "D) Comenzará a moverse en círculos alrededor del astronauta."
      ],
      "respuesta_correcta": "B) Continuará moviéndose en línea recta con velocidad constante para siempre.",
      "explicacion_detallada": "Por la Primera Ley de Newton, al no haber fuerzas externas que actúen sobre la llave (como la fricción o gravedad significativa), mantendrá su movimiento rectilíneo uniforme."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "¿Qué es la inercia?",
      "opciones": [
        "A) La fuerza que mantiene a los objetos en movimiento.",
        "B) La resistencia de un cuerpo a cambiar su estado de reposo o de movimiento.",
        "C) La aceleración debida a la gravedad de un cuerpo.",
        "D) La masa multiplicada por la velocidad."
      ],
      "respuesta_correcta": "B) La resistencia de un cuerpo a cambiar su estado de reposo o de movimiento.",
      "explicacion_detallada": "La inercia es una propiedad de la materia por la cual los cuerpos se oponen a modificar su estado de reposo o movimiento; se cuantifica a través de la masa."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un libro reposa sobre una mesa. La fuerza normal que ejerce la mesa sobre el libro es una reacción a:",
      "opciones": [
        "A) El peso del libro.",
        "B) La fuerza que el libro ejerce sobre la mesa.",
        "C) La fuerza gravitacional de la Tierra sobre el libro.",
        "D) La fuerza de fricción entre el libro y la mesa."
      ],
      "respuesta_correcta": "B) La fuerza que el libro ejerce sobre la mesa.",
      "explicacion_detallada": "Según la Tercera Ley, la acción es el libro comprimiendo (ejerciendo fuerza sobre) la mesa y la reacción es la mesa ejerciendo una fuerza hacia arriba sobre el libro (fuerza normal)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Si la fuerza neta sobre un objeto es diferente de cero, entonces el objeto obligatoriamente:",
      "opciones": [
        "A) Mantiene su velocidad constante.",
        "B) Se mueve en línea recta.",
        "C) Acelera.",
        "D) Está en reposo."
      ],
      "respuesta_correcta": "C) Acelera.",
      "explicacion_detallada": "Según la Segunda Ley de Newton (\$\\sum F = m \\cdot a\$), si la fuerza neta no es cero y asumiendo que la masa no es cero, debe existir una aceleración."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un objeto de \$10\\text{ kg}\$ se deja caer libremente cerca de la superficie terrestre. Despreciando la resistencia del aire, ¿cuál es la fuerza neta que actúa sobre él? (Use \$g = 9.8\\text{ m/s}^2\$)",
      "opciones": [
        "A) \$0\\text{ N}\$",
        "B) \$98\\text{ N}\$ hacia abajo",
        "C) \$10\\text{ N}\$ hacia abajo",
        "D) \$9.8\\text{ N}\$ hacia abajo"
      ],
      "respuesta_correcta": "B) \$98\\text{ N}\$ hacia abajo",
      "explicacion_detallada": "En caída libre, la única fuerza actuando es el peso: \$F = m \\cdot g = 10 \\cdot 9.8 = 98\\text{ N}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Se lanza una pelota de masa \$m\$ hacia arriba. En el punto más alto de su trayectoria, su velocidad es cero. En ese instante, la fuerza neta sobre la pelota es:",
      "opciones": [
        "A) Cero, porque su velocidad es cero.",
        "B) Igual a \$m \\cdot g\$ hacia abajo.",
        "C) Igual a \$m \\cdot g\$ hacia arriba.",
        "D) Menor que \$m \\cdot g\$."
      ],
      "respuesta_correcta": "B) Igual a \$m \\cdot g\$ hacia abajo.",
      "explicacion_detallada": "Aunque la velocidad instantánea sea cero en el punto más alto, la gravedad sigue actuando sobre la pelota de forma constante, por lo que la fuerza neta sigue siendo su peso (\$m \\cdot g\$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un ascensor sube con velocidad constante. Un hombre está parado sobre una báscula dentro del ascensor. La lectura de la báscula será:",
      "opciones": [
        "A) Mayor que el peso real del hombre.",
        "B) Menor que el peso real del hombre.",
        "C) Igual al peso real del hombre.",
        "D) Cero."
      ],
      "respuesta_correcta": "C) Igual al peso real del hombre.",
      "explicacion_detallada": "Como la velocidad es constante, la aceleración es cero. La fuerza neta es cero, por lo que la fuerza normal (lectura de la báscula) es exactamente igual al peso del hombre."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "¿Cuál es la unidad de fuerza en el Sistema Internacional (SI) y en qué unidades fundamentales se desglosa?",
      "opciones": [
        "A) Joule (\$J\$); \$\\text{kg}\\cdot\\text{m}^2/\\text{s}^2\$",
        "B) Newton (\$N\$); \$\\text{kg}\\cdot\\text{m}/\\text{s}^2\$",
        "C) Pascal (\$Pa\$); \$\\text{kg}/(\\text{m}\\cdot\\text{s}^2)\$",
        "D) Watt (\$W\$); \$\\text{kg}\\cdot\\text{m}^2/\\text{s}^3\$"
      ],
      "respuesta_correcta": "B) Newton (\$N\$); \$\\text{kg}\\cdot\\text{m}/\\text{s}^2\$",
      "explicacion_detallada": "La fuerza se mide en Newtons (\$N\$). Basado en la Segunda Ley (\$F = m \\cdot a\$), las unidades son masa (\$\\text{kg}\$) por aceleración (\$\\text{m/s}^2\$), resultando en \$\\text{kg}\\cdot\\text{m/s}^2\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Un bloque resbala por un plano horizontal con fricción y eventualmente se detiene. La desaceleración del bloque se debe a:",
      "opciones": [
        "A) Que todo objeto tiende al reposo de forma natural.",
        "B) La pérdida paulatina de su 'fuerza de impulso' interna.",
        "C) La fuerza de fricción neta que actúa en sentido opuesto a su movimiento.",
        "D) La disminución de la fuerza normal."
      ],
      "respuesta_correcta": "C) La fuerza de fricción neta que actúa en sentido opuesto a su movimiento.",
      "explicacion_detallada": "De acuerdo con la Primera y Segunda Ley de Newton, el cambio en el estado de movimiento (detenerse) es causado por una fuerza externa neta; en este caso, la fuerza de rozamiento cinético."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.7.3",
      "enunciado": "Una fuerza de \$12\\text{ N}\$ se aplica continuamente sobre un carrito de \$3\\text{ kg}\$ en reposo. Después de \$2\\text{ s}\$, ¿qué velocidad habrá alcanzado el carrito si se ignora la fricción?",
      "opciones": [
        "A) \$4\\text{ m/s}\$",
        "B) \$8\\text{ m/s}\$",
        "C) \$12\\text{ m/s}\$",
        "D) \$24\\text{ m/s}\$"
      ],
      "respuesta_correcta": "B) \$8\\text{ m/s}\$",
      "explicacion_detallada": "Primero calculamos la aceleración: \$a = F / m = 12 / 3 = 4\\text{ m/s}^2\$. Luego, usando cinemática para MRUV (\$v = v_0 + a \\cdot t\$): \$v = 0 + 4 \\cdot 2 = 8\\text{ m/s}\$."
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
  print('20 preguntas inyectadas para el código 3.7.3 mediante Dart List.');
}
