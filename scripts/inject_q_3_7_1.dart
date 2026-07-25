import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Cómo se define la posición de un objeto en física?",
    "opciones": [
      "A) El lugar que ocupa un cuerpo en el espacio respecto a un sistema de referencia",
      "B) La distancia total recorrida por un cuerpo",
      "C) La velocidad con la que se mueve un objeto",
      "D) El camino que sigue un cuerpo durante su movimiento"
    ],
    "respuesta_correcta": "A) El lugar que ocupa un cuerpo en el espacio respecto a un sistema de referencia",
    "explicacion_detallada": "La posición es una magnitud vectorial que indica la localización de una partícula en el espacio, requiriendo siempre un sistema de referencia para ser definida adecuadamente."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Un estudiante camina 4 metros hacia el este y luego 3 metros hacia el norte. ¿Cuál es la magnitud de su desplazamiento?",
    "opciones": [
      "A) 7 m",
      "B) 5 m",
      "C) 1 m",
      "D) 12 m"
    ],
    "respuesta_correcta": "B) 5 m",
    "explicacion_detallada": "El desplazamiento es el vector desde la posición inicial a la final. Forman un triángulo rectángulo, por el teorema de Pitágoras: $\\sqrt{4^2 + 3^2} = \\sqrt{16 + 9} = \\sqrt{25} = 5$ m."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Qué magnitud escalar representa la longitud real del camino seguido por una partícula al moverse de una posición a otra?",
    "opciones": [
      "A) Desplazamiento",
      "B) Velocidad media",
      "C) Distancia recorrida",
      "D) Posición final"
    ],
    "respuesta_correcta": "C) Distancia recorrida",
    "explicacion_detallada": "La distancia recorrida es una magnitud escalar que mide la longitud total de la trayectoria descrita por el cuerpo, a diferencia del desplazamiento que es vectorial."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Una pelota es lanzada verticalmente hacia arriba. Alcanza una altura de 10 m y vuelve a caer a las manos de quien la lanzó. ¿Cuál es su desplazamiento total?",
    "opciones": [
      "A) 20 m",
      "B) 10 m",
      "C) 0 m",
      "D) -10 m"
    ],
    "respuesta_correcta": "C) 0 m",
    "explicacion_detallada": "El desplazamiento es la diferencia entre la posición final y la inicial. Como la pelota regresa al mismo punto de partida, su desplazamiento neto es cero, aunque haya recorrido una distancia de 20 m."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Qué nombre recibe el conjunto de todos los puntos del espacio que ocupa un cuerpo a medida que transcurre el tiempo?",
    "opciones": [
      "A) Trayectoria",
      "B) Desplazamiento",
      "C) Vector de posición",
      "D) Sistema de coordenadas"
    ],
    "respuesta_correcta": "A) Trayectoria",
    "explicacion_detallada": "La trayectoria es la línea imaginaria o curva geométrica descrita por los puntos por los que pasa un objeto en su movimiento."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "En un gráfico de posición en función del tiempo ($x$ vs $t$) para un movimiento rectilíneo uniforme, ¿qué representa la pendiente de la recta?",
    "opciones": [
      "A) La aceleración",
      "B) La distancia",
      "C) El desplazamiento",
      "D) La velocidad"
    ],
    "respuesta_correcta": "D) La velocidad",
    "explicacion_detallada": "En un gráfico $x-t$, la pendiente es la razón de cambio de la posición respecto al tiempo, lo cual corresponde a la velocidad del objeto."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Un automóvil se mueve en línea recta desde la posición $x_i = -5$ m hasta la posición $x_f = 15$ m. ¿Cuál fue su desplazamiento?",
    "opciones": [
      "A) 10 m",
      "B) 20 m",
      "C) -20 m",
      "D) 15 m"
    ],
    "respuesta_correcta": "B) 20 m",
    "explicacion_detallada": "El desplazamiento se calcula como $\\Delta x = x_f - x_i = 15 - (-5) = 15 + 5 = 20$ m."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Cuál de las siguientes afirmaciones sobre el desplazamiento es correcta?",
    "opciones": [
      "A) Es siempre mayor o igual a la distancia recorrida",
      "B) Depende exclusivamente del punto inicial y final, no de la trayectoria",
      "C) Es una magnitud escalar",
      "D) Nunca puede ser negativo"
    ],
    "respuesta_correcta": "B) Depende exclusivamente del punto inicial y final, no de la trayectoria",
    "explicacion_detallada": "El desplazamiento es un vector que une la posición inicial con la final. Su valor no depende del camino que haya tomado el objeto para ir de un punto a otro."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Si una partícula está en reposo, ¿cómo es su gráfica de posición vs tiempo ($x$ vs $t$)?",
    "opciones": [
      "A) Una recta inclinada con pendiente positiva",
      "B) Una curva parabólica",
      "C) Una recta horizontal paralela al eje del tiempo",
      "D) Una recta vertical paralela al eje de posición"
    ],
    "respuesta_correcta": "C) Una recta horizontal paralela al eje del tiempo",
    "explicacion_detallada": "Al estar en reposo, la posición no cambia conforme avanza el tiempo, por lo que la gráfica es una constante (una recta horizontal)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Cuál es la unidad del vector de posición en el Sistema Internacional (SI)?",
    "opciones": [
      "A) Metro por segundo ($m/s$)",
      "B) Segundo ($s$)",
      "C) Metro ($m$)",
      "D) Grados sexagesimales ($^\\circ$)"
    ],
    "respuesta_correcta": "C) Metro ($m$)",
    "explicacion_detallada": "La posición indica una distancia direccional respecto a un origen, y la unidad fundamental de longitud en el SI es el metro ($m$)."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Qué magnitud se define como el cociente entre el desplazamiento total y el intervalo de tiempo empleado?",
    "opciones": [
      "A) Rapidez media",
      "B) Aceleración media",
      "C) Velocidad instantánea",
      "D) Velocidad media"
    ],
    "respuesta_correcta": "D) Velocidad media",
    "explicacion_detallada": "La velocidad media es un vector que relaciona el cambio de posición (desplazamiento) con el tiempo, $\\vec{v}_m = \\frac{\\Delta \\vec{r}}{\\Delta t}$."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Un corredor da 2 vueltas completas a una pista circular de 400 m de circunferencia. ¿Cuál es su distancia recorrida y su desplazamiento, respectivamente?",
    "opciones": [
      "A) 800 m, 800 m",
      "B) 0 m, 800 m",
      "C) 800 m, 0 m",
      "D) 400 m, 0 m"
    ],
    "respuesta_correcta": "C) 800 m, 0 m",
    "explicacion_detallada": "La distancia recorrida es la suma de las vueltas ($400 \\times 2 = 800$ m). Como termina en el mismo punto donde empezó, el desplazamiento neto es cero."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Dos observadores, uno en un tren en movimiento y otro en el andén, registran la posición de un pasajero caminando por el pasillo del tren. Sus mediciones serán distintas porque:",
    "opciones": [
      "A) La posición depende de la masa del pasajero",
      "B) La posición es relativa al sistema de referencia elegido",
      "C) El tiempo transcurre de forma diferente para ambos",
      "D) La velocidad del pasajero anula la velocidad del tren"
    ],
    "respuesta_correcta": "B) La posición es relativa al sistema de referencia elegido",
    "explicacion_detallada": "La posición y el movimiento siempre son relativos al marco de referencia. Un observador interno y uno externo miden coordenadas diferentes para el mismo evento."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "En un movimiento rectilíneo en una dimensión, si el desplazamiento es negativo ($\\Delta x < 0$), significa que:",
    "opciones": [
      "A) El objeto ha frenado",
      "B) El objeto se ha movido en el sentido negativo del eje de coordenadas",
      "C) La distancia recorrida es negativa",
      "D) El objeto está retrocediendo en el tiempo"
    ],
    "respuesta_correcta": "B) El objeto se ha movido en el sentido negativo del eje de coordenadas",
    "explicacion_detallada": "Un desplazamiento negativo indica que la posición final es menor que la inicial, por tanto el objeto se movió hacia el lado negativo del eje."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Cómo se llama el punto del espacio en el cual un sistema de coordenadas tiene valores nulos ($0,0,0$) y desde el cual se miden las posiciones?",
    "opciones": [
      "A) Foco",
      "B) Baricentro",
      "C) Origen de coordenadas",
      "D) Centro de masa"
    ],
    "respuesta_correcta": "C) Origen de coordenadas",
    "explicacion_detallada": "El origen de coordenadas es el punto de referencia indispensable para definir el vector de posición de cualquier otro punto."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Un móvil parte de la posición $x = 10$ m, va hasta $x = 30$ m y luego retrocede hasta $x = 20$ m. ¿Cuál es su desplazamiento final respecto al inicio?",
    "opciones": [
      "A) 40 m",
      "B) 10 m",
      "C) 20 m",
      "D) -10 m"
    ],
    "respuesta_correcta": "B) 10 m",
    "explicacion_detallada": "El desplazamiento solo evalúa la posición inicial y final: $\\Delta x = x_f - x_i = 20 - 10 = 10$ m. La trayectoria intermedia no importa."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Qué magnitud cinemática se obtiene al derivar la función de la posición respecto al tiempo ($d\\vec{r}/dt$)?",
    "opciones": [
      "A) Aceleración instantánea",
      "B) Desplazamiento neto",
      "C) Rapidez media",
      "D) Velocidad instantánea"
    ],
    "respuesta_correcta": "D) Velocidad instantánea",
    "explicacion_detallada": "Por definición en cálculo, la derivada del vector posición con respecto al tiempo es la velocidad instantánea del objeto."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "Si el vector de posición inicial de una partícula es $\\vec{r}_i = (2\\hat{i} + 3\\hat{j})$ m y su posición final es $\\vec{r}_f = (5\\hat{i} + 7\\hat{j})$ m, ¿cuál es su vector desplazamiento?",
    "opciones": [
      "A) $(7\\hat{i} + 10\\hat{j})$ m",
      "B) $(3\\hat{i} + 4\\hat{j})$ m",
      "C) $(-3\\hat{i} - 4\\hat{j})$ m",
      "D) $(10\\hat{i} + 21\\hat{j})$ m"
    ],
    "respuesta_correcta": "B) $(3\\hat{i} + 4\\hat{j})$ m",
    "explicacion_detallada": "Se resta componente a componente: $\\Delta \\vec{r} = \\vec{r}_f - \\vec{r}_i = (5-2)\\hat{i} + (7-3)\\hat{j} = (3\\hat{i} + 4\\hat{j})$ m."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "¿Es posible que la magnitud del desplazamiento de un objeto sea mayor que la distancia que ha recorrido?",
    "opciones": [
      "A) Sí, si el movimiento ocurre en una línea recta y hacia atrás",
      "B) Sí, si la trayectoria es un círculo completo",
      "C) No, el desplazamiento siempre es igual o menor a la distancia recorrida",
      "D) No, el desplazamiento siempre es idéntico a la distancia"
    ],
    "respuesta_correcta": "C) No, el desplazamiento siempre es igual o menor a la distancia recorrida",
    "explicacion_detallada": "La distancia recorrida suma la longitud total de la trayectoria. En el mejor de los casos (movimiento rectilíneo en un solo sentido), el módulo del desplazamiento iguala a la distancia. En los demás casos, es menor por ser la línea recta más corta entre ambos puntos."
  },
  {
    "materia": "Física",
    "codigo_tema": "3.7.1",
    "enunciado": "El modelo de 'partícula' en cinemática asume que el objeto en estudio:",
    "opciones": [
      "A) Carece de masa",
      "B) Solo se mueve en el vacío",
      "C) Tiene sus dimensiones espaciales despreciables respecto al movimiento",
      "D) No está sujeto a las leyes de Newton"
    ],
    "respuesta_correcta": "C) Tiene sus dimensiones espaciales despreciables respecto al movimiento",
    "explicacion_detallada": "En cinemática de la partícula, se abstrae la forma y tamaño del cuerpo, considerándolo como un punto matemático que concentra toda su masa, para simplificar el estudio de su traslación."
  }
]''';

  List<dynamic> parsed = jsonDecode(jsonIn);
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  
  for (int i = 0; i < parsed.length; i++) {
    var p = parsed[i];
    p['materia'] = 'Ciencias Naturales'; // Forcing the official matrix label for physics which falls under natural sciences in the json
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
  print('20 preguntas inyectadas para el código 3.7.1.');
}
