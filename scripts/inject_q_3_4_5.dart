import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué tipo de enlace se forma principalmente por la transferencia de electrones entre un átomo metálico y uno no metálico?",
    "opciones": [
      "A) Covalente polar",
      "B) Iónico",
      "C) Metálico",
      "D) Covalente apolar"
    ],
    "respuesta_correcta": "B) Iónico",
    "explicacion_detallada": "En la formación de compuestos iónicos, ocurre una transferencia completa de uno o más electrones desde el metal (menos electronegativo) hacia el no metal (más electronegativo), formando cationes y aniones que se atraen electrostáticamente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Cuál es la condición fundamental para que se forme un enlace covalente polar entre dos átomos?",
    "opciones": [
      "A) Que ambos sean metales de transición.",
      "B) Que la diferencia de electronegatividad sea igual a cero.",
      "C) Que exista una diferencia de electronegatividad mayor a cero y generalmente menor a 1.7.",
      "D) Que un átomo ceda todos sus electrones de valencia."
    ],
    "respuesta_correcta": "C) Que exista una diferencia de electronegatividad mayor a cero y generalmente menor a 1.7.",
    "explicacion_detallada": "El enlace covalente polar se forma cuando dos átomos comparten electrones de manera desigual debido a una diferencia de electronegatividad significativa, pero no lo suficientemente grande como para transferir los electrones por completo (generalmente entre 0.4 y 1.7)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "Al reaccionar el oxígeno molecular ($O_2$) con un metal alcalino, ¿qué tipo principal de compuesto se forma?",
    "opciones": [
      "A) Un óxido ácido",
      "B) Un peróxido orgánico",
      "C) Un hidruro metálico",
      "D) Un óxido básico"
    ],
    "respuesta_correcta": "D) Un óxido básico",
    "explicacion_detallada": "La combinación de un elemento metálico (como los alcalinos) con oxígeno forma un óxido básico, que al reaccionar con agua formará un hidróxido o base."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué compuesto químico se forma cuando reacciona el trióxido de azufre ($SO_3$) con agua ($H_2O$)?",
    "opciones": [
      "A) Ácido sulfuroso ($H_2SO_3$)",
      "B) Sulfuro de hidrógeno ($H_2S$)",
      "C) Ácido sulfúrico ($H_2SO_4$)",
      "D) Hidróxido de azufre ($S(OH)_6$)"
    ],
    "respuesta_correcta": "C) Ácido sulfúrico ($H_2SO_4$)",
    "explicacion_detallada": "El $SO_3$ es un anhídrido u óxido ácido. Al reaccionar con agua, se hidrata formando el ácido oxácido correspondiente, en este caso, el ácido sulfúrico ($H_2SO_4$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "Según la regla del octeto, los átomos tienden a ganar, perder o compartir electrones para adquirir la configuración electrónica de:",
    "opciones": [
      "A) El halógeno más cercano.",
      "B) Un gas noble.",
      "C) El hidrógeno.",
      "D) Un metal alcalinotérreo."
    ],
    "respuesta_correcta": "B) Un gas noble.",
    "explicacion_detallada": "La regla del octeto establece que los átomos se enlazan para completar ocho electrones en su capa de valencia, alcanzando así la estabilidad y configuración electrónica isoelectrónica del gas noble más cercano en la tabla periódica."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "En la formación del cloruro de sodio ($NaCl$), el átomo de sodio pierde un electrón. ¿Qué carga adquiere el ion formado?",
    "opciones": [
      "A) -1",
      "B) 0",
      "C) +2",
      "D) +1"
    ],
    "respuesta_correcta": "D) +1",
    "explicacion_detallada": "Al perder su único electrón de valencia, el sodio ($Na$) queda con más protones (11) que electrones (10), formando el catión sodio con una carga neta de +1 ($Na^+$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "Un enlace químico donde los electrones de valencia se deslocalizan formando un 'mar de electrones' alrededor de una red de cationes, corresponde a la formación de un:",
    "opciones": [
      "A) Compuesto iónico.",
      "B) Compuesto metálico.",
      "C) Compuesto covalente polar.",
      "D) Compuesto covalente coordinado."
    ],
    "respuesta_correcta": "B) Compuesto metálico.",
    "explicacion_detallada": "El enlace metálico se explica mediante el modelo del mar de electrones, donde los electrones de valencia se mueven libremente por toda la red de iones positivos, dándole a los metales sus propiedades conductoras."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué sucede con la energía potencial del sistema cuando dos átomos aislados se aproximan y forman un enlace químico estable?",
    "opciones": [
      "A) Aumenta al máximo.",
      "B) Se mantiene constante.",
      "C) Disminuye, alcanzando un mínimo.",
      "D) Se vuelve cero inmediatamente."
    ],
    "respuesta_correcta": "C) Disminuye, alcanzando un mínimo.",
    "explicacion_detallada": "La formación de un enlace químico es un proceso exotérmico; la energía potencial del sistema disminuye a medida que los átomos se atraen, alcanzando un mínimo que corresponde a la distancia de enlace óptima y de mayor estabilidad."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "El amoníaco ($NH_3$) reacciona con el protón ($H^+$) para formar el ion amonio ($NH_4^+$). El nuevo enlace N-H formado se clasifica como:",
    "opciones": [
      "A) Iónico",
      "B) Covalente dativo o coordinado",
      "C) Metálico",
      "D) Puente de hidrógeno"
    ],
    "respuesta_correcta": "B) Covalente dativo o coordinado",
    "explicacion_detallada": "En la formación del ion amonio, el átomo de nitrógeno aporta el par de electrones libre completo para formar el enlace con el ion hidrógeno ($H^+$), el cual no tiene electrones, constituyendo un enlace covalente coordinado."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "Al combinar un metal del grupo 2 (alcalinotérreo) con un halógeno del grupo 17, se forma típicamente una sal con fórmula general:",
    "opciones": [
      "A) $MX$",
      "B) $M_2X$",
      "C) $MX_2$",
      "D) $MX_3$"
    ],
    "respuesta_correcta": "C) $MX_2$",
    "explicacion_detallada": "Los alcalinotérreos (M) tienen estado de oxidación +2, y los halógenos (X) en sales binarias tienen estado de oxidación -1. Para que el compuesto sea neutro, se necesitan dos átomos de halógeno por cada átomo del metal, resultando en $MX_2$."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué molécula presenta un enlace covalente triple en su estructura para cumplir con la regla del octeto?",
    "opciones": [
      "A) $O_2$",
      "B) $N_2$",
      "C) $F_2$",
      "D) $Cl_2$"
    ],
    "respuesta_correcta": "B) $N_2$",
    "explicacion_detallada": "El nitrógeno pertenece al grupo 15, con 5 electrones de valencia. Para completar el octeto, dos átomos de nitrógeno comparten tres pares de electrones, formando un triple enlace ($N \\equiv N$)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "La reacción entre un ácido y una base para formar una sal y agua se conoce en química como reacción de:",
    "opciones": [
      "A) Combustión",
      "B) Neutralización",
      "C) Síntesis directa",
      "D) Descomposición"
    ],
    "respuesta_correcta": "B) Neutralización",
    "explicacion_detallada": "La neutralización es la reacción química en la que un ácido y una base reaccionan cuantitativamente entre sí, produciendo generalmente sal y agua, neutralizando sus propiedades respectivas."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué indica la electronegatividad de un elemento en el contexto de la formación de compuestos?",
    "opciones": [
      "A) Su capacidad para liberar protones en solución.",
      "B) La energía necesaria para arrancarle un electrón.",
      "C) La tendencia del átomo a atraer electrones hacia sí en un enlace químico.",
      "D) Su volumen atómico relativo."
    ],
    "respuesta_correcta": "C) La tendencia del átomo a atraer electrones hacia sí en un enlace químico.",
    "explicacion_detallada": "La electronegatividad es una medida de la fuerza con la que un átomo atrae hacia sí mismo el par de electrones compartidos en un enlace covalente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "En la molécula de dióxido de carbono ($CO_2$), los enlaces carbono-oxígeno son polares, sin embargo, la molécula es apolar. ¿A qué se debe esto?",
    "opciones": [
      "A) A la geometría lineal de la molécula que cancela los momentos dipolares.",
      "B) A que el oxígeno y el carbono tienen la misma electronegatividad.",
      "C) A que los electrones no se comparten, sino que se transfieren.",
      "D) A la presencia de enlaces de hidrógeno entre moléculas."
    ],
    "respuesta_correcta": "A) A la geometría lineal de la molécula que cancela los momentos dipolares.",
    "explicacion_detallada": "El $CO_2$ es una molécula lineal (O=C=O). Aunque cada enlace C=O es polar, al estar opuestos 180 grados, los momentos dipolares individuales (vectores) se anulan, dando un momento dipolar neto igual a cero."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "En la formación del compuesto $FeCl_3$, ¿cuál es el estado de oxidación con el que actúa el hierro?",
    "opciones": [
      "A) +1",
      "B) +2",
      "C) +3",
      "D) -3"
    ],
    "respuesta_correcta": "C) +3",
    "explicacion_detallada": "El cloro en cloruros simples actúa con número de oxidación -1. Como hay tres átomos de cloro (-3 en total), el hierro debe tener un estado de oxidación de +3 para que el compuesto sea eléctricamente neutro."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Cómo se llama el proceso de formación de un compuesto complejo donde los átomos se combinan a partir de sustancias elementales?",
    "opciones": [
      "A) Reacción de simple sustitución",
      "B) Reacción de descomposición",
      "C) Reacción de síntesis o combinación",
      "D) Reacción de doble desplazamiento"
    ],
    "respuesta_correcta": "C) Reacción de síntesis o combinación",
    "explicacion_detallada": "En una reacción de síntesis, dos o más reactivos simples se combinan para formar un producto químico más complejo (Ej: A + B -> AB)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "Al formarse el compuesto hidruro de litio ($LiH$), el hidrógeno actúa excepcionalmente con estado de oxidación:",
    "opciones": [
      "A) +1",
      "B) -1",
      "C) 0",
      "D) +2"
    ],
    "respuesta_correcta": "B) -1",
    "explicacion_detallada": "Al reaccionar con metales (como el Litio) para formar hidruros metálicos, el hidrógeno es más electronegativo que el metal, por lo que gana un electrón y actúa con estado de oxidación -1."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Cuál de los siguientes compuestos químicos covalentes presenta estructura piramidal trigonal?",
    "opciones": [
      "A) Metano ($CH_4$)",
      "B) Amoníaco ($NH_3$)",
      "C) Agua ($H_2O$)",
      "D) Trifluoruro de boro ($BF_3$)"
    ],
    "respuesta_correcta": "B) Amoníaco ($NH_3$)",
    "explicacion_detallada": "El amoníaco tiene un átomo central (N) con tres pares enlazantes y un par de electrones solitarios, lo que genera una repulsión que empuja los enlaces hacia abajo, formando una geometría molecular piramidal trigonal."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "La estructura cristalina del cloruro de potasio ($KCl$) se mantiene fuertemente unida gracias a la:",
    "opciones": [
      "A) Fuerza de dispersión de London.",
      "B) Atracción iónica directa, medida por la energía reticular.",
      "C) Tensión superficial de la celda unitaria.",
      "D) Fuerza de Van der Waals dipolar."
    ],
    "respuesta_correcta": "B) Atracción iónica directa, medida por la energía reticular.",
    "explicacion_detallada": "Los compuestos iónicos en estado sólido forman redes cristalinas mantenidas por fuertes atracciones electrostáticas entre cationes y aniones. La magnitud de esta cohesión está definida por la energía reticular o de red."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.5",
    "enunciado": "¿Qué gas noble NO cumple estrictamente con el octeto, pero es sumamente estable con solo 2 electrones en su capa de valencia?",
    "opciones": [
      "A) Neón ($Ne$)",
      "B) Argón ($Ar$)",
      "C) Helio ($He$)",
      "D) Criptón ($Kr$)"
    ],
    "respuesta_correcta": "C) Helio ($He$)",
    "explicacion_detallada": "El helio completa su primer y único nivel de energía (el subnivel 1s) con 2 electrones (configuración del 'dueto'). Esto le confiere una gran estabilidad, sin necesidad de alcanzar ocho electrones."
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
  print('20 preguntas inyectadas para el código 3.4.5.');
}
