import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = '''[
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Cómo se denomina a la versión alternativa de un gen que determina un rasgo específico?",
    "opciones": [
      "A) Locus",
      "B) Alelo",
      "C) Genoma",
      "D) Cromosoma"
    ],
    "respuesta_correcta": "B) Alelo",
    "explicacion_detallada": "Un alelo es cada una de las formas alternativas que puede tener un mismo gen y que se diferencian en su secuencia, manifestándose en modificaciones concretas de la función de ese gen."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "Según la Primera Ley de Mendel, al cruzar dos líneas puras para un determinado carácter, la descendencia de la primera generación filial (F1) será:",
    "opciones": [
      "A) Genotípicamente diferente pero fenotípicamente igual a uno de los padres.",
      "B) Fenotípicamente y genotípicamente igual a la mezcla de los dos padres.",
      "C) Fenotípicamente y genotípicamente igual entre sí, y fenotípicamente igual a uno de los progenitores.",
      "D) Genotípicamente heterocigota y con fenotipos intermedios."
    ],
    "respuesta_correcta": "C) Fenotípicamente y genotípicamente igual entre sí, y fenotípicamente igual a uno de los progenitores.",
    "explicacion_detallada": "La ley de la uniformidad establece que si se cruzan dos razas puras (homocigotas) para un determinado carácter, los descendientes de la primera generación serán todos iguales entre sí (fenotípica y genotípicamente) y fenotípicamente iguales a uno de los progenitores (el del alelo dominante)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Qué genotipo describe mejor a un organismo diploide que posee dos alelos diferentes para un mismo gen?",
    "opciones": [
      "A) Homocigoto dominante",
      "B) Homocigoto recesivo",
      "C) Heterocigoto",
      "D) Hemicigoto"
    ],
    "respuesta_correcta": "C) Heterocigoto",
    "explicacion_detallada": "Un organismo es heterocigoto para un gen específico cuando tiene dos alelos diferentes (por ejemplo, Aa) en los cromosomas homólogos."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "En la cruza de dos plantas heterocigotas (Aa x Aa) con dominancia completa, ¿cuál es la proporción fenotípica esperada en la descendencia?",
    "opciones": [
      "A) 1:2:1",
      "B) 3:1",
      "C) 9:3:3:1",
      "D) 2:2"
    ],
    "respuesta_correcta": "B) 3:1",
    "explicacion_detallada": "En un cruce monohíbrido entre dos heterocigotos (Aa x Aa), la proporción genotípica es 1 AA : 2 Aa : 1 aa. Dado que AA y Aa muestran el fenotipo dominante, la proporción fenotípica es 3 dominantes por 1 recesivo."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "En la especie humana, el grupo sanguíneo AB es un ejemplo de:",
    "opciones": [
      "A) Dominancia incompleta",
      "B) Codominancia",
      "C) Herencia poligénica",
      "D) Epistasis"
    ],
    "respuesta_correcta": "B) Codominancia",
    "explicacion_detallada": "La codominancia ocurre cuando ambos alelos se expresan completamente en el estado heterocigoto. Las personas con sangre tipo AB expresan tanto el antígeno A como el antígeno B en la superficie de sus eritrocitos."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "El daltonismo está ligado al cromosoma X y es de carácter recesivo. Si una mujer portadora (\$X^D X^d\$) tiene hijos con un hombre sano (\$X^D Y\$), ¿cuál es la probabilidad de que un hijo varón sea daltónico?",
    "opciones": [
      "A) 0%",
      "B) 25%",
      "C) 50%",
      "D) 100%"
    ],
    "respuesta_correcta": "C) 50%",
    "explicacion_detallada": "El padre aporta el cromosoma Y a los hijos varones. La madre aporta \$X^D\$ o \$X^d\$ con un 50% de probabilidad cada uno. Por lo tanto, hay un 50% de probabilidad de que el hijo reciba \$X^d\$ y sea daltónico."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Qué término se utiliza para describir la situación en la que un gen enmascara o modifica la expresión de otro gen en un locus diferente?",
    "opciones": [
      "A) Pleiotropía",
      "B) Codominancia",
      "C) Epistasis",
      "D) Penetrancia incompleta"
    ],
    "respuesta_correcta": "C) Epistasis",
    "explicacion_detallada": "La epistasis es un tipo de interacción génica en la cual la expresión de un gen es afectada o enmascarada por la expresión de otro u otros genes situados en locus diferentes."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "Si en una población humana un gen ligado al cromosoma X tiene un alelo dominante A y uno recesivo a, ¿cuántos genotipos diferentes son posibles en las mujeres y en los hombres, respectivamente?",
    "opciones": [
      "A) Mujeres: 2, Hombres: 2",
      "B) Mujeres: 3, Hombres: 2",
      "C) Mujeres: 3, Hombres: 3",
      "D) Mujeres: 2, Hombres: 3"
    ],
    "respuesta_correcta": "B) Mujeres: 3, Hombres: 2",
    "explicacion_detallada": "Las mujeres tienen dos cromosomas X, por lo que pueden ser \$X^A X^A\$, \$X^A X^a\$, o \$X^a X^a\$ (3 genotipos). Los hombres, al ser hemicigotos (XY), solo pueden ser \$X^A Y\$ o \$X^a Y\$ (2 genotipos)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "La Segunda Ley de Mendel (Ley de la Segregación) se explica a nivel celular durante el proceso de:",
    "opciones": [
      "A) Mitosis",
      "B) Fecundación",
      "C) Meiosis",
      "D) Replicación del ADN"
    ],
    "respuesta_correcta": "C) Meiosis",
    "explicacion_detallada": "La separación (segregación) de los alelos homólogos ocurre durante la anafase I de la meiosis, asegurando que cada gameto reciba solo un alelo para cada gen."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Qué concepto genético explica por qué las personas con acondroplasia (un trastorno dominante) raramente son homocigotas dominantes (AA), siendo el genotipo homocigoto típicamente letal antes del nacimiento?",
    "opciones": [
      "A) Alelos múltiples",
      "B) Alelos letales",
      "C) Dominancia incompleta",
      "D) Pleiotropía"
    ],
    "respuesta_correcta": "B) Alelos letales",
    "explicacion_detallada": "Los alelos letales causan la muerte del organismo. En la acondroplasia, el alelo mutante es letal en homocigosis (AA), por lo que las personas que nacen con esta condición son heterocigotas (Aa)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "El cruce de prueba (test cross) se utiliza para determinar el genotipo de un individuo con fenotipo dominante. Para ello, se le cruza siempre con un individuo:",
    "opciones": [
      "A) Heterocigoto",
      "B) Homocigoto dominante",
      "C) Homocigoto recesivo",
      "D) De fenotipo intermedio"
    ],
    "respuesta_correcta": "C) Homocigoto recesivo",
    "explicacion_detallada": "Al cruzar el individuo problema con un homocigoto recesivo (aa), cualquier alelo recesivo en el individuo problema (si es Aa) se manifestará en la descendencia, revelando así su genotipo."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "En la dominancia incompleta, al cruzar plantas de flores rojas (RR) con plantas de flores blancas (BB), ¿cuál será el fenotipo de la F1?",
    "opciones": [
      "A) Rojas",
      "B) Blancas",
      "C) Rojas con manchas blancas",
      "D) Rosas"
    ],
    "respuesta_correcta": "D) Rosas",
    "explicacion_detallada": "En la dominancia incompleta, el heterocigoto (RB) presenta un fenotipo intermedio entre ambos progenitores homocigotos; en este caso, una mezcla que resulta en color rosa."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "La hemofilia es una enfermedad recesiva ligada al cromosoma X. Un hombre sano y una mujer sana tienen un hijo hemofílico. ¿Cuál es el genotipo de la madre?",
    "opciones": [
      "A) \$X^H X^H\$",
      "B) \$X^H X^h\$",
      "C) \$X^h X^h\$",
      "D) \$X^h Y\$"
    ],
    "respuesta_correcta": "B) \$X^H X^h\$",
    "explicacion_detallada": "Como la madre es sana, debe tener un alelo dominante (\$X^H\$). Para que su hijo tenga hemofilia (\$X^h Y\$), ella debe haberle transmitido el alelo recesivo (\$X^h\$). Por lo tanto, ella es heterocigota o portadora (\$X^H X^h\$)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Cómo se llama el fenómeno en el que un solo gen afecta a múltiples fenotipos no relacionados, como se observa en la anemia falciforme o el síndrome de Marfan?",
    "opciones": [
      "A) Poligenia",
      "B) Pleiotropía",
      "C) Epistasis",
      "D) Codominancia"
    ],
    "respuesta_correcta": "B) Pleiotropía",
    "explicacion_detallada": "La pleiotropía se define como el fenómeno en el cual un solo gen es responsable de efectos fenotípicos o caracteres distintos y aparentemente no relacionados."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "La estatura humana, el color de la piel y el peso están determinados por la acción de varios genes interactuando con el ambiente. A este tipo de herencia se le denomina:",
    "opciones": [
      "A) Herencia poligénica",
      "B) Herencia autosómica recesiva",
      "C) Herencia ligada al sexo",
      "D) Pleiotropía"
    ],
    "respuesta_correcta": "A) Herencia poligénica",
    "explicacion_detallada": "La herencia poligénica ocurre cuando un rasgo fenotípico es controlado por dos o más genes, produciendo generalmente una variación continua en el fenotipo, como la altura o el color de piel."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "En genética, ¿qué se entiende por el término 'cariotipo'?",
    "opciones": [
      "A) El conjunto de todos los alelos que posee un individuo.",
      "B) La apariencia física y las características bioquímicas de un organismo.",
      "C) El conjunto de cromosomas de una célula, ordenados de acuerdo a su morfología y tamaño.",
      "D) Un segmento de ADN que codifica para una proteína específica."
    ],
    "respuesta_correcta": "C) El conjunto de cromosomas de una célula, ordenados de acuerdo a su morfología y tamaño.",
    "explicacion_detallada": "El cariotipo es la representación visual, ordenada por pares homólogos, tamaño y forma, de los cromosomas de una célula, y sirve para detectar anomalías cromosómicas."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "¿Qué proporción fenotípica descubrió Mendel en la generación F2 al cruzar diheterocigotos (AaBb x AaBb) para genes independientes?",
    "opciones": [
      "A) 3:1",
      "B) 1:1:1:1",
      "C) 9:3:3:1",
      "D) 9:7"
    ],
    "respuesta_correcta": "C) 9:3:3:1",
    "explicacion_detallada": "La Tercera Ley de Mendel (distribución independiente) establece que en un cruce dihíbrido clásico (AaBb x AaBb) la proporción fenotípica resultante en la descendencia es 9:3:3:1."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "En la herencia de los grupos sanguíneos del sistema ABO, los alelos \$I^A\$ e \$I^B\$ son dominantes sobre el alelo i. Si un hombre de grupo A (heterocigoto) y una mujer de grupo B (heterocigota) tienen hijos, ¿qué grupos sanguíneos pueden presentar los hijos?",
    "opciones": [
      "A) Solamente A y B.",
      "B) Solamente AB y O.",
      "C) A, B, AB y O.",
      "D) Solamente A, B y AB."
    ],
    "respuesta_correcta": "C) A, B, AB y O.",
    "explicacion_detallada": "El padre es \$I^A i\$ y la madre es \$I^B i\$. Sus posibles combinaciones gaméticas generan descendencia \$I^A I^B\$ (grupo AB), \$I^A i\$ (grupo A), \$I^B i\$ (grupo B) e \$ii\$ (grupo O)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "El fenómeno por el cual los genes ubicados en el mismo cromosoma tienden a heredarse juntos se denomina:",
    "opciones": [
      "A) Recombinación",
      "B) Ligamiento",
      "C) Segregación independiente",
      "D) Mutación genética"
    ],
    "respuesta_correcta": "B) Ligamiento",
    "explicacion_detallada": "Los genes ligados (ligamiento génico) se encuentran tan cerca en el mismo cromosoma que generalmente no se separan durante el entrecruzamiento de la meiosis, heredándose como un bloque."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.2",
    "enunciado": "Si se produce una no disyunción cromosómica durante la meiosis de uno de los progenitores, ¿qué condición genética puede presentarse en la descendencia?",
    "opciones": [
      "A) Aneuploidía (ej. Síndrome de Down)",
      "B) Albinismo",
      "C) Fibrosis quística",
      "D) Daltonismo"
    ],
    "respuesta_correcta": "A) Aneuploidía (ej. Síndrome de Down)",
    "explicacion_detallada": "La no disyunción es un error en la segregación de los cromosomas homólogos o las cromátidas hermanas, lo que da lugar a gametos con un número anormal de cromosomas (aneuploidía), como la Trisomía 21 (Síndrome de Down)."
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
  print('20 preguntas inyectadas para el código 3.1.2.');
}
