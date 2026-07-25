import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Cuál es la principal característica estructural que diferencia a la gran mayoría de los compuestos orgánicos de los inorgánicos?",
    "opciones": [
      "A) La presencia exclusiva de enlaces iónicos en su molécula.",
      "B) Su base fundamental constituida por átomos de carbono e hidrógeno.",
      "C) La ausencia total de oxígeno en su composición química.",
      "D) Su alta solubilidad en agua independientemente de su polaridad."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La química orgánica es la química de los compuestos del carbono. Los compuestos orgánicos tienen como base esqueletos de carbono unidos a átomos de hidrógeno, a diferencia de los inorgánicos, donde el carbono no es el elemento central o estructural fundamental."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Qué tipo de enlace químico predomina de manera general en los compuestos orgánicos?",
    "opciones": [
      "A) Enlace iónico",
      "B) Enlace metálico",
      "C) Enlace covalente",
      "D) Enlace por puente de hidrógeno exclusivo"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Los compuestos orgánicos están formados mayoritariamente por elementos no metálicos (C, H, O, N), cuyas electronegatividades son similares. Por ello, se unen compartiendo pares de electrones mediante enlaces covalentes."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Si comparamos los puntos de fusión y ebullición, es correcto afirmar que generalmente:",
    "opciones": [
      "A) Los compuestos inorgánicos presentan puntos de fusión y ebullición más altos que los orgánicos.",
      "B) Los compuestos orgánicos siempre tienen puntos de ebullición superiores a los 1000 °C.",
      "C) No existe ninguna diferencia significativa entre las temperaturas de fusión de ambos tipos de compuestos.",
      "D) Los compuestos inorgánicos son siempre gases a temperatura ambiente por sus bajos puntos de ebullición."
    ],
    "respuesta_correcta": "A",
    "explicacion_detallada": "Los compuestos inorgánicos, que frecuentemente presentan redes iónicas muy estables, requieren mucha energía para romper sus enlaces, teniendo altos puntos de fusión y ebullición. Los orgánicos, unidos por fuerzas intermoleculares más débiles, funden y hierven a temperaturas más bajas."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "En cuanto a la conductividad eléctrica en disolución acuosa, ¿cuál es el comportamiento típico de estos compuestos?",
    "opciones": [
      "A) Los compuestos orgánicos son excelentes electrolitos fuertes.",
      "B) Los compuestos inorgánicos iónicos suelen conducir la electricidad al disolverse, comportándose como electrolitos.",
      "C) Ambos tipos de compuestos no conducen la corriente eléctrica bajo ninguna circunstancia.",
      "D) Los alcanos, como compuestos orgánicos, conducen la electricidad mejor que las sales inorgánicas."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los compuestos inorgánicos (como sales, ácidos fuertes o bases) se disocian en iones en solución acuosa, permitiendo el flujo de electrones (conductividad). La mayoría de los orgánicos no se ionizan, por lo que son no electrolitos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Cuál de las siguientes afirmaciones sobre la solubilidad es correcta como regla general?",
    "opciones": [
      "A) Los compuestos orgánicos son siempre muy solubles en agua.",
      "B) Los compuestos inorgánicos son insolubles en agua pero muy solubles en benceno.",
      "C) Los compuestos orgánicos suelen ser solubles en disolventes apolares (como el éter o hexano).",
      "D) El agua disuelve exclusivamente a los compuestos orgánicos de gran peso molecular."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Siguiendo el principio de 'lo semejante disuelve a lo semejante', los compuestos orgánicos (frecuentemente apolares o de baja polaridad) son solubles en disolventes orgánicos apolares. Los inorgánicos polares o iónicos son más solubles en agua (solvente polar)."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "El fenómeno por el cual dos o más compuestos tienen la misma fórmula molecular pero distinta estructura espacial o conectividad se denomina:",
    "opciones": [
      "A) Alotropía",
      "B) Isomería",
      "C) Hibridación",
      "D) Polimerización"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La isomería es un fenómeno característico y muy común en la química orgánica, que explica la enorme variedad y cantidad de compuestos orgánicos existentes a partir de una misma fórmula química."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Indique cuál de los siguientes compuestos, a pesar de contener carbono en su estructura, es considerado de naturaleza inorgánica.",
    "opciones": [
      "A) Metano ($CH_4$)",
      "B) Etanol ($C_2H_5OH$)",
      "C) Dióxido de carbono ($CO_2$)",
      "D) Glucosa ($C_6H_{12}O_6$)"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Aunque el $CO_2$ contiene carbono, sus propiedades físicas y químicas, así como su origen, son típicos de la química inorgánica. Otros ejemplos de inorgánicos con carbono incluyen carbonatos, cianuros y monóxido de carbono."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Qué propiedad es característica de una gran cantidad de compuestos orgánicos frente a los inorgánicos?",
    "opciones": [
      "A) Su incombustibilidad absoluta.",
      "B) Su alta inflamabilidad y capacidad de combustión.",
      "C) Su resistencia a temperaturas superiores a 800 °C sin descomponerse.",
      "D) Su estructura molecular siempre basada en enlaces metálicos."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los compuestos orgánicos, al estar formados principalmente por carbono e hidrógeno, son frecuentemente combustibles (reaccionan con el oxígeno liberando energía, agua y dióxido de carbono), a diferencia de la mayoría de las sales inorgánicas."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Históricamente, ¿qué hito marcó el fin de la 'teoría de la fuerza vital' y demostró que se puede sintetizar un compuesto orgánico a partir de uno inorgánico?",
    "opciones": [
      "A) La síntesis del benceno por Kekulé.",
      "B) El descubrimiento del electrón por Thomson.",
      "C) La síntesis de la urea por Friedrich Wöhler calentando cianato de amonio.",
      "D) La obtención de penicilina por Alexander Fleming."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "En 1828, Friedrich Wöhler sintetizó urea (un compuesto orgánico presente en la orina) calentando cianato de amonio (una sal inorgánica), demostrando que no se requería una 'fuerza vital' misteriosa exclusiva de los seres vivos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "La capacidad del átomo de carbono para unirse a otros átomos de carbono formando largas cadenas o anillos se conoce como:",
    "opciones": [
      "A) Electronegatividad",
      "B) Catenación",
      "C) Reactividad",
      "D) Solvatación"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La catenación es la capacidad de los átomos de un mismo elemento para unirse entre sí formando cadenas estables. En el carbono, esta propiedad es excepcionalmente fuerte y explica la existencia de millones de compuestos orgánicos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Identifique el compuesto inorgánico en la siguiente lista:",
    "opciones": [
      "A) Cloruro de sodio ($NaCl$)",
      "B) Ácido acético ($CH_3COOH$)",
      "C) Benceno ($C_6H_6$)",
      "D) Propano ($C_3H_8$)"
    ],
    "respuesta_correcta": "A",
    "explicacion_detallada": "El cloruro de sodio ($NaCl$) es una sal típica, formada por enlaces iónicos entre un metal (Na) y un no metal (Cl), careciendo de carbono y de enlaces C-H, lo que lo define claramente como un compuesto inorgánico."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Generalmente, la velocidad a la que ocurren las reacciones químicas es diferente entre compuestos orgánicos e inorgánicos. ¿Cuál es el patrón típico?",
    "opciones": [
      "A) Las reacciones inorgánicas son muy lentas, mientras que las orgánicas son instantáneas.",
      "B) Las reacciones orgánicas suelen ser más lentas y complejas, requiriendo frecuentemente catalizadores.",
      "C) No existen diferencias en la cinética de ambos tipos de reacciones.",
      "D) Los orgánicos reaccionan exclusivamente a bajas temperaturas."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Las reacciones orgánicas implican rupturas y formaciones de fuertes enlaces covalentes, lo cual es un proceso molecular complejo que suele ser lento. Las reacciones inorgánicas en solución, al ser a menudo iónicas, suceden de forma casi instantánea."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Los elementos C, H, O y N constituyen aproximadamente el 99% de la masa de los seres vivos y forman parte primordial de los orgánicos. A estos elementos se los conoce como:",
    "opciones": [
      "A) Halógenos",
      "B) Metales alcalinotérreos",
      "C) Elementos organógenos o biogenésicos principales",
      "D) Gases nobles orgánicos"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Se les denomina elementos organógenos porque son los componentes primarios que generan la inmensa mayoría de las moléculas orgánicas que estructuran y hacen funcionar a la materia viva."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Si tienes una sustancia sólida, de color blanco, que al calentarla sobre una llama no se quema y requiere una altísima temperatura para fundirse, es muy probable que se trate de:",
    "opciones": [
      "A) Un polisacárido (almidón)",
      "B) Una cera orgánica",
      "C) Un compuesto inorgánico iónico (como una sal)",
      "D) Un ácido carboxílico de cadena larga"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Los altos puntos de fusión y la incombustibilidad son propiedades típicas de las redes cristalinas iónicas, características de los compuestos inorgánicos como las sales."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Cuál de las siguientes combinaciones de compuestos pertenece exclusivamente a la química orgánica?",
    "opciones": [
      "A) Agua ($H_2O$), amoníaco ($NH_3$), sal de mesa ($NaCl$)",
      "B) Acetona ($C_3H_6O$), etano ($C_2H_6$), fenol ($C_6H_5OH$)",
      "C) Ácido sulfúrico ($H_2SO_4$), hidróxido de sodio ($NaOH$), nitrato de potasio ($KNO_3$)",
      "D) Monóxido de carbono ($CO$), carbonato de calcio ($CaCO_3$), diamante ($C$)"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La opción B contiene únicamente compuestos a base de cadenas y anillos de carbono e hidrógeno (con oxígeno en acetona y fenol), los cuales son característicos de la química orgánica."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Una diferencia notable en el estado físico a temperatura ambiente es que:",
    "opciones": [
      "A) Todos los compuestos orgánicos son sólidos cristalinos.",
      "B) Los compuestos inorgánicos solo pueden existir en estado gaseoso.",
      "C) Los compuestos orgánicos pueden ser gases, líquidos volátiles o sólidos de bajo punto de fusión, mientras que la mayoría de los inorgánicos son sólidos.",
      "D) No existe ninguna sustancia inorgánica líquida."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Debido a las débiles fuerzas intermoleculares, muchos compuestos orgánicos simples son gases (metano) o líquidos volátiles (alcohol, acetona) a temperatura ambiente. En contraste, las fuertes interacciones iónicas hacen que gran parte de los inorgánicos sean sólidos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "A los compuestos formados por inmensas cadenas repetitivas y de altísimo peso molecular, como los plásticos, el ADN o las proteínas, característicos de la química del carbono, se los conoce como:",
    "opciones": [
      "A) Isótopos",
      "B) Aleaciones",
      "C) Polímeros orgánicos (macromoléculas)",
      "D) Sales complejas"
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Los polímeros son macromoléculas formadas por la unión de múltiples monómeros orgánicos menores gracias a la capacidad de catenación del carbono."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "¿Qué compuesto, a pesar de tener carbono en su molécula, está clasificado como inorgánico debido a que en solución se ioniza para formar una sal?",
    "opciones": [
      "A) Ácido cítrico",
      "B) Carbonato de sodio ($Na_2CO_3$)",
      "C) Ácido butanoico",
      "D) Etilamina"
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "Los carbonatos contienen el ion poliatómico $CO_3^{2-}$. Este comportamiento predominantemente iónico y mineralúrgico los clasifica como compuestos inorgánicos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "La isomería es extremadamente rara en los compuestos inorgánicos simples pero es la norma en la química orgánica. ¿Cuántos compuestos inorgánicos se conocen en comparación con los orgánicos?",
    "opciones": [
      "A) Existen más compuestos inorgánicos que orgánicos debido a que abarcan a toda la tabla periódica.",
      "B) La cantidad de compuestos orgánicos e inorgánicos conocidos es prácticamente idéntica.",
      "C) Se conocen millones de compuestos orgánicos frente a solo cientos de miles de inorgánicos.",
      "D) Los compuestos orgánicos son tan inestables que existen menos de 10.000 en la naturaleza."
    ],
    "respuesta_correcta": "C",
    "explicacion_detallada": "Debido a la isomería y a la capacidad de catenación, la química del carbono ha generado decenas de millones de compuestos distintos, superando con creces la cantidad de compuestos inorgánicos conocidos."
  },
  {
    "materia": "Química",
    "codigo_tema": "3.4.6",
    "enunciado": "Una mezcla casera común involucra sacarosa (azúcar, un compuesto orgánico) y cloruro de sodio (sal, inorgánico). Si calientas intensamente ambas sustancias en recipientes separados sobre una hornilla:",
    "opciones": [
      "A) La sal se derretirá rápidamente y el azúcar permanecerá inalterada.",
      "B) El azúcar se fundirá, carbonizará y arderá, mientras que la sal no presentará cambios visibles inmediatos.",
      "C) Ambos compuestos sublimarán instantáneamente en forma de gases tóxicos.",
      "D) La sal se oxidará generando flamas, mientras que el azúcar se cristalizará más fuerte."
    ],
    "respuesta_correcta": "B",
    "explicacion_detallada": "La sacarosa ($C_{12}H_{22}O_{11}$) tiene un punto de fusión relativamente bajo y es combustible (se carameliza y carboniza). El $NaCl$ tiene un punto de fusión de alrededor de 801 °C, por lo que el calor de una hornilla común no es suficiente para fundirlo o alterarlo visiblemente."
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
  print('20 preguntas inyectadas para el código 3.4.6.');
}
