import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Qué tipo de enlace químico se forma principalmente debido a la transferencia de electrones de un átomo a otro?",
    "opciones": [
      "A) Enlace covalente polar",
      "B) Enlace iónico",
      "C) Enlace metálico",
      "D) Enlace covalente apolar"
    ],
    "respuesta_correcta": "B) Enlace iónico",
    "explicacion_detallada": "El enlace iónico se caracteriza por la transferencia completa de uno o más electrones de un átomo (generalmente un metal) a otro (un no metal), formando cationes y aniones que se atraen electrostáticamente."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "En la molécula de agua ($H_2O$), ¿qué tipo de enlace une a los átomos de hidrógeno con el átomo de oxígeno?",
    "opciones": [
      "A) Covalente apolar",
      "B) Iónico",
      "C) Covalente polar",
      "D) Metálico"
    ],
    "respuesta_correcta": "C) Covalente polar",
    "explicacion_detallada": "En el agua, el oxígeno y el hidrógeno comparten electrones, formando un enlace covalente. Como el oxígeno es más electronegativo, atrae los electrones hacia sí, creando un dipolo y haciendo que el enlace sea covalente polar."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "Según la regla del octeto, los átomos tienden a ganar, perder o compartir electrones para adquirir la configuración electrónica de:",
    "opciones": [
      "A) Un halógeno",
      "B) Un metal alcalino",
      "C) Un gas noble",
      "D) Un metal de transición"
    ],
    "respuesta_correcta": "C) Un gas noble",
    "explicacion_detallada": "La regla del octeto establece que los átomos son más estables cuando tienen ocho electrones en su capa de valencia, configuración característica de los gases nobles (excepto el helio, que tiene dos)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Cuál de las siguientes moléculas presenta un enlace covalente doble?",
    "opciones": [
      "A) $N_2$",
      "B) $H_2$",
      "C) $O_2$",
      "D) $Cl_2$"
    ],
    "respuesta_correcta": "C) $O_2$",
    "explicacion_detallada": "En la molécula de $O_2$, cada átomo de oxígeno necesita dos electrones para completar su octeto, por lo que comparten dos pares de electrones, formando un doble enlace. El $N_2$ tiene enlace triple y los otros dos enlaces simples."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "El enlace metálico se explica frecuentemente mediante el modelo del 'mar de electrones'. En este modelo, los electrones:",
    "opciones": [
      "A) Están fuertemente unidos a núcleos específicos.",
      "B) Se comparten equitativamente solo entre dos átomos vecinos.",
      "C) Son transferidos de un átomo a otro de forma irreversible.",
      "D) Están deslocalizados y pueden moverse libremente por toda la red de cationes."
    ],
    "respuesta_correcta": "D) Están deslocalizados y pueden moverse libremente por toda la red de cationes.",
    "explicacion_detallada": "El modelo del mar de electrones postula que en un metal los electrones de valencia no pertenecen a ningún átomo en particular, sino que están deslocalizados, permitiendo la alta conductividad eléctrica y térmica de los metales."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "Si la diferencia de electronegatividad entre dos átomos que se enlazan es mayor a 1.7, el enlace formado se considera predominantemente:",
    "opciones": [
      "A) Covalente apolar",
      "B) Covalente polar",
      "C) Iónico",
      "D) Metálico"
    ],
    "respuesta_correcta": "C) Iónico",
    "explicacion_detallada": "Una diferencia de electronegatividad de Pauling superior a aproximadamente 1.7 indica que un átomo tiene la capacidad de arrebatar casi por completo el electrón al otro átomo, formando así un enlace predominantemente iónico."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Qué molécula es una excepción a la regla del octeto por tener menos de ocho electrones en la capa de valencia de su átomo central?",
    "opciones": [
      "A) $CO_2$",
      "B) $SF_6$",
      "C) $NH_3$",
      "D) $BF_3$"
    ],
    "respuesta_correcta": "D) $BF_3$",
    "explicacion_detallada": "En el trifluoruro de boro ($BF_3$), el átomo de boro está rodeado solo por 6 electrones (3 pares compartidos) en su capa de valencia, siendo un caso clásico de octeto incompleto."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "En la molécula diatómica de nitrógeno ($N_2$), ¿cuántos pares de electrones se comparten entre los dos átomos?",
    "opciones": [
      "A) Uno",
      "B) Dos",
      "C) Tres",
      "D) Cuatro"
    ],
    "respuesta_correcta": "C) Tres",
    "explicacion_detallada": "El nitrógeno pertenece al grupo 15, por lo que tiene 5 electrones de valencia. Para completar el octeto, cada átomo comparte 3 electrones, formando un triple enlace (3 pares compartidos)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "Identifica el compuesto que presenta principalmente enlaces iónicos:",
    "opciones": [
      "A) $CH_4$",
      "B) $NaCl$",
      "C) $H_2O$",
      "D) $SO_2$"
    ],
    "respuesta_correcta": "B) $NaCl$",
    "explicacion_detallada": "El cloruro de sodio ($NaCl$) está formado por un metal (sodio) y un no metal (cloro), con una gran diferencia de electronegatividad, lo que da lugar a una transferencia de electrones y, por ende, a un enlace iónico."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "El enlace covalente coordinado (o dativo) se caracteriza porque:",
    "opciones": [
      "A) Ambos átomos aportan un electrón al par compartido.",
      "B) Los electrones se transfieren totalmente de un átomo a otro.",
      "C) Un solo átomo aporta los dos electrones del par compartido.",
      "D) Participan únicamente átomos metálicos."
    ],
    "respuesta_correcta": "C) Un solo átomo aporta los dos electrones del par compartido.",
    "explicacion_detallada": "A diferencia del enlace covalente normal donde cada átomo aporta un electrón, en el enlace covalente coordinado, el par de electrones compartido es donado en su totalidad por uno de los dos átomos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Cuál de las siguientes propiedades es característica de los compuestos con enlace iónico?",
    "opciones": [
      "A) Bajos puntos de fusión y ebullición.",
      "B) Conductividad eléctrica en estado sólido.",
      "C) Insolubilidad en disolventes polares como el agua.",
      "D) Son sólidos cristalinos a temperatura ambiente y conducen la electricidad fundidos."
    ],
    "respuesta_correcta": "D) Son sólidos cristalinos a temperatura ambiente y conducen la electricidad fundidos.",
    "explicacion_detallada": "Los compuestos iónicos forman redes cristalinas sólidas a temperatura ambiente debido a las fuertes atracciones electrostáticas. No conducen electricidad en estado sólido, pero sí al fundirse o disolverse, ya que los iones adquieren movilidad."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "En la molécula de metano ($CH_4$), la geometría molecular alrededor del átomo de carbono es:",
    "opciones": [
      "A) Lineal",
      "B) Trigonal plana",
      "C) Tetraédrica",
      "D) Angular"
    ],
    "respuesta_correcta": "C) Tetraédrica",
    "explicacion_detallada": "El carbono en el metano tiene hibridación $sp^3$ y forma cuatro enlaces covalentes simples con el hidrógeno, los cuales se disponen lo más alejados posible entre sí (repulsión de pares de electrones), resultando en una geometría tetraédrica con ángulos de 109.5°."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Cuál es la estructura de Lewis correcta para el dióxido de carbono ($CO_2$)?",
    "opciones": [
      "A) $O-C-O$ (enlaces simples y octetos incompletos)",
      "B) $O=C=O$ (dobles enlaces y octetos completos para todos)",
      "C) $O \\equiv C - O$ (un enlace triple y uno simple)",
      "D) $C=O=O$ (dobles enlaces pero geometría incorrecta)"
    ],
    "respuesta_correcta": "B) $O=C=O$ (dobles enlaces y octetos completos para todos)",
    "explicacion_detallada": "El carbono necesita 4 electrones para completar su octeto y cada oxígeno necesita 2. Por tanto, el carbono forma un doble enlace con cada átomo de oxígeno, resultando en $O=C=O$, dejando a cada átomo con ocho electrones de valencia."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "La capacidad de un átomo para atraer hacia sí los electrones de un enlace químico se denomina:",
    "opciones": [
      "A) Afinidad electrónica",
      "B) Energía de ionización",
      "C) Electronegatividad",
      "D) Polarizabilidad"
    ],
    "respuesta_correcta": "C) Electronegatividad",
    "explicacion_detallada": "La electronegatividad es una medida empírica de la fuerza con la que un átomo en una molécula atrae los electrones del enlace hacia sí mismo. Es clave para predecir la polaridad del enlace."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Qué tipo de molécula es el flúor molecular ($F_2$) en términos de polaridad de enlace?",
    "opciones": [
      "A) Covalente polar",
      "B) Covalente apolar",
      "C) Iónica",
      "D) Coordinada"
    ],
    "respuesta_correcta": "B) Covalente apolar",
    "explicacion_detallada": "El $F_2$ está formado por dos átomos idénticos, por lo que su diferencia de electronegatividad es cero. Comparten los electrones por igual, formando un enlace covalente puro o apolar."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "¿Cuál de las siguientes sustancias es un ejemplo clásico de un sólido covalente reticular (macromolecular)?",
    "opciones": [
      "A) Hielo ($H_2O_{sólido}$)",
      "B) Cloruro de potasio ($KCl$)",
      "C) Diamante (C)",
      "D) Yodo sólido ($I_2$)"
    ],
    "respuesta_correcta": "C) Diamante (C)",
    "explicacion_detallada": "El diamante es un sólido en el que todos los átomos de carbono están unidos mediante una extensa red tridimensional de fuertes enlaces covalentes, dándole extrema dureza."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "La molécula de hexafluoruro de azufre ($SF_6$) es una excepción a la regla del octeto porque el átomo central presenta:",
    "opciones": [
      "A) Un octeto incompleto con 6 electrones.",
      "B) Un octeto expandido con 12 electrones.",
      "C) Un número impar de electrones.",
      "D) No tiene electrones de valencia."
    ],
    "respuesta_correcta": "B) Un octeto expandido con 12 electrones.",
    "explicacion_detallada": "El azufre pertenece al período 3 y puede utilizar orbitales $d$ vacíos para expandir su capa de valencia. En el $SF_6$, el azufre forma 6 enlaces covalentes, rodeándose de 12 electrones."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "Si dos átomos comparten de forma desigual un par de electrones debido a una diferencia moderada de electronegatividades, el enlace se llama:",
    "opciones": [
      "A) Iónico puro",
      "B) Covalente apolar",
      "C) Covalente polar",
      "D) Metálico"
    ],
    "respuesta_correcta": "C) Covalente polar",
    "explicacion_detallada": "La diferencia de electronegatividad (entre 0.4 y 1.7 aprox) hace que los electrones se acerquen más al átomo más electronegativo, creando polos parciales, lo que define al enlace covalente polar."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "Las fuerzas de repulsión entre los pares de electrones de la capa de valencia (RPECV) se utilizan principalmente para predecir:",
    "opciones": [
      "A) El tipo de enlace (iónico o covalente).",
      "B) La electronegatividad de los átomos.",
      "C) La geometría de las moléculas.",
      "D) El estado de agregación de la sustancia."
    ],
    "respuesta_correcta": "C) La geometría de las moléculas.",
    "explicacion_detallada": "La teoría RPECV asume que los pares de electrones alrededor de un átomo central se repelen entre sí y, por lo tanto, adoptan una disposición espacial que minimiza esa repulsión, determinando la geometría molecular."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.4",
    "enunciado": "En la estructura de Lewis del ion amonio ($NH_4^+$), un hidrógeno se une al nitrógeno a través de un par de electrones que aporta completamente el nitrógeno. A este enlace específico se le denomina:",
    "opciones": [
      "A) Enlace metálico",
      "B) Enlace iónico",
      "C) Enlace covalente dativo o coordinado",
      "D) Enlace de hidrógeno"
    ],
    "respuesta_correcta": "C) Enlace covalente dativo o coordinado",
    "explicacion_detallada": "Cuando la molécula de amoníaco ($NH_3$) reacciona con un protón ($H^+$), el nitrógeno aporta su par de electrones no enlazantes para formar el enlace con el ion hidrógeno, configurando un enlace covalente coordinado."
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
  print('20 preguntas inyectadas para el código 3.4.4.');
}
