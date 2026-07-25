import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> nuevasPreguntas = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "Según la primera ley de Kepler, ¿cuál es la forma de la órbita que describen los planetas alrededor del Sol y en qué posición se encuentra el Sol?",
      "opciones": [
        "A) Circular, con el Sol en el centro exacto.",
        "B) Elíptica, con el Sol en uno de los focos.",
        "C) Parabólica, con el Sol en el vértice.",
        "D) Elíptica, con el Sol en el centro geométrico de la elipse."
      ],
      "respuesta_correcta": "B) Elíptica, con el Sol en uno de los focos.",
      "explicacion_detallada": "La primera ley de Kepler, o ley de las órbitas, establece que todos los planetas se mueven en órbitas elípticas, con el Sol situado en uno de los focos de la elipse, no en el centro geométrico."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Cuál es la principal consecuencia del movimiento de rotación de la Tierra sobre su propio eje?",
      "opciones": [
        "A) La sucesión de las estaciones del año.",
        "B) La sucesión del día y la noche.",
        "C) Las fases de la Luna.",
        "D) El cambio en la distancia entre la Tierra y el Sol."
      ],
      "respuesta_correcta": "B) La sucesión del día y la noche.",
      "explicacion_detallada": "El movimiento de rotación de la Tierra es el giro que realiza sobre su propio eje, durando aproximadamente 24 horas. Este movimiento expone alternativamente diferentes partes del planeta a la luz solar, produciendo el ciclo de día y noche."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Qué fenómeno astronómico ocurre cuando la Luna se interpone exactamente entre la Tierra y el Sol, bloqueando la luz solar?",
      "opciones": [
        "A) Eclipse lunar.",
        "B) Eclipse solar.",
        "C) Cuarto menguante.",
        "D) Marea muerta."
      ],
      "respuesta_correcta": "B) Eclipse solar.",
      "explicacion_detallada": "Un eclipse solar sucede cuando la Luna pasa entre el Sol y la Tierra (en fase de luna nueva), proyectando su sombra sobre la Tierra y bloqueando total o parcialmente la visión del Sol."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "La inclinación del eje de rotación terrestre respecto a la normal del plano de la eclíptica (aproximadamente 23.5°) y su movimiento de traslación son la causa principal de:",
      "opciones": [
        "A) Las mareas vivas y muertas.",
        "B) La sucesión de las estaciones del año.",
        "C) El efecto Coriolis.",
        "D) Los eclipses periódicos."
      ],
      "respuesta_correcta": "B) La sucesión de las estaciones del año.",
      "explicacion_detallada": "La inclinación del eje terrestre hace que, durante la traslación anual alrededor del Sol, los hemisferios norte y sur reciban luz solar con diferente intensidad y duración a lo largo del año, generando las estaciones."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Por qué observamos siempre la misma cara de la Luna desde la Tierra?",
      "opciones": [
        "A) Porque la Luna no rota sobre su propio eje.",
        "B) Porque su período de rotación es igual a su período de traslación alrededor de la Tierra.",
        "C) Porque la atmósfera terrestre distorsiona la imagen de su rotación.",
        "D) Porque gira en dirección opuesta a la rotación de la Tierra."
      ],
      "respuesta_correcta": "B) Porque su período de rotación es igual a su período de traslación alrededor de la Tierra.",
      "explicacion_detallada": "Este fenómeno se conoce como rotación sincrónica o acoplamiento de marea. La Luna tarda lo mismo en girar sobre su propio eje (rotación) que en dar una vuelta completa alrededor de la Tierra (traslación)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "En la clasificación moderna del sistema solar, ¿entre las órbitas de qué planetas se encuentra el cinturón principal de asteroides?",
      "opciones": [
        "A) Tierra y Marte.",
        "B) Marte y Júpiter.",
        "C) Júpiter y Saturno.",
        "D) Urano y Neptuno."
      ],
      "respuesta_correcta": "B) Marte y Júpiter.",
      "explicacion_detallada": "El cinturón principal de asteroides es un disco circunestelar situado entre las órbitas de Marte y Júpiter, que alberga la mayor parte de los asteroides rocosos del sistema solar."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Qué fuerzas son las principales responsables de la formación de las mareas oceánicas en la Tierra?",
      "opciones": [
        "A) La fuerza magnética terrestre y el viento solar.",
        "B) La atracción gravitatoria de la Luna y el Sol sobre la Tierra.",
        "C) La fuerza centrífuga debida a la rotación de la Tierra exclusivamente.",
        "D) La presión atmosférica y las corrientes marinas."
      ],
      "respuesta_correcta": "B) La atracción gravitatoria de la Luna y el Sol sobre la Tierra.",
      "explicacion_detallada": "Las mareas son el ascenso y descenso periódico del nivel del mar, causado principalmente por la atracción gravitatoria combinada que ejercen la Luna y el Sol sobre las masas de agua terrestres, sumado al efecto de la rotación."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "En el contexto de la mecánica celeste, ¿cómo se denomina el punto de la órbita de la Tierra en el que se encuentra más cerca del Sol?",
      "opciones": [
        "A) Afelio.",
        "B) Perigeo.",
        "C) Perihelio.",
        "D) Apogeo."
      ],
      "respuesta_correcta": "C) Perihelio.",
      "explicacion_detallada": "El perihelio es el punto más próximo al Sol en la órbita de un cuerpo celeste. En el caso de la Tierra, ocurre a principios de enero. (Afelio es el punto más alejado; Perigeo y Apogeo se refieren a órbitas alrededor de la Tierra, como la de la Luna)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "La Unidad Astronómica (UA) es una unidad de longitud muy utilizada en astronomía dentro de nuestro sistema solar. ¿A qué equivale aproximadamente una UA?",
      "opciones": [
        "A) A la distancia media entre la Tierra y la Luna.",
        "B) A la distancia que recorre la luz en un año.",
        "C) Al diámetro ecuatorial del Sol.",
        "D) A la distancia media entre la Tierra y el Sol."
      ],
      "respuesta_correcta": "D) A la distancia media entre la Tierra y el Sol.",
      "explicacion_detallada": "La Unidad Astronómica (UA) equivale a aproximadamente 150 millones de kilómetros, que es la distancia media desde el centro de la Tierra hasta el centro del Sol. Se usa para medir distancias dentro del sistema solar."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Qué planetas del sistema solar se clasifican como 'terrestres' o rocosos debido a su composición superficial sólida y alta densidad?",
      "opciones": [
        "A) Mercurio, Venus, Tierra y Marte.",
        "B) Júpiter, Saturno, Urano y Neptuno.",
        "C) Mercurio, Marte, Júpiter y Saturno.",
        "D) Venus, Tierra, Urano y Plutón."
      ],
      "respuesta_correcta": "A) Mercurio, Venus, Tierra y Marte.",
      "explicacion_detallada": "Los planetas interiores del sistema solar (Mercurio, Venus, Tierra y Marte) son pequeños, densos y tienen superficies rocosas sólidas, a diferencia de los gigantes gaseosos (Júpiter y Saturno) y gigantes de hielo (Urano y Neptuno)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "Durante un eclipse lunar, ¿cuál es la disposición relativa de los cuerpos celestes?",
      "opciones": [
        "A) Tierra - Sol - Luna.",
        "B) Sol - Tierra - Luna.",
        "C) Sol - Luna - Tierra.",
        "D) Luna - Sol - Tierra."
      ],
      "respuesta_correcta": "B) Sol - Tierra - Luna.",
      "explicacion_detallada": "Un eclipse lunar ocurre cuando la Tierra se interpone entre el Sol y la Luna, bloqueando los rayos solares que iluminan la Luna. Solo puede suceder en la fase de luna llena."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "El experimento del péndulo de Foucault, concebido en el siglo XIX, proporciona una demostración física directa de:",
      "opciones": [
        "A) La traslación de la Tierra.",
        "B) La rotación de la Tierra.",
        "C) La gravitación universal de Newton.",
        "D) El ensanchamiento ecuatorial de la Tierra."
      ],
      "respuesta_correcta": "B) La rotación de la Tierra.",
      "explicacion_detallada": "El péndulo de Foucault oscila libremente mientras el plano de su oscilación parece rotar con el paso de las horas. En realidad, es la Tierra la que está rotando bajo el plano de oscilación fijo del péndulo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Qué es el 'equinoccio' astronómico?",
      "opciones": [
        "A) El momento en que el Sol alcanza su máxima declinación norte o sur.",
        "B) El punto de la órbita terrestre donde la Tierra está más cerca del Sol.",
        "C) El momento del año en que el Sol incide perpendicularmente sobre el ecuador, haciendo que el día y la noche duren lo mismo.",
        "D) El período en que la Luna está en fase llena."
      ],
      "respuesta_correcta": "C) El momento del año en que el Sol incide perpendicularmente sobre el ecuador, haciendo que el día y la noche duren lo mismo.",
      "explicacion_detallada": "Durante los equinoccios (primavera y otoño), el eje de la Tierra no está inclinado ni hacia el Sol ni lejos de él, por lo que el Sol está en el cénit en el ecuador, y el día y la noche tienen duraciones casi iguales en todo el mundo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿A qué se debe el campo magnético de la Tierra, el cual nos protege de la radiación y el viento solar?",
      "opciones": [
        "A) A la presencia de grandes yacimientos de hierro en la corteza terrestre.",
        "B) A los movimientos de convección en el núcleo externo de hierro líquido combinados con la rotación del planeta.",
        "C) A la fricción de la atmósfera terrestre con las partículas solares.",
        "D) A la atracción gravitatoria constante de la Luna."
      ],
      "respuesta_correcta": "B) A los movimientos de convección en el núcleo externo de hierro líquido combinados con la rotación del planeta.",
      "explicacion_detallada": "El campo magnético terrestre se genera por el 'efecto dinamo': el fluido de hierro y níquel en estado líquido en el núcleo externo, al moverse por convección y por la rotación del planeta, crea corrientes eléctricas que generan el campo magnético."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Cuál es la fase lunar en la que la cara visible de la Luna está completamente oscura desde la perspectiva terrestre?",
      "opciones": [
        "A) Luna llena.",
        "B) Cuarto creciente.",
        "C) Luna nueva.",
        "D) Cuarto menguante."
      ],
      "respuesta_correcta": "C) Luna nueva.",
      "explicacion_detallada": "En la fase de luna nueva (o novilunio), la Luna se encuentra entre la Tierra y el Sol. Por lo tanto, el hemisferio lunar iluminado por el Sol queda en dirección opuesta a la Tierra, y la cara que vemos está a oscuras."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "A diferencia de la mayoría de los planetas, Venus tiene una rotación 'retrógrada'. ¿Qué significa esto en términos de su movimiento sobre su propio eje?",
      "opciones": [
        "A) Gira sobre su eje más rápido de lo que orbita al Sol.",
        "B) Gira en dirección opuesta a la de su órbita y a la mayoría de los demás planetas (de este a oeste).",
        "C) Su eje de rotación es paralelo al plano de su órbita.",
        "D) No tiene movimiento de rotación absoluto."
      ],
      "respuesta_correcta": "B) Gira en dirección opuesta a la de su órbita y a la mayoría de los demás planetas (de este a oeste).",
      "explicacion_detallada": "Venus tiene una rotación retrógrada, lo que significa que, si se observara desde el polo norte del sistema solar, gira en el sentido de las agujas del reloj, contrario a la rotación de la Tierra. Como resultado, en Venus el Sol sale por el oeste y se pone por el este."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "La Luna carece de una atmósfera significativa. ¿Cuál de los siguientes principios físicos explica mejor este hecho?",
      "opciones": [
        "A) Su excesiva proximidad al Sol.",
        "B) Su falta de agua líquida en la superficie.",
        "C) Su baja gravedad, que hace que su velocidad de escape sea menor que la velocidad térmica media de los gases.",
        "D) El viento solar arrastra continuamente los gases al carecer de magnetosfera."
      ],
      "respuesta_correcta": "C) Su baja gravedad, que hace que su velocidad de escape sea menor que la velocidad térmica media de los gases.",
      "explicacion_detallada": "Al tener una masa mucho menor que la Tierra, la gravedad de la Luna es baja y, consecuentemente, su velocidad de escape es baja (\$2.38 \\text{ km/s}\$). Los gases ligeros alcanzan velocidades térmicas superiores a esta velocidad de escape y se disipan en el espacio."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Qué término astronómico se utiliza para describir el momento en que el Sol alcanza su posición más alta o más baja en el cielo al mediodía, marcando el inicio del verano o el invierno?",
      "opciones": [
        "A) Equinoccio.",
        "B) Solsticio.",
        "C) Apogeo.",
        "D) Sizigia."
      ],
      "respuesta_correcta": "B) Solsticio.",
      "explicacion_detallada": "Los solsticios son los momentos del año en los que el Sol alcanza su mayor o menor altura aparente en el cielo, y la duración del día o de la noche son las máximas del año, respectivamente. Marcan el inicio del verano y del invierno."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "De acuerdo a la segunda ley de Kepler (ley de las áreas), un planeta en su órbita elíptica alrededor del Sol viaja más rápido cuando:",
      "opciones": [
        "A) Pasa por su afelio.",
        "B) Pasa por su perihelio.",
        "C) Pasa por el equinoccio.",
        "D) Su distancia al Sol es el promedio exacto."
      ],
      "respuesta_correcta": "B) Pasa por su perihelio.",
      "explicacion_detallada": "La segunda ley de Kepler establece que el radio vector que une el planeta y el Sol barre áreas iguales en tiempos iguales. Para que esto se cumpla, la velocidad orbital del planeta debe aumentar a medida que se acerca al Sol (perihelio) y disminuir cuando se aleja (afelio)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.9.1",
      "enunciado": "¿Cuál es la causa principal de la fuerza de Coriolis en la atmósfera y los océanos terrestres?",
      "opciones": [
        "A) El magnetismo terrestre.",
        "B) El calentamiento desigual de la Tierra por el Sol.",
        "C) La rotación de la Tierra sobre su eje.",
        "D) La atracción gravitacional de la Luna."
      ],
      "respuesta_correcta": "C) La rotación de la Tierra sobre su eje.",
      "explicacion_detallada": "El efecto Coriolis es una aceleración aparente que experimentan los objetos o fluidos en movimiento en un sistema de referencia en rotación, como la Tierra. Desvía los vientos y corrientes hacia la derecha en el hemisferio norte y hacia la izquierda en el hemisferio sur."
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
  print('20 preguntas inyectadas para el código 3.9.1 mediante Dart List.');
}
