import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Cuáles son los tres niveles principales en los que se estudia comúnmente la diversidad biológica?",
    "opciones": [
      "A) Genética, de especies y de ecosistemas.",
      "B) Celular, tisular y orgánica.",
      "C) Poblacional, comunitaria y biosférica.",
      "D) Alfa, beta y gamma exclusivamente a nivel local."
    ],
    "respuesta_correcta": "A) Genética, de especies y de ecosistemas.",
    "explicacion_detallada": "La biodiversidad se comprende de manera integral en tres niveles: la diversidad genética (variación de genes dentro de una especie), la diversidad de especies (variedad de especies en una región) y la diversidad de ecosistemas (variedad de hábitats y comunidades biológicas)."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "De acuerdo con las causas principales de pérdida de biodiversidad, ¿cuál es el factor que más contribuye actualmente a la extinción de especies a nivel mundial?",
    "opciones": [
      "A) El cambio climático global.",
      "B) La destrucción y pérdida de hábitat.",
      "C) La introducción de especies exóticas invasoras.",
      "D) La sobreexplotación de recursos naturales."
    ],
    "respuesta_correcta": "B) La destrucción y pérdida de hábitat.",
    "explicacion_detallada": "Aunque todos los factores son amenazas graves, la alteración, fragmentación y destrucción del hábitat por actividades humanas (como deforestación y urbanización) es la causa principal e inmediata de la disminución de la biodiversidad global."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué término se utiliza para describir a las especies que se encuentran exclusivamente en una región geográfica delimitada y en ninguna otra parte del mundo?",
    "opciones": [
      "A) Especies nativas.",
      "B) Especies exóticas.",
      "C) Especies endémicas.",
      "D) Especies cosmopolitas."
    ],
    "respuesta_correcta": "C) Especies endémicas.",
    "explicacion_detallada": "El endemismo es el estado ecológico de una especie que es exclusiva de una ubicación geográfica definida, como una isla, nación, país u otra zona definida; son particularmente vulnerables a la extinción."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "La estrategia de conservación que se lleva a cabo fuera del hábitat natural de la especie, como en bancos de semillas, zoológicos o jardines botánicos, se denomina:",
    "opciones": [
      "A) Conservación in situ.",
      "B) Conservación ex situ.",
      "C) Restauración ecológica.",
      "D) Biorremediación."
    ],
    "respuesta_correcta": "B) Conservación ex situ.",
    "explicacion_detallada": "La conservación ex situ implica la preservación de componentes de la diversidad biológica fuera de sus hábitats naturales, sirviendo como un respaldo genético y para programas de cría en cautividad."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué es un 'hotspot' o punto caliente de biodiversidad según el concepto de Norman Myers?",
    "opciones": [
      "A) Una región con alta temperatura que alberga muchas especies tropicales.",
      "B) Un área protegida por acuerdos internacionales sin presencia humana.",
      "C) Una zona con una excepcional concentración de especies endémicas que experimenta una pérdida rápida de hábitat.",
      "D) Un ecosistema artificial creado para maximizar la diversidad genética."
    ],
    "respuesta_correcta": "C) Una zona con una excepcional concentración de especies endémicas que experimenta una pérdida rápida de hábitat.",
    "explicacion_detallada": "Los hotspots de biodiversidad son regiones biogeográficas con niveles muy altos de endemismo de plantas que han perdido al menos el 70% de su hábitat original, por lo que son prioridades globales de conservación."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "En ecología de la conservación, ¿qué es el 'efecto de borde' provocado por la fragmentación del hábitat?",
    "opciones": [
      "A) El aumento de la diversidad de especies en el centro de un área protegida.",
      "B) Los cambios en las condiciones ambientales y biológicas en la periferia de un fragmento de hábitat.",
      "C) El desplazamiento de las especies hacia los polos debido al calentamiento global.",
      "D) La extinción de especies migratorias al llegar a la costa."
    ],
    "respuesta_correcta": "B) Los cambios en las condiciones ambientales y biológicas en la periferia de un fragmento de hábitat.",
    "explicacion_detallada": "La fragmentación aumenta la proporción de borde respecto al área interior. El borde tiene microclimas diferentes (más luz, viento, sequedad) y expone a las especies del interior a depredadores y competidores externos."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué papel juegan las 'especies clave' (keystone species) en la conservación de un ecosistema?",
    "opciones": [
      "A) Son siempre los productores primarios con mayor biomasa.",
      "B) Tienen un impacto desproporcionadamente grande en su ecosistema en relación con su abundancia.",
      "C) Son especies exóticas que aumentan la competitividad del ecosistema.",
      "D) Son los microorganismos descomponedores exclusivos de un hábitat."
    ],
    "respuesta_correcta": "B) Tienen un impacto desproporcionadamente grande en su ecosistema en relación con su abundancia.",
    "explicacion_detallada": "Las especies clave mantienen la estructura de la comunidad ecológica. Su desaparición puede causar cambios drásticos o un colapso en el ecosistema, como la nutria marina en los bosques de algas."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "El tratado internacional que busca garantizar que el comercio internacional de especímenes de animales y plantas silvestres no constituya una amenaza para su supervivencia se conoce como:",
    "opciones": [
      "A) Protocolo de Kioto.",
      "B) Convenio sobre la Diversidad Biológica (CDB).",
      "C) CITES (Convención sobre el Comercio Internacional de Especies Amenazadas).",
      "D) Acuerdo de París."
    ],
    "respuesta_correcta": "C) CITES (Convención sobre el Comercio Internacional de Especies Amenazadas).",
    "explicacion_detallada": "CITES regula o prohíbe el comercio de ciertas especies silvestres para protegerlas de la sobreexplotación derivada del comercio internacional."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Cuál de las siguientes es una consecuencia directa de la introducción de una especie exótica invasora en un ecosistema nativo?",
    "opciones": [
      "A) Aumento inmediato de la diversidad genética de las especies locales.",
      "B) Desplazamiento o extinción de especies nativas por competencia o depredación.",
      "C) Reducción permanente de las tasas de mutación en la fauna autóctona.",
      "D) Mejora en la estabilidad climática regional."
    ],
    "respuesta_correcta": "B) Desplazamiento o extinción de especies nativas por competencia o depredación.",
    "explicacion_detallada": "Las especies invasoras a menudo carecen de depredadores naturales en el nuevo hábitat, lo que les permite proliferar, competir por recursos y depredar agresivamente a las especies nativas vulnerables."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Cómo benefician los 'corredores biológicos' a la conservación de las especies?",
    "opciones": [
      "A) Aíslan genéticamente a las poblaciones para forzar la especiación.",
      "B) Evitan la entrada de energía solar a los estratos inferiores del bosque.",
      "C) Conectan hábitats fragmentados permitiendo la dispersión y el flujo genético.",
      "D) Concentran a los depredadores en un área pequeña para controlarlos."
    ],
    "respuesta_correcta": "C) Conectan hábitats fragmentados permitiendo la dispersión y el flujo genético.",
    "explicacion_detallada": "Los corredores biológicos unen parches de hábitat aislado, reduciendo el efecto del aislamiento, disminuyendo la endogamia y permitiendo la migración y el rescate poblacional."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "La disciplina científica que se centra en el restablecimiento activo de un ecosistema degradado o destruido a su estado histórico o natural se denomina:",
    "opciones": [
      "A) Ecología de la restauración.",
      "B) Conservación ex situ.",
      "C) Sucesión ecológica primaria.",
      "D) Biogeografía de islas."
    ],
    "respuesta_correcta": "A) Ecología de la restauración.",
    "explicacion_detallada": "La ecología de la restauración es el estudio científico que apoya la práctica de restaurar un ecosistema que ha sido degradado, dañado o destruido por la acción humana."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué término describe los beneficios que los seres humanos obtienen directamente de los ecosistemas, como polinización, purificación del agua y control del clima?",
    "opciones": [
      "A) Servicios ambientales o ecosistémicos.",
      "B) Externalidades biológicas.",
      "C) Recursos no renovables.",
      "D) Capitalismos naturales."
    ],
    "respuesta_correcta": "A) Servicios ambientales o ecosistémicos.",
    "explicacion_detallada": "Los servicios ecosistémicos son las contribuciones directas o indirectas de los ecosistemas al bienestar humano, divididos en provisión, regulación, soporte y culturales."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "En la evaluación del estado de conservación de una especie, la UICN utiliza categorías. ¿Cuál representa el mayor riesgo inminente de extinción en la naturaleza?",
    "opciones": [
      "A) Preocupación menor (LC).",
      "B) Vulnerable (VU).",
      "C) En peligro crítico (CR).",
      "D) Casi amenazada (NT)."
    ],
    "respuesta_correcta": "C) En peligro crítico (CR).",
    "explicacion_detallada": "En la Lista Roja de la UICN, 'En peligro crítico' indica que la especie enfrenta un riesgo extremadamente alto de extinción en estado silvestre en el futuro inmediato."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "La diversidad alfa ($\\alpha$) propuesta por Whittaker hace referencia a:",
    "opciones": [
      "A) La diversidad de especies a nivel regional o paisaje.",
      "B) El recambio de especies entre diferentes hábitats.",
      "C) La riqueza de especies dentro de una comunidad o hábitat específico local.",
      "D) La diversidad genética de una única población."
    ],
    "respuesta_correcta": "C) La riqueza de especies dentro de una comunidad o hábitat específico local.",
    "explicacion_detallada": "La diversidad alfa mide el número de especies (riqueza) en una localidad, sitio o comunidad particular, independiente de los ecosistemas circundantes."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Cuál de los siguientes es un claro ejemplo de sobreexplotación que amenaza la biodiversidad?",
    "opciones": [
      "A) La agricultura de subsistencia sin agroquímicos.",
      "B) La pesca incidental masiva y la captura pesquera por encima del rendimiento máximo sostenible.",
      "C) La reforestación con especies autóctonas.",
      "D) La construcción de corredores ecológicos."
    ],
    "respuesta_correcta": "B) La pesca incidental masiva y la captura pesquera por encima del rendimiento máximo sostenible.",
    "explicacion_detallada": "La sobreexplotación ocurre cuando se extraen individuos de una población a un ritmo mayor del que pueden reproducirse, como sucede con muchas pesquerías oceánicas."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "El uso de organismos vivos (como bacterias, hongos o plantas) para desintoxicar ecosistemas contaminados, ayudando a la conservación, se llama:",
    "opciones": [
      "A) Biorremediación.",
      "B) Bioaumentación.",
      "C) Eutrofización.",
      "D) Biomagnificación."
    ],
    "respuesta_correcta": "A) Biorremediación.",
    "explicacion_detallada": "La biorremediación emplea organismos metabólicamente activos para transformar contaminantes tóxicos del suelo o del agua en sustancias menos perjudiciales."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué es una especie 'indicadora' en ecología de la conservación?",
    "opciones": [
      "A) Una especie que atrae financiamiento para su conservación por ser carismática.",
      "B) Una especie cuya presencia, ausencia o abundancia refleja las condiciones ambientales y la salud del ecosistema.",
      "C) Una especie que ha sido introducida para marcar los límites de un parque nacional.",
      "D) Una especie extinta que indica las tasas históricas de extinción."
    ],
    "respuesta_correcta": "B) Una especie cuya presencia, ausencia o abundancia refleja las condiciones ambientales y la salud del ecosistema.",
    "explicacion_detallada": "Las especies indicadoras (como muchos anfibios o líquenes) son muy sensibles a cambios ambientales; su estudio permite evaluar la calidad o el nivel de contaminación de un hábitat."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "El fenómeno por el cual los contaminantes tóxicos no degradables aumentan su concentración en los tejidos de los organismos a medida que se asciende en la red trófica se denomina:",
    "opciones": [
      "A) Sucesión ecológica.",
      "B) Biorremediación.",
      "C) Biomagnificación.",
      "D) Resistencia ambiental."
    ],
    "respuesta_correcta": "C) Biomagnificación.",
    "explicacion_detallada": "La biomagnificación (o bioamplificación) hace que los depredadores tope (como aves rapaces o humanos) acumulen las mayores concentraciones de toxinas persistentes (como DDT o metales pesados), amenazando su conservación."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "¿Qué concepto describe a los países que albergan la mayor parte de la biodiversidad de la Tierra (aproximadamente el 70%) en su territorio?",
    "opciones": [
      "A) Países desarrollados biológicamente.",
      "B) Países megadiversos.",
      "C) Países de la biosfera.",
      "D) Países endémicos."
    ],
    "respuesta_correcta": "B) Países megadiversos.",
    "explicacion_detallada": "Los países megadiversos (como Brasil, Colombia, México, Indonesia, entre otros) son aquellos que albergan el mayor índice de biodiversidad de la Tierra debido a su latitud, topografía y biogeografía."
  },
  {
    "materia": "Biología",
    "codigo_tema": "3.1.3",
    "enunciado": "La conservación 'in situ' es la estrategia principal para preservar la biodiversidad. ¿Cuál de los siguientes es el mejor ejemplo de esta estrategia?",
    "opciones": [
      "A) Mantener semillas de todas las variedades de maíz en una bóveda congelada.",
      "B) Criar pandas gigantes en un zoológico para evitar su extinción.",
      "C) Establecer y manejar un Parque Nacional para proteger un bosque y sus especies nativas.",
      "D) Reproducir orquídeas raras en un invernadero comercial."
    ],
    "respuesta_correcta": "C) Establecer y manejar un Parque Nacional para proteger un bosque y sus especies nativas.",
    "explicacion_detallada": "La conservación in situ protege las especies dentro de su ambiente natural, manteniendo intactas las interacciones ecológicas y los procesos evolutivos, a través de áreas naturales protegidas."
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
  print('20 preguntas inyectadas para el código 3.1.3.');
}
