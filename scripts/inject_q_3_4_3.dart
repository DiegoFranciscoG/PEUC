import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Qué partículas subatómicas determinan principalmente el número atómico ($Z$) y la identidad de un elemento químico?",
    "opciones": [
      "A) Los neutrones del núcleo.",
      "B) Los protones del núcleo.",
      "C) Los electrones de las capas externas.",
      "D) La suma de protones y neutrones."
    ],
    "respuesta_correcta": "B) Los protones del núcleo.",
    "explicacion_detallada": "El número atómico ($Z$) se define como el número de protones en el núcleo de un átomo y es la característica fundamental que identifica a un elemento químico específico."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "El número de masa ($A$) de un átomo se calcula sumando la cantidad de:",
    "opciones": [
      "A) Protones y electrones.",
      "B) Neutrones y electrones.",
      "C) Protones y neutrones.",
      "D) Electrones de valencia y protones."
    ],
    "respuesta_correcta": "C) Protones y neutrones.",
    "explicacion_detallada": "El número de masa o número másico ($A$) representa la masa aproximada del átomo y corresponde a la suma de los nucleones, es decir, protones y neutrones presentes en el núcleo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "Los átomos de un mismo elemento que poseen igual número atómico pero distinto número de masa se denominan:",
    "opciones": [
      "A) Isómeros.",
      "B) Isóbaros.",
      "C) Isótonos.",
      "D) Isótopos."
    ],
    "respuesta_correcta": "D) Isótopos.",
    "explicacion_detallada": "Los isótopos son átomos de un mismo elemento (igual $Z$, igual cantidad de protones) que difieren en el número de neutrones en su núcleo, lo que resulta en un número de masa ($A$) diferente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Cómo se denominan las filas horizontales y las columnas verticales en la tabla periódica moderna, respectivamente?",
    "opciones": [
      "A) Grupos y familias.",
      "B) Periodos y grupos.",
      "C) Bloques y periodos.",
      "D) Familias y series."
    ],
    "respuesta_correcta": "B) Periodos y grupos.",
    "explicacion_detallada": "En la tabla periódica, las filas horizontales se llaman periodos y las columnas verticales se denominan grupos o familias. Los elementos de un mismo grupo comparten propiedades químicas similares."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "Según la ley periódica moderna de Moseley, las propiedades de los elementos son funciones periódicas de su:",
    "opciones": [
      "A) Masa atómica.",
      "B) Peso equivalente.",
      "C) Número de masa.",
      "D) Número atómico."
    ],
    "respuesta_correcta": "D) Número atómico.",
    "explicacion_detallada": "Henry Moseley demostró que las propiedades de los elementos químicos varían de manera periódica en función de sus números atómicos ($Z$), no de sus masas atómicas como propuso originalmente Mendeleiev."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "En la tabla periódica, ¿cómo varía el radio atómico de los elementos?",
    "opciones": [
      "A) Aumenta de izquierda a derecha en un periodo y disminuye de arriba hacia abajo en un grupo.",
      "B) Disminuye de izquierda a derecha en un periodo y aumenta de arriba hacia abajo en un grupo.",
      "C) Aumenta tanto al avanzar en un periodo como al descender en un grupo.",
      "D) Es constante en un grupo y aumenta en el periodo."
    ],
    "respuesta_correcta": "B) Disminuye de izquierda a derecha en un periodo y aumenta de arriba hacia abajo en un grupo.",
    "explicacion_detallada": "El radio atómico disminuye de izquierda a derecha en un periodo debido al aumento de la carga nuclear efectiva, que atrae a los electrones con más fuerza. Aumenta al descender en un grupo debido a la adición de nuevas capas o niveles de energía."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "La energía mínima necesaria para arrancar un electrón de un átomo gaseoso en su estado fundamental se conoce como:",
    "opciones": [
      "A) Electronegatividad.",
      "B) Afinidad electrónica.",
      "C) Energía de ionización.",
      "D) Carácter metálico."
    ],
    "respuesta_correcta": "C) Energía de ionización.",
    "explicacion_detallada": "La energía de ionización es la energía requerida para remover un electrón del nivel más externo de un átomo neutro en estado gaseoso, formando un catión."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Qué grupo de la tabla periódica se caracteriza por ser muy reactivo, tener un electrón en su capa de valencia y no encontrarse libres en la naturaleza?",
    "opciones": [
      "A) Gases nobles (Grupo 18).",
      "B) Metales alcalinotérreos (Grupo 2).",
      "C) Halógenos (Grupo 17).",
      "D) Metales alcalinos (Grupo 1)."
    ],
    "respuesta_correcta": "D) Metales alcalinos (Grupo 1).",
    "explicacion_detallada": "Los metales alcalinos (Litio, Sodio, Potasio, etc.) tienen un solo electrón de valencia, por lo que tienen baja energía de ionización, son extremadamente reactivos y siempre se hallan combinados en la naturaleza."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "La capacidad de un átomo en una molécula para atraer hacia sí los electrones compartidos en un enlace químico se llama:",
    "opciones": [
      "A) Afinidad electrónica.",
      "B) Electronegatividad.",
      "C) Potencial de ionización.",
      "D) Radio iónico."
    ],
    "respuesta_correcta": "B) Electronegatividad.",
    "explicacion_detallada": "La electronegatividad, definida por Linus Pauling, es la medida de la tendencia de un átomo a atraer los electrones de un enlace químico. El flúor es el elemento más electronegativo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "Si un átomo neutro gana uno o más electrones, se transforma en un ión con carga negativa llamado:",
    "opciones": [
      "A) Anión.",
      "B) Catión.",
      "C) Isótopo.",
      "D) Protón."
    ],
    "respuesta_correcta": "A) Anión.",
    "explicacion_detallada": "Al ganar electrones, el átomo adquiere un exceso de carga negativa, convirtiéndose en un anión. Los no metales tienden a formar aniones."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿En qué región de la tabla periódica se ubican los elementos de transición?",
    "opciones": [
      "A) En los grupos 1 y 2 (bloque s).",
      "B) En los grupos 13 al 18 (bloque p).",
      "C) En los grupos 3 al 12 (bloque d).",
      "D) En las series de lantánidos y actínidos (bloque f)."
    ],
    "respuesta_correcta": "C) En los grupos 3 al 12 (bloque d).",
    "explicacion_detallada": "Los elementos de transición se encuentran en el bloque d de la tabla periódica, correspondiendo a los grupos del 3 al 12. Se caracterizan por tener electrones en orbitales d."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "El elemento de configuración electrónica $1s^2 2s^2 2p^5$ pertenece al grupo de los:",
    "opciones": [
      "A) Gases nobles.",
      "B) Halógenos.",
      "C) Anfígenos (calcógenos).",
      "D) Alcalinotérreos."
    ],
    "respuesta_correcta": "B) Halógenos.",
    "explicacion_detallada": "La configuración termina en $2s^2 2p^5$, indicando que tiene 7 electrones de valencia. Los elementos con 7 electrones de valencia pertenecen al Grupo 17 de los halógenos (en este caso es el flúor)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Cuál de los siguientes grupos de elementos presenta la configuración electrónica más estable, lo que explica su casi nula reactividad?",
    "opciones": [
      "A) Metales de acuñación.",
      "B) Gases nobles.",
      "C) Halógenos.",
      "D) Térreos."
    ],
    "respuesta_correcta": "B) Gases nobles.",
    "explicacion_detallada": "Los gases nobles (Grupo 18) poseen su capa de valencia completa ($ns^2 np^6$, excepto el Helio que es $1s^2$), lo que les confiere una gran estabilidad química y reactividad casi nula."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "Un elemento $X$ forma fácilmente cationes $X^{2+}$. ¿A qué grupo de la tabla periódica es más probable que pertenezca?",
    "opciones": [
      "A) Grupo 1 (Alcalinos).",
      "B) Grupo 2 (Alcalinotérreos).",
      "C) Grupo 16 (Anfígenos).",
      "D) Grupo 17 (Halógenos)."
    ],
    "respuesta_correcta": "B) Grupo 2 (Alcalinotérreos).",
    "explicacion_detallada": "Los metales alcalinotérreos tienen dos electrones de valencia en su capa más externa ($ns^2$). Para alcanzar estabilidad pierden esos dos electrones, formando cationes de carga +2."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "La electronegatividad alcanza su valor máximo en la tabla periódica en el elemento:",
    "opciones": [
      "A) Oxígeno.",
      "B) Helio.",
      "C) Francio.",
      "D) Flúor."
    ],
    "respuesta_correcta": "D) Flúor.",
    "explicacion_detallada": "El flúor (F) está situado arriba a la derecha de la tabla periódica (excluyendo los gases nobles) y es el elemento más electronegativo, con un valor de 4.0 en la escala de Pauling."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "Los elementos que tienen propiedades físicas y químicas intermedias entre metales y no metales se denominan:",
    "opciones": [
      "A) Metales de transición interna.",
      "B) Gases nobles.",
      "C) Metaloides o semimetales.",
      "D) Elementos transuránicos."
    ],
    "respuesta_correcta": "C) Metaloides o semimetales.",
    "explicacion_detallada": "Los metaloides (como el silicio, germanio, boro, arsénico) se sitúan en la línea diagonal o 'escalera' entre metales y no metales, y actúan como semiconductores."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Qué elemento tiene el mayor radio atómico entre las siguientes opciones?",
    "opciones": [
      "A) Cloro ($Z=17$)",
      "B) Sodio ($Z=11$)",
      "C) Flúor ($Z=9$)",
      "D) Litio ($Z=3$)"
    ],
    "respuesta_correcta": "B) Sodio ($Z=11$)",
    "explicacion_detallada": "El sodio y el cloro están en el periodo 3; el sodio, estando más a la izquierda, tiene mayor radio que el cloro. Comparado con litio y flúor (periodo 2), el sodio tiene un nivel de energía adicional (capa extra), por lo que es el más grande."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "La carga nuclear efectiva ($Z_{ef}$) sobre los electrones de valencia aumenta progresivamente en un periodo de izquierda a derecha. Esto provoca que:",
    "opciones": [
      "A) El radio atómico aumente.",
      "B) El radio atómico disminuya.",
      "C) La energía de ionización disminuya.",
      "D) El elemento se vuelva más metálico."
    ],
    "respuesta_correcta": "B) El radio atómico disminuya.",
    "explicacion_detallada": "A medida que aumenta $Z_{ef}$, el núcleo atrae a los electrones de la capa de valencia con más fuerza y los acerca hacia sí mismo, causando una contracción o disminución en el tamaño del radio atómico."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "La masa atómica de un elemento que figura en la tabla periódica generalmente no es un número entero. Esto se debe a que:",
    "opciones": [
      "A) Los electrones tienen una masa despreciable.",
      "B) Los protones y neutrones no pesan exactamente 1 uma.",
      "C) Es el promedio ponderado de las masas de sus isótopos naturales.",
      "D) La energía de enlace altera la masa final."
    ],
    "respuesta_correcta": "C) Es el promedio ponderado de las masas de sus isótopos naturales.",
    "explicacion_detallada": "El valor de masa atómica reportado en la tabla periódica es la masa atómica relativa o promedio, que toma en cuenta la masa y la abundancia porcentual de cada isótopo presente en la naturaleza."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.3",
    "enunciado": "¿Qué bloque de la tabla periódica incluye a la serie de los lantánidos y actínidos?",
    "opciones": [
      "A) Bloque s.",
      "B) Bloque p.",
      "C) Bloque d.",
      "D) Bloque f."
    ],
    "respuesta_correcta": "D) Bloque f.",
    "explicacion_detallada": "Los lantánidos y actínidos conforman los elementos de transición interna y sus electrones diferenciadores (los últimos en llenarse) ocupan subniveles f, por lo que pertenecen al bloque f de la tabla periódica."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.4.3.');
}
