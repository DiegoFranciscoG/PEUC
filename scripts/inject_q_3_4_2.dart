import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "Según la teoría atómica de John Dalton, ¿cuál de los siguientes postulados es incorrecto a la luz de los conocimientos actuales?",
    "opciones": [
      "A) Los elementos están formados por partículas diminutas e indivisibles llamadas átomos.",
      "B) Los compuestos se forman por la unión de átomos de diferentes elementos en proporciones fijas.",
      "C) En una reacción química, los átomos se reorganizan, pero no se crean ni se destruyen.",
      "D) Los átomos de un mismo elemento reaccionan siempre de la misma forma."
    ],
    "respuesta_correcta": "A",
    "explicacion_detallada": "Dalton postuló que el átomo era indivisible, pero hoy sabemos que está compuesto por partículas subatómicas (protones, neutrones y electrones)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El modelo atómico de J.J. Thomson, conocido como 'budín de pasas', propuso que:",
    "opciones": [
      "A) El átomo tiene un núcleo pequeño, denso y con carga positiva.",
      "B) Los electrones se encuentran incrustados en una esfera de materia con carga positiva uniforme.",
      "C) Los electrones giran alrededor del núcleo en órbitas circulares cuantizadas.",
      "D) El átomo es en su mayor parte espacio vacío."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Thomson imaginó el átomo como una masa esférica cargada positivamente en la que se encontraban inmersos los electrones negativos, asemejándose a pasas en un budín."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El experimento de dispersión de partículas alfa en láminas de oro de Ernest Rutherford demostró fundamentalmente:",
    "opciones": [
      "A) La existencia de los isótopos.",
      "B) La naturaleza ondulatoria del electrón.",
      "C) La existencia de un núcleo atómico denso y positivo.",
      "D) La cuantización de los niveles de energía."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Al observar que unas pocas partículas alfa rebotaban en ángulos grandes, Rutherford dedujo que la carga positiva y la mayor parte de la masa del átomo se concentraban en un volumen ínfimo, el núcleo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "Una de las limitaciones más importantes del modelo atómico planetario de Rutherford desde el punto de vista de la física clásica era que:",
    "opciones": [
      "A) No explicaba la existencia de neutrones en el núcleo.",
      "B) Un electrón acelerado en órbita emitiría radiación, perdiendo energía y colapsando en el núcleo.",
      "C) No permitía calcular la masa del átomo con exactitud.",
      "D) Suponía que el núcleo tenía carga negativa."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Según las leyes del electromagnetismo clásico, una carga en movimiento acelerado (como un electrón orbitando) debe emitir energía radiante, por lo que el electrón acabaría cayendo en espiral hacia el núcleo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El modelo de Niels Bohr introdujo conceptos de la física cuántica para explicar el espectro de emisión del átomo de hidrógeno, postulando que:",
    "opciones": [
      "A) Los electrones pueden encontrarse en cualquier punto alrededor del núcleo.",
      "B) Los electrones se mueven en órbitas elípticas sin restricción de energía.",
      "C) Los electrones ocupan órbitas circulares estacionarias permitidas donde no emiten energía.",
      "D) El electrón es una onda estacionaria distribuida por todo el átomo."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Bohr postuló que los electrones orbitan el núcleo en niveles de energía discretos o cuantizados (órbitas estacionarias) y solo emiten o absorben energía al saltar entre estos niveles."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "La modificación introducida por Arnold Sommerfeld al modelo de Bohr consistió en:",
    "opciones": [
      "A) Sustituir el núcleo por una nube difusa de protones.",
      "B) Proponer que las órbitas del electrón también podrían ser elípticas, introduciendo el número cuántico azimutal.",
      "C) Afirmar que el electrón gira sobre su propio eje, introduciendo el espín.",
      "D) Formular la ecuación de onda del electrón."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Para explicar el desdoblamiento de líneas espectrales (efecto Stark/Zeeman relativo), Sommerfeld adaptó el modelo de Bohr permitiendo órbitas elípticas y definiendo el número cuántico l."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "¿Qué científico planteó el principio de dualidad onda-partícula, sugiriendo que el electrón tiene un comportamiento dual?",
    "opciones": [
      "A) Max Planck",
      "B) Albert Einstein",
      "C) Louis de Broglie",
      "D) Werner Heisenberg"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Louis de Broglie postuló en 1924 que toda partícula en movimiento, como el electrón, tiene una onda asociada, extendiendo la dualidad ya comprobada para los fotones de luz."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El Principio de Incertidumbre de Heisenberg establece que:",
    "opciones": [
      "A) Es imposible determinar de manera exacta la cantidad de energía de un electrón en un nivel dado.",
      "B) No se puede conocer simultáneamente y con precisión absoluta la posición y el momento (velocidad) de un electrón.",
      "C) Los electrones absorben energía en cantidades discontinuas llamadas cuantos.",
      "D) Es incierto predecir qué isótopo se formará en una reacción nuclear."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Heisenberg demostró matemáticamente que el acto de medir la posición de una partícula subatómica altera su momento, por lo que ambas variables no pueden determinarse a la vez con precisión infinita."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "En el modelo mecánico cuántico del átomo formulado por Erwin Schrödinger, los electrones se describen mediante:",
    "opciones": [
      "A) Trayectorias planetarias precisas.",
      "B) Esferas macizas cargadas negativamente.",
      "C) Funciones de onda matemáticas que definen orbitales o regiones de probabilidad.",
      "D) Puntos fijos inmutables en los vértices de figuras geométricas."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "La ecuación de Schrödinger reemplaza las órbitas definidas por orbitales atómicos, que representan las zonas del espacio donde hay una alta probabilidad matemática de encontrar al electrón."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El número cuántico principal ($n$) determina principalmente:",
    "opciones": [
      "A) La forma del orbital atómico.",
      "B) La orientación espacial del orbital en un campo magnético.",
      "C) El sentido de giro del electrón sobre su eje.",
      "D) El nivel de energía principal y la distancia media del electrón al núcleo."
    ],
    "respuesta_correcta": "D",
    "explicacion_detallada": "El número cuántico $n$ (1, 2, 3...) define la capa electrónica o nivel energético principal, relacionándose con el tamaño del orbital y la energía general del electrón."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El número cuántico secundario o azimutal ($l$) para un orbital tipo $p$ tiene el valor de:",
    "opciones": [
      "A) 0",
      "B) 1",
      "C) 2",
      "D) 3"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los valores de $l$ identifican el subnivel y la forma del orbital: $l=0$ (s), $l=1$ (p), $l=2$ (d), $l=3$ (f). Por tanto, para el subnivel p, $l=1$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "¿Qué número cuántico puede tomar valores desde $-l$ hasta $+l$ pasando por cero, e indica la orientación espacial del orbital?",
    "opciones": [
      "A) Número cuántico principal ($n$)",
      "B) Número cuántico secundario ($l$)",
      "C) Número cuántico magnético ($m_l$)",
      "D) Número cuántico de espín ($m_s$)"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "El número cuántico magnético $m_l$ define la orientación tridimensional del orbital bajo la influencia de un campo magnético externo."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El número cuántico de espín ($m_s$) hace referencia a:",
    "opciones": [
      "A) La rotación del electrón alrededor del núcleo atómico.",
      "B) El estado de energía intrínseco del núcleo.",
      "C) El giro o momento angular intrínseco del electrón, pudiendo ser $+1/2$ o $-1/2$.",
      "D) El número total de electrones que puede albergar un subnivel."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "El espín indica el sentido del momento magnético intrínseco del electrón, actuando como un pequeño imán que puede orientarse en dos sentidos opuestos (+1/2 o -1/2)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El Principio de Exclusión de Pauli dictamina que en un átomo polielectrónico:",
    "opciones": [
      "A) Los electrones se distribuyen buscando la máxima multiplicidad de espín.",
      "B) Ningún par de electrones puede tener los cuatro números cuánticos iguales.",
      "C) Los subniveles de menor energía se llenan antes que los de mayor energía.",
      "D) No pueden existir orbitales degenerados."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Wolfgang Pauli formuló que cada electrón en un átomo debe tener un estado cuántico único, lo que implica que en un mismo orbital solo caben dos electrones con espines opuestos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "Según la Regla de Hund o principio de máxima multiplicidad, al llenar orbitales de igual energía (degenerados) como los $p$ o $d$:",
    "opciones": [
      "A) Los electrones se aparean de inmediato en el primer orbital disponible.",
      "B) Los electrones deben entrar en pares con espines opuestos desde el inicio.",
      "C) Se acomoda un electrón en cada orbital antes de aparearlos, manteniendo espines paralelos.",
      "D) Se saltan electrones hacia niveles superiores para lograr estabilidad."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Para minimizar la repulsión electrostática, los electrones ocupan primero orbitales individuales dentro del mismo subnivel con espines paralelos antes de comenzar a formar pares."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "¿Qué científico comprobó experimentalmente la existencia del neutrón en 1932, completando la estructura básica del núcleo atómico?",
    "opciones": [
      "A) J.J. Thomson",
      "B) Ernest Rutherford",
      "C) James Chadwick",
      "D) Robert Millikan"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "James Chadwick descubrió una radiación neutra y penetrante emitida al bombardear berilio con partículas alfa, identificando así al neutrón, partícula nuclear sin carga y con masa similar a la del protón."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El experimento de la gota de aceite de Millikan permitió determinar experimentalmente:",
    "opciones": [
      "A) La masa del protón.",
      "B) La relación carga/masa del electrón.",
      "C) La carga eléctrica elemental del electrón.",
      "D) La constante de Planck."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Robert Millikan midió la velocidad de caída de pequeñas gotas de aceite cargadas en un campo eléctrico, logrando calcular el valor exacto de la carga del electrón ($1.6 \\times 10^{-19}$ C)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El efecto fotoeléctrico, explicado por Einstein utilizando la idea de cuantos de luz (fotones), demostró la naturaleza corpuscular de la luz y fue fundamental para:",
    "opciones": [
      "A) El desarrollo del modelo de Thomson.",
      "B) La aceptación de la cuantización de la energía en los modelos atómicos modernos.",
      "C) El descubrimiento de la radiactividad natural.",
      "D) Comprobar la existencia del núcleo atómico."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "El efecto fotoeléctrico validó la teoría cuántica de Planck, sentando las bases de la mecánica cuántica y de los modelos atómicos que dependen de la energía cuantizada, como el de Bohr."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "En la teoría atómica moderna, un 'orbital' se define estrictamente como:",
    "opciones": [
      "A) La trayectoria circular que describe un electrón alrededor del núcleo.",
      "B) Una región del espacio alrededor del núcleo donde la probabilidad de encontrar al electrón es alta (generalmente $>90\\%$).",
      "C) Un punto específico donde el electrón emite energía al estacionarse.",
      "D) El límite físico y definido del tamaño del átomo."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "En la mecánica cuántica, no se habla de trayectorias exactas, sino de densidades de probabilidad. El orbital es la representación matemática tridimensional de esa probabilidad volumétrica."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.2",
    "enunciado": "El Principio de Construcción o Aufbau establece el orden de llenado de los orbitales atómicos. Según este principio, un electrón ocupará el subnivel $4s$ antes que el $3d$ debido a que:",
    "opciones": [
      "A) El subnivel $4s$ tiene mayor energía relativa que el $3d$.",
      "B) El subnivel $4s$ tiene menor energía relativa que el $3d$.",
      "C) El número cuántico principal $n=4$ garantiza que se llene primero.",
      "D) Los orbitales s siempre son más energéticos que los d."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "El principio de Aufbau dice que los electrones ocupan primero los subniveles de menor energía. Aunque el nivel principal sea 4, el subnivel 4s requiere menos energía (es más estable) que el subnivel 3d, según la regla diagonal o regla de Madelung ($n+l$)."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label
    p['id'] = 'q_' + p['codigo_tema'].replaceAll('.', '_') + '_' + (i + 1).toString();
    // Normalizar la respuesta correcta, ya que el modelo la dio como A,B,C,D en lugar de la opción completa
    String letra = p['respuesta_correcta'].toString().replaceAll(')', '').trim();
    for (var op in p['opciones']) {
      if (op.startsWith(letra + ')')) {
        p['respuesta_correcta'] = op;
        break;
      }
    }
    preguntas.add(p);
  }
  
  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntas));
  print('20 preguntas inyectadas para el código 3.4.2.');
}
