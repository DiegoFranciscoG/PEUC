import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué enzima es responsable del inicio de la digestión química de las proteínas en el estómago gracias al ambiente ácido proporcionado por el ácido clorhídrico?",
    "opciones": [
      "A) Amilasa",
      "B) Pepsina",
      "C) Lipasa",
      "D) Tripsina"
    ],
    "respuesta_correcta": "B) Pepsina",
    "explicacion_detallada": "La pepsina es la enzima principal del estómago que degrada las proteínas en péptidos más pequeños. Se secreta en forma inactiva (pepsinógeno) y se activa en presencia del ácido clorhídrico (HCl)."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿En qué segmento del tubo digestivo ocurre la mayor parte de la absorción de nutrientes, favorecida por la presencia de microvellosidades?",
    "opciones": [
      "A) Intestino grueso",
      "B) Estómago",
      "C) Intestino delgado",
      "D) Esófago"
    ],
    "respuesta_correcta": "C) Intestino delgado",
    "explicacion_detallada": "El intestino delgado es el principal órgano de absorción de nutrientes. Su superficie interna está plegada en vellosidades y microvellosidades que aumentan enormemente el área disponible para la absorción hacia el torrente sanguíneo."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cuál es la función principal de la bilis, producida por el hígado y almacenada en la vesícula biliar?",
    "opciones": [
      "A) Digerir los carbohidratos complejos",
      "B) Emulsionar las grasas para facilitar su digestión por las lipasas",
      "C) Neutralizar la acidez de la saliva",
      "D) Absorber las vitaminas hidrosolubles"
    ],
    "respuesta_correcta": "B) Emulsionar las grasas para facilitar su digestión por las lipasas",
    "explicacion_detallada": "La bilis no contiene enzimas digestivas, pero actúa como un emulsionante que rompe las grandes gotas de lípidos en gotitas más pequeñas, aumentando la superficie de acción para las enzimas lipasas pancreáticas."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Dónde comienza la digestión química de los carbohidratos en el sistema digestivo humano?",
    "opciones": [
      "A) En el estómago, por acción del ácido clorhídrico",
      "B) En el duodeno, por la amilasa pancreática",
      "C) En la boca, mediante la amilasa salival o ptialina",
      "D) En el intestino grueso, por la flora bacteriana"
    ],
    "respuesta_correcta": "C) En la boca, mediante la amilasa salival o ptialina",
    "explicacion_detallada": "La digestión de los almidones (carbohidratos) se inicia en la boca gracias a la amilasa salival, que rompe los enlaces de los polisacáridos convirtiéndolos en disacáridos como la maltosa."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué estructura actúa como válvula impidiendo que el bolo alimenticio ingrese a las vías respiratorias durante la deglución?",
    "opciones": [
      "A) La epiglotis",
      "B) El cardias",
      "C) El píloro",
      "D) La laringe"
    ],
    "respuesta_correcta": "A) La epiglotis",
    "explicacion_detallada": "La epiglotis es un cartílago en forma de hoja situado en la laringe que, durante la deglución, se pliega hacia abajo para cubrir la glotis, evitando que los alimentos pasen a la tráquea."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cuál es la unidad estructural y funcional básica del riñón responsable de la formación de la orina?",
    "opciones": [
      "A) El glomérulo",
      "B) La nefrona",
      "C) El uréter",
      "D) La pelvis renal"
    ],
    "respuesta_correcta": "B) La nefrona",
    "explicacion_detallada": "La nefrona es la unidad funcional del riñón. Cada riñón contiene aproximadamente un millón de nefronas, encargadas de filtrar la sangre y producir la orina mediante procesos de filtración, reabsorción y secreción."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿En qué parte de la nefrona se produce el primer paso de la formación de orina, donde el plasma sanguíneo es filtrado hacia el espacio capsular?",
    "opciones": [
      "A) El asa de Henle",
      "B) El túbulo contorneado proximal",
      "C) El corpúsculo renal (Glomérulo y Cápsula de Bowman)",
      "D) El túbulo colector"
    ],
    "respuesta_correcta": "C) El corpúsculo renal (Glomérulo y Cápsula de Bowman)",
    "explicacion_detallada": "La filtración glomerular ocurre en el corpúsculo renal, donde la presión sanguínea fuerza al agua y solutos pequeños a salir de los capilares glomerulares hacia la cápsula de Bowman."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué efecto principal tiene la hormona antidiurética (ADH) sobre la función renal?",
    "opciones": [
      "A) Aumenta la excreción de agua, produciendo una orina diluida",
      "B) Estimula la reabsorción de sodio en el túbulo proximal",
      "C) Aumenta la permeabilidad de los túbulos colectores al agua, concentrando la orina",
      "D) Inhibe la filtración glomerular contrayendo las arteriolas aferentes"
    ],
    "respuesta_correcta": "C) Aumenta la permeabilidad de los túbulos colectores al agua, concentrando la orina",
    "explicacion_detallada": "La ADH, liberada por la neurohipófisis, hace que las paredes del túbulo contorneado distal y el túbulo colector sean más permeables al agua, lo que incrementa su reabsorción hacia la sangre y reduce el volumen de orina."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cuál de las siguientes sustancias NO debería estar presente de manera significativa en la orina de un individuo sano?",
    "opciones": [
      "A) Urea",
      "B) Glucosa",
      "C) Ácido úrico",
      "D) Creatinina"
    ],
    "respuesta_correcta": "B) Glucosa",
    "explicacion_detallada": "En condiciones normales, toda la glucosa filtrada en el glomérulo es completamente reabsorbida en el túbulo contorneado proximal. Su presencia en la orina (glucosuria) suele ser indicativo de diabetes mellitus."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cuál es la función del asa de Henle en la fisiología renal?",
    "opciones": [
      "A) Crear un gradiente de concentración en la médula renal que permite la concentración de la orina",
      "B) Filtrar las proteínas de gran tamaño de la sangre",
      "C) Secretar iones de hidrógeno para regular el pH sanguíneo",
      "D) Sintetizar la hormona eritropoyetina"
    ],
    "respuesta_correcta": "A) Crear un gradiente de concentración en la médula renal que permite la concentración de la orina",
    "explicacion_detallada": "El asa de Henle actúa mediante un mecanismo multiplicador de contracorriente para establecer un gradiente osmótico elevado en el intersticio medular, esencial para que la orina pueda concentrarse posteriormente."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué cavidad del corazón recibe la sangre desoxigenada proveniente del cuerpo a través de las venas cavas?",
    "opciones": [
      "A) Aurícula izquierda",
      "B) Aurícula derecha",
      "C) Ventrículo izquierdo",
      "D) Ventrículo derecho"
    ],
    "respuesta_correcta": "B) Aurícula derecha",
    "explicacion_detallada": "La circulación sistémica retorna la sangre pobre en oxígeno desde los tejidos de todo el cuerpo hacia la aurícula derecha a través de la vena cava superior e inferior."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué vaso sanguíneo transporta sangre desoxigenada desde el ventrículo derecho hacia los pulmones?",
    "opciones": [
      "A) Vena pulmonar",
      "B) Arteria aorta",
      "C) Arteria pulmonar",
      "D) Vena cava"
    ],
    "respuesta_correcta": "C) Arteria pulmonar",
    "explicacion_detallada": "El tronco pulmonar y las arterias pulmonares son las únicas arterias que transportan sangre desoxigenada en el adulto, llevándola desde el corazón hacia los pulmones para su oxigenación."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cuál es la válvula ubicada entre la aurícula izquierda y el ventrículo izquierdo?",
    "opciones": [
      "A) Válvula tricúspide",
      "B) Válvula pulmonar",
      "C) Válvula mitral o bicúspide",
      "D) Válvula aórtica"
    ],
    "respuesta_correcta": "C) Válvula mitral o bicúspide",
    "explicacion_detallada": "La válvula mitral o bicúspide regula el flujo de sangre oxigenada desde la aurícula izquierda hacia el ventrículo izquierdo, impidiendo su retroceso durante la sístole ventricular."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Dónde se inicia normalmente el impulso eléctrico que regula el latido cardíaco (marcapasos natural)?",
    "opciones": [
      "A) Nódulo auriculoventricular (AV)",
      "B) Fibras de Purkinje",
      "C) Haz de His",
      "D) Nódulo sinoauricular (SA)"
    ],
    "respuesta_correcta": "D) Nódulo sinoauricular (SA)",
    "explicacion_detallada": "El nódulo sinoauricular, situado en la pared de la aurícula derecha, se despolariza espontáneamente generando los potenciales de acción que desencadenan la contracción cardíaca, estableciendo el ritmo sinusal."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué vasos sanguíneos son los principales encargados del intercambio de gases, nutrientes y desechos entre la sangre y los tejidos?",
    "opciones": [
      "A) Arteriolas",
      "B) Vénulas",
      "C) Capilares",
      "D) Arterias musculares"
    ],
    "respuesta_correcta": "C) Capilares",
    "explicacion_detallada": "Los capilares poseen paredes sumamente delgadas formadas por una sola capa de células endoteliales, lo que permite la difusión eficiente de sustancias entre la sangre y el líquido intersticial."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿En qué estructuras del sistema respiratorio se produce el intercambio de oxígeno y dióxido de carbono con la sangre?",
    "opciones": [
      "A) Bronquiolos terminales",
      "B) Alvéolos pulmonares",
      "C) Bronquios primarios",
      "D) Tráquea"
    ],
    "respuesta_correcta": "B) Alvéolos pulmonares",
    "explicacion_detallada": "Los alvéolos son diminutos sacos de aire rodeados de una red de capilares. Su fina pared facilita la difusión pasiva de gases (oxígeno hacia la sangre y CO2 hacia el alvéolo)."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué evento físico provoca la inspiración o entrada de aire a los pulmones?",
    "opciones": [
      "A) La relajación del diafragma y disminución del volumen torácico",
      "B) La contracción del diafragma y los músculos intercostales externos, aumentando el volumen torácico",
      "C) El aumento de la presión intrapleural por encima de la presión atmosférica",
      "D) La constricción de los bronquios"
    ],
    "respuesta_correcta": "B) La contracción del diafragma y los músculos intercostales externos, aumentando el volumen torácico",
    "explicacion_detallada": "Al contraerse, el diafragma desciende y los intercostales elevan las costillas, lo que aumenta el volumen de la cavidad torácica. Según la ley de Boyle, esto disminuye la presión pulmonar, permitiendo que el aire entre."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿De qué manera se transporta la mayor parte del oxígeno en la sangre desde los pulmones hacia los tejidos?",
    "opciones": [
      "A) Disuelto en el plasma sanguíneo",
      "B) Unido al grupo hemo de la hemoglobina en los eritrocitos",
      "C) Como ión bicarbonato en el plasma",
      "D) Unido a las proteínas plasmáticas como la albúmina"
    ],
    "respuesta_correcta": "B) Unido al grupo hemo de la hemoglobina en los eritrocitos",
    "explicacion_detallada": "Cerca del 98.5% del oxígeno se transporta unido reversiblemente al hierro del grupo hemo de las moléculas de hemoglobina dentro de los glóbulos rojos; el resto va disuelto en el plasma."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Cómo se transporta la mayor parte del dióxido de carbono (CO2) desde los tejidos hacia los pulmones?",
    "opciones": [
      "A) Disuelto directamente en el plasma",
      "B) Unido a la hemoglobina como carbaminohemoglobina",
      "C) En forma de iones bicarbonato (HCO3-) disueltos en el plasma",
      "D) Unido a plaquetas"
    ],
    "respuesta_correcta": "C) En forma de iones bicarbonato (HCO3-) disueltos en el plasma",
    "explicacion_detallada": "Aproximadamente el 70% del CO2 se transporta como ión bicarbonato. El CO2 reacciona con agua en los eritrocitos (catalizado por la anhidrasa carbónica) formando ácido carbónico, que luego se disocia en bicarbonato."
  },
  {
    "materia": "Ciencias Naturales",
    "codigo_tema": "3.3.1",
    "enunciado": "¿Qué centro del sistema nervioso central es el principal responsable de controlar el ritmo básico de la respiración?",
    "opciones": [
      "A) El cerebelo",
      "B) El hipotálamo",
      "C) El lóbulo frontal del cerebro",
      "D) El bulbo raquídeo (médula oblonga)"
    ],
    "respuesta_correcta": "D) El bulbo raquídeo (médula oblonga)",
    "explicacion_detallada": "El centro respiratorio principal se encuentra en el bulbo raquídeo, el cual envía impulsos nerviosos periódicos a los músculos respiratorios (diafragma e intercostales) para mantener el ciclo ventilatorio basal."
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
  print('20 preguntas inyectadas para el código 3.3.1.');
}
