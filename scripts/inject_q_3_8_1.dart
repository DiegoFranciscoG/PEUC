import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> nuevasPreguntas = [
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "La primera ley de la termodinámica es una aplicación de un principio fundamental de conservación de la física. ¿A qué principio se refiere?",
      "opciones": [
        "A) Conservación de la masa",
        "B) Conservación de la cantidad de movimiento",
        "C) Conservación de la energía",
        "D) Conservación de la carga eléctrica"
      ],
      "respuesta_correcta": "C) Conservación de la energía",
      "explicacion_detallada": "La primera ley de la termodinámica establece que la energía no se crea ni se destruye, solo se transforma, relacionando el calor transferido, el trabajo realizado y la variación de energía interna."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Si a un sistema termodinámico se le suministran \$200 J\$ de calor y este realiza un trabajo de \$50 J\$ sobre su entorno, ¿cuál es el cambio en su energía interna según la primera ley de la termodinámica?",
      "opciones": [
        "A) \$150 J\$",
        "B) \$250 J\$",
        "C) \$-150 J\$",
        "D) \$10000 J\$"
      ],
      "respuesta_correcta": "A) \$150 J\$",
      "explicacion_detallada": "Según la primera ley, \$\\Delta U = Q - W\$. Si \$Q = 200 J\$ (entra al sistema) y \$W = 50 J\$ (lo hace el sistema), entonces \$\\Delta U = 200 J - 50 J = 150 J\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "En un proceso termodinámico, el gas se expanda sin que haya transferencia de calor con el entorno. ¿Cómo se denomina este tipo de proceso?",
      "opciones": [
        "A) Isotérmico",
        "B) Isocórico",
        "C) Isobárico",
        "D) Adiabático"
      ],
      "respuesta_correcta": "D) Adiabático",
      "explicacion_detallada": "Un proceso adiabático es aquel en el que el sistema no intercambia calor con su entorno (\$Q = 0\$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "¿Qué magnitud física, asociada a la segunda ley de la termodinámica, mide el grado de desorden o aleatoriedad de un sistema aislado?",
      "opciones": [
        "A) Entalpía",
        "B) Energía interna",
        "C) Entropía",
        "D) Temperatura"
      ],
      "respuesta_correcta": "C) Entropía",
      "explicacion_detallada": "La entropía (\$S\$) es una medida del desorden de un sistema a nivel molecular. La segunda ley establece que la entropía de un sistema aislado siempre tiende a aumentar."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Según el enunciado de Clausius de la segunda ley de la termodinámica, ¿cuál de los siguientes procesos es imposible que ocurra de forma espontánea?",
      "opciones": [
        "A) Que el calor fluya de un cuerpo caliente a uno frío.",
        "B) Que el calor fluya de un cuerpo frío a uno caliente.",
        "C) Que un gas se expanda ocupando todo el volumen disponible.",
        "D) Que toda la energía mecánica se transforme en calor."
      ],
      "respuesta_correcta": "B) Que el calor fluya de un cuerpo frío a uno caliente.",
      "explicacion_detallada": "El enunciado de Clausius indica que es imposible construir un dispositivo que opere en un ciclo sin producir ningún otro efecto que la transferencia de calor de un cuerpo de menor temperatura a uno de mayor temperatura sin aporte de trabajo externo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Para un gas ideal que experimenta un proceso isotérmico (temperatura constante), ¿qué ocurre con su energía interna?",
      "opciones": [
        "A) Aumenta proporcionalmente al volumen.",
        "B) Disminuye al aumentar la presión.",
        "C) Permanece constante.",
        "D) Depende del calor específico a presión constante."
      ],
      "respuesta_correcta": "C) Permanece constante.",
      "explicacion_detallada": "La energía interna de un gas ideal depende únicamente de su temperatura. Si el proceso es isotérmico, \$\\Delta T = 0\$, por lo que su variación de energía interna es cero (\$\\Delta U = 0\$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Una máquina térmica absorbe \$1000 J\$ de calor de una fuente caliente y realiza un trabajo útil de \$300 J\$. ¿Cuál es la eficiencia o rendimiento térmico de esta máquina?",
      "opciones": [
        "A) 30%",
        "B) 70%",
        "C) 33.3%",
        "D) 100%"
      ],
      "respuesta_correcta": "A) 30%",
      "explicacion_detallada": "La eficiencia se define como el trabajo realizado dividido por el calor absorbido: \$e = W / Q_{in} = 300 J / 1000 J = 0.30\$, es decir, el 30%."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "El enunciado de Kelvin-Planck de la segunda ley de la termodinámica establece una limitación fundamental sobre las máquinas térmicas. ¿Cuál es esta limitación?",
      "opciones": [
        "A) Ninguna máquina puede funcionar en un ciclo reversible.",
        "B) Ninguna máquina térmica puede tener una eficiencia del 100%.",
        "C) Todo el calor absorbido puede transformarse íntegramente en trabajo.",
        "D) Las máquinas térmicas solo pueden funcionar con gases ideales."
      ],
      "respuesta_correcta": "B) Ninguna máquina térmica puede tener una eficiencia del 100%.",
      "explicacion_detallada": "El enunciado de Kelvin-Planck afirma que es imposible construir una máquina que, operando en un ciclo, convierta todo el calor absorbido de una fuente íntegramente en trabajo. Siempre habrá calor de desecho."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Durante un proceso isocórico, un gas absorbe calor. Dado que el volumen permanece constante, ¿qué sucede con el trabajo realizado por el gas?",
      "opciones": [
        "A) Es igual al calor absorbido.",
        "B) Es negativo.",
        "C) Es cero.",
        "D) Es igual al cambio de presión."
      ],
      "respuesta_correcta": "C) Es cero.",
      "explicacion_detallada": "El trabajo mecánico termodinámico para un gas se expresa como \$W = P \\Delta V\$. Al ser un proceso isocórico, el volumen no cambia (\$\\Delta V = 0\$), por tanto, el trabajo es nulo (\$W = 0\$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Calcula el rendimiento máximo teórico (eficiencia de Carnot) de una máquina que opera entre dos depósitos térmicos a \$600 K\$ y \$300 K\$.",
      "opciones": [
        "A) 25%",
        "B) 50%",
        "C) 75%",
        "D) 100%"
      ],
      "respuesta_correcta": "B) 50%",
      "explicacion_detallada": "El rendimiento de una máquina ideal de Carnot es \$e = 1 - (T_{frio} / T_{caliente})\$. Reemplazando: \$e = 1 - (300 K / 600 K) = 1 - 0.5 = 0.50\$, equivalente al 50%."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "¿Qué sucede con la energía total del universo en cualquier proceso termodinámico real?",
      "opciones": [
        "A) Se conserva, pero su entropía disminuye.",
        "B) Disminuye mientras su entropía aumenta.",
        "C) Se conserva y su entropía total aumenta.",
        "D) Se conserva y su entropía permanece constante."
      ],
      "respuesta_correcta": "C) Se conserva y su entropía total aumenta.",
      "explicacion_detallada": "La primera ley establece que la energía del universo se conserva. La segunda ley dictamina que, en procesos reales e irreversibles, la entropía neta (o desorden) del universo siempre aumenta."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Un sistema termodinámico realiza un ciclo termodinámico completo, regresando exactamente a su estado de equilibrio inicial. ¿Cuánto vale el cambio en su energía interna (\$\\Delta U\$) tras un ciclo?",
      "opciones": [
        "A) Depende del camino recorrido.",
        "B) Es igual al calor neto absorbido.",
        "C) Cero.",
        "D) Es infinito."
      ],
      "respuesta_correcta": "C) Cero.",
      "explicacion_detallada": "La energía interna es una función de estado. Al completar un ciclo y volver a las mismas variables iniciales (P, V, T), la variación total de la energía interna es nula (\$\\Delta U = 0\$)."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "En un proceso isobárico a una presión constante de \$1 \\times 10^5 Pa\$, un gas se expande de \$2 m^3\$ a \$5 m^3\$. ¿Cuál es el trabajo termodinámico realizado por el gas?",
      "opciones": [
        "A) \$3 \\times 10^5 J\$",
        "B) \$5 \\times 10^5 J\$",
        "C) \$2 \\times 10^5 J\$",
        "D) \$7 \\times 10^5 J\$"
      ],
      "respuesta_correcta": "A) \$3 \\times 10^5 J\$",
      "explicacion_detallada": "El trabajo en un proceso isobárico es \$W = P \\cdot \\Delta V\$. Sustituyendo: \$W = 10^5 Pa \\cdot (5 m^3 - 2 m^3) = 10^5 \\cdot 3 m^3 = 3 \\times 10^5 J\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "¿Cómo se calcula matemáticamente la variación de entropía (\$\\Delta S\$) para un proceso isotérmico reversible donde se intercambia una cantidad de calor \$Q\$ a una temperatura absoluta constante \$T\$?",
      "opciones": [
        "A) \$\\Delta S = Q \\cdot T\$",
        "B) \$\\Delta S = Q / T\$",
        "C) \$\\Delta S = T / Q\$",
        "D) \$\\Delta S = Q + T\$"
      ],
      "respuesta_correcta": "B) \$\\Delta S = Q / T\$",
      "explicacion_detallada": "Clausius definió el cambio macroscópico de la entropía para procesos reversibles isotérmicos como el cociente entre el calor transferido y la temperatura absoluta a la cual ocurre la transferencia: \$\\Delta S = \\frac{Q}{T}\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Una máquina frigorífica (como un refrigerador doméstico) transfiere calor de un foco frío al ambiente más cálido. Para no violar la segunda ley de la termodinámica, ¿qué es estrictamente necesario?",
      "opciones": [
        "A) Que el proceso sea totalmente reversible.",
        "B) Que el gas ideal dentro no cambie su energía interna.",
        "C) Que se suministre trabajo mecánico desde el exterior.",
        "D) Que el interior alcance el cero absoluto de temperatura."
      ],
      "respuesta_correcta": "C) Que se suministre trabajo mecánico desde el exterior.",
      "explicacion_detallada": "Para bombear calor en dirección opuesta a su flujo natural (de frío a calor), se requiere aportar energía desde el exterior, usualmente mediante un motor eléctrico que realiza trabajo."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Se comprime un gas en un cilindro completamente aislado del exterior. Si se realiza un trabajo de \$150 J\$ sobre el gas, ¿cuál es el cambio de su energía interna?",
      "opciones": [
        "A) Disminuye \$150 J\$",
        "B) Aumenta \$150 J\$",
        "C) No sufre cambios, es \$0 J\$",
        "D) Aumenta \$300 J\$"
      ],
      "respuesta_correcta": "B) Aumenta \$150 J\$",
      "explicacion_detallada": "Al estar el cilindro aislado, el proceso es adiabático (\$Q = 0\$). La primera ley nos dice \$\\Delta U = Q - W\$. Si el entorno hace trabajo sobre el sistema, este W es negativo (\$\\Delta U = -(-150 J)\$), provocando que la energía interna y la temperatura del gas aumenten en \$150 J\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "¿Cuál es la propiedad de una sustancia definida como la cantidad de calor necesaria para elevar en un grado Celsius (o Kelvin) la temperatura de una unidad de masa de dicha sustancia?",
      "opciones": [
        "A) Calor latente",
        "B) Capacidad calorífica molar",
        "C) Calor específico",
        "D) Conductividad térmica"
      ],
      "respuesta_correcta": "C) Calor específico",
      "explicacion_detallada": "El calor específico (también llamado capacidad calorífica específica) relaciona el calor absorbido o liberado con la masa del objeto y su cambio de temperatura a través de la fórmula \$Q = m \\cdot c \\cdot \\Delta T\$."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "Durante la ebullición del agua pura (cambio de fase líquido a vapor) a una presión constante de \$1 atm\$, se le sigue aportando energía en forma de calor. ¿Qué sucede con la temperatura del sistema durante este proceso?",
      "opciones": [
        "A) Aumenta continuamente hasta evaporarse toda el agua.",
        "B) Disminuye por la absorción del calor latente.",
        "C) Permanece constante a \$100 ^\\circ C\$ hasta completarse el cambio de fase.",
        "D) Depende del volumen inicial del agua."
      ],
      "respuesta_correcta": "C) Permanece constante a \$100 ^\\circ C\$ hasta completarse el cambio de fase.",
      "explicacion_detallada": "En los cambios de fase, toda la energía añadida (calor latente) se invierte en romper las fuerzas intermoleculares del líquido para convertirlo en gas, manteniendo la temperatura invariable durante la transición."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "El experimento de James Prescott Joule sobre el equivalente mecánico del calor demostró experimentalmente que:",
      "opciones": [
        "A) El trabajo mecánico no puede transformarse íntegramente en calor.",
        "B) Una caloría equivale de forma exacta y constante a \$4.186 Joules\$.",
        "C) La entropía de un sistema siempre es positiva.",
        "D) El calor solo se transfiere entre gases ideales."
      ],
      "respuesta_correcta": "B) Una caloría equivale de forma exacta y constante a \$4.186 Joules\$.",
      "explicacion_detallada": "Joule demostró que el trabajo (medido en Joules) y el calor (medido en calorías) son formas equivalentes de energía, encontrando el factor de conversión llamado equivalente mecánico del calor."
    },
    {
      "materia": "Ciencias Naturales",
      "codigo_tema": "3.8.1",
      "enunciado": "En la representación gráfica del diagrama Presión-Volumen (P-V) de un ciclo termodinámico, ¿qué información proporciona el área encerrada dentro de la curva cerrada del ciclo?",
      "opciones": [
        "A) La variación de la energía interna neta.",
        "B) El calor total emitido al sumidero térmico.",
        "C) El trabajo neto realizado por o sobre el gas durante un ciclo.",
        "D) La temperatura media del proceso reversible."
      ],
      "respuesta_correcta": "C) El trabajo neto realizado por o sobre el gas durante un ciclo.",
      "explicacion_detallada": "En un diagrama P-V, el área contenida dentro del ciclo termodinámico equivale, de forma numérica y dimensional, al trabajo neto intercambiado entre el sistema y su entorno por cada ciclo."
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
  print('20 preguntas inyectadas para el código 3.8.1 mediante Dart List.');
}
