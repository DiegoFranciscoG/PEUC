import 'dart:convert';
import 'dart:io';

void main() {
  String jsonIn = r'''[
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿En qué estructura anatómica del sistema reproductor masculino se lleva a cabo la espermatogénesis?",
    "opciones": [
      "A) Epidídimo",
      "B) Túbulos seminíferos",
      "C) Conductos deferentes",
      "D) Vesículas seminales"
    ],
    "respuesta_correcta": "B) Túbulos seminíferos",
    "explicacion_detallada": "La espermatogénesis es el proceso de formación de espermatozoides y tiene lugar en la pared de los túbulos seminíferos, localizados dentro de los testículos."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Cuál es la función principal de las células de Leydig en los testículos?",
    "opciones": [
      "A) Nutrir a los espermatozoides en desarrollo",
      "B) Almacenar los espermatozoides maduros",
      "C) Secretar la hormona testosterona",
      "D) Producir líquido seminal alcalino"
    ],
    "respuesta_correcta": "C) Secretar la hormona testosterona",
    "explicacion_detallada": "Las células de Leydig, o células intersticiales, se ubican entre los túbulos seminíferos y, estimuladas por la hormona luteinizante (LH), producen y secretan testosterona."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿En qué momento de la vida de una mujer comienza la ovogénesis?",
    "opciones": [
      "A) En la pubertad",
      "B) Durante la vida embrionaria y fetal",
      "C) Inmediatamente antes de la primera menstruación",
      "D) Después de la primera fecundación"
    ],
    "respuesta_correcta": "B) Durante la vida embrionaria y fetal",
    "explicacion_detallada": "La ovogénesis inicia durante el desarrollo embrionario de la mujer, donde las ovogonias se transforman en ovocitos primarios que se detienen en la profase I de la meiosis hasta la pubertad."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "La ovulación es desencadenada directamente por un pico brusco en la secreción de una hormona hipofisaria. ¿Cuál es esta hormona?",
    "opciones": [
      "A) Hormona folículo estimulante (FSH)",
      "B) Estrógenos",
      "C) Progesterona",
      "D) Hormona luteinizante (LH)"
    ],
    "respuesta_correcta": "D) Hormona luteinizante (LH)",
    "explicacion_detallada": "Hacia el día 14 de un ciclo menstrual regular, se produce un pico agudo de hormona luteinizante (LH) que provoca la ruptura del folículo de De Graaf y la consiguiente liberación del ovocito secundario (ovulación)."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿En qué segmento del tracto reproductor femenino ocurre habitualmente la fecundación del ovocito secundario?",
    "opciones": [
      "A) Istmo de la trompa de Falopio",
      "B) Ampolla (tercio externo) de la trompa de Falopio",
      "C) Fondo del útero",
      "D) Endometrio basal"
    ],
    "respuesta_correcta": "B) Ampolla (tercio externo) de la trompa de Falopio",
    "explicacion_detallada": "La fecundación ocurre típicamente en la ampolla, la porción más ancha y externa de la trompa de Falopio, antes de que el embrión descienda hacia el útero."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "Después de la ovulación, el folículo roto se transforma en el cuerpo lúteo. ¿Cuál es la hormona principal que este cuerpo secreta para mantener el endometrio en fase secretora?",
    "opciones": [
      "A) Estradiol",
      "B) Prolactina",
      "C) Progesterona",
      "D) Gonadotropina coriónica humana"
    ],
    "respuesta_correcta": "C) Progesterona",
    "explicacion_detallada": "El cuerpo lúteo secreta altas cantidades de progesterona, la cual es crucial para preparar y mantener el endometrio uterino adecuado para la implantación del embrión."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿En qué etapa del desarrollo embrionario suele ocurrir la implantación en la mucosa uterina humana?",
    "opciones": [
      "A) Cigoto",
      "B) Mórula",
      "C) Gástrula",
      "D) Blastocisto"
    ],
    "respuesta_correcta": "D) Blastocisto",
    "explicacion_detallada": "La implantación generalmente se produce entre los días 6 y 7 posteriores a la fecundación, cuando el embrión se encuentra en la etapa de blastocisto, poseyendo una masa celular interna y el trofoblasto."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "La maduración final de los espermatozoides y la adquisición de su movilidad se produce durante su paso por una estructura tubular específica. ¿Cuál es?",
    "opciones": [
      "A) Túbulos rectos",
      "B) Red testicular (Rete testis)",
      "C) Epidídimo",
      "D) Conducto eyaculador"
    ],
    "respuesta_correcta": "C) Epidídimo",
    "explicacion_detallada": "Los espermatozoides producidos en los túbulos seminíferos son inmaduros e inmóviles; maduran y adquieren motilidad y capacidad fertilizante mientras transitan y se almacenan en el epidídimo."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Cuál de las siguientes capas del útero está constituida por músculo liso y es responsable de las contracciones durante el parto?",
    "opciones": [
      "A) Perimetrio",
      "B) Miometrio",
      "C) Endometrio funcional",
      "D) Endometrio basal"
    ],
    "respuesta_correcta": "B) Miometrio",
    "explicacion_detallada": "El miometrio es la capa muscular gruesa del útero, formada por haces de fibras musculares lisas, encargada de generar la fuerza contráctil durante el trabajo de parto."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "Durante la espermatogénesis, las células somáticas que actúan como sostén, nutren a las células germinales y forman la barrera hematotesticular se denominan:",
    "opciones": [
      "A) Células de Leydig",
      "B) Espermatogonias",
      "C) Células de Sertoli",
      "D) Espermátidas"
    ],
    "respuesta_correcta": "C) Células de Sertoli",
    "explicacion_detallada": "Las células de Sertoli son las células de sostén de los túbulos seminíferos; regulan el ambiente interno de estos túbulos, nutren a los espermatozoides en desarrollo y fagocitan el citoplasma residual."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "En la cabeza del espermatozoide se encuentra una estructura derivada del aparato de Golgi que contiene enzimas hidrolíticas esenciales para la penetración del ovocito. ¿Cómo se llama esta estructura?",
    "opciones": [
      "A) Centrosoma",
      "B) Pieza intermedia",
      "C) Flagelo",
      "D) Acrosoma"
    ],
    "respuesta_correcta": "D) Acrosoma",
    "explicacion_detallada": "El acrosoma es una vesícula situada en la porción apical de la cabeza del espermatozoide. Contiene hialuronidasa y acrosina, enzimas necesarias para degradar las envolturas del ovocito durante la fecundación."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Qué hormona es secretada por el sincitiotrofoblasto del embrión implantado para mantener activo el cuerpo lúteo durante el primer trimestre del embarazo?",
    "opciones": [
      "A) Oxitocina",
      "B) Gonadotropina coriónica humana (GCH)",
      "C) Hormona estimulante del tiroides (TSH)",
      "D) Relaxina"
    ],
    "respuesta_correcta": "B) Gonadotropina coriónica humana (GCH)",
    "explicacion_detallada": "La Gonadotropina Coriónica Humana (GCH) es la hormona que rescata al cuerpo lúteo de su degeneración, asegurando la producción continua de progesterona y estrógenos hasta que la placenta asuma esta función. Es la base biológica de los tests de embarazo."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Cómo se denomina la fase final de la espermatogénesis en la que las espermátidas redondas se diferencian estructuralmente en espermatozoides alargados sin división celular?",
    "opciones": [
      "A) Espermatocitogénesis",
      "B) Meiosis II",
      "C) Espermiogénesis",
      "D) Capacitación"
    ],
    "respuesta_correcta": "C) Espermiogénesis",
    "explicacion_detallada": "La espermiogénesis es la etapa de diferenciación y maduración morfológica en la que las espermátidas (haploides) se transforman en espermatozoides, desarrollando acrosoma y flagelo, perdiendo el exceso de citoplasma."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Qué glándula accesoria del sistema reproductor masculino secreta un líquido alcalino rico en ácido cítrico, enzimas proteolíticas y antígeno prostático específico (PSA)?",
    "opciones": [
      "A) Glándula bulbouretral (de Cowper)",
      "B) Próstata",
      "C) Vesícula seminal",
      "D) Glándula de Bartolino"
    ],
    "respuesta_correcta": "B) Próstata",
    "explicacion_detallada": "La próstata produce una secreción lechosa y ligeramente ácida/alcalina (rica en citrato y PSA) que constituye un 25-30% del volumen del semen y participa en su coagulación y licuefacción."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Cuál de las siguientes afirmaciones describe mejor el número de cromosomas en un espermatozoide y un óvulo humano maduros?",
    "opciones": [
      "A) Ambos son diploides (46 cromosomas)",
      "B) Ambos son haploides (23 cromosomas)",
      "C) El espermatozoide es haploide (23) y el óvulo diploide (46)",
      "D) El espermatozoide es diploide (46) y el óvulo haploide (23)"
    ],
    "respuesta_correcta": "B) Ambos son haploides (23 cromosomas)",
    "explicacion_detallada": "Los gametos humanos (espermatozoide y óvulo) son células haploides producidas por meiosis, por lo que contienen un solo juego de 23 cromosomas. Al fusionarse, restablecen el número diploide de 46 en el cigoto."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "Durante la primera mitad del ciclo uterino, el aumento progresivo del grosor del endometrio define la fase proliferativa. ¿Qué hormonas ováricas estimulan principalmente esta fase?",
    "opciones": [
      "A) Andrógenos",
      "B) Estrógenos",
      "C) Progesterona",
      "D) Inhibina"
    ],
    "respuesta_correcta": "B) Estrógenos",
    "explicacion_detallada": "En la fase folicular del ovario, los folículos en desarrollo secretan estrógenos que actúan sobre el útero promoviendo la fase proliferativa, regenerando la capa funcional del endometrio tras la menstruación."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Cuál es la función principal de las vesículas seminales en la conformación del semen?",
    "opciones": [
      "A) Aportar fructosa, prostaglandinas y fibrinógeno",
      "B) Producir los espermatozoides",
      "C) Secretar testosterona al torrente sanguíneo",
      "D) Lubricar la uretra previamente a la eyaculación"
    ],
    "respuesta_correcta": "A) Aportar fructosa, prostaglandinas y fibrinógeno",
    "explicacion_detallada": "Las vesículas seminales contribuyen con aproximadamente el 60% del volumen del semen. Su secreción es rica en fructosa (energía para los espermatozoides) y prostaglandinas (que causan contracciones uterinas)."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "La reacción cortical y la reacción de zona en el óvulo fecundado tienen un propósito fisiológico crítico. ¿Cuál es?",
    "opciones": [
      "A) Iniciar la primera división de segmentación",
      "B) Promover la implantación del cigoto",
      "C) Evitar la polispermia (fecundación por más de un espermatozoide)",
      "D) Activar el metabolismo mitocondrial del óvulo"
    ],
    "respuesta_correcta": "C) Evitar la polispermia (fecundación por más de un espermatozoide)",
    "explicacion_detallada": "La reacción cortical libera gránulos que modifican la zona pelúcida (reacción de zona), volviéndola impenetrable a otros espermatozoides y bloqueando la polispermia, asegurando que el cigoto sea diploide normal."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "En la fisiología reproductiva femenina, si el ovocito no es fecundado, la caída abrupta de ciertas hormonas causa isquemia y desprendimiento del endometrio funcional. ¿Qué par de hormonas descienden marcadamente para causar la menstruación?",
    "opciones": [
      "A) FSH y LH",
      "B) Estrógenos y progesterona",
      "C) Oxitocina y prolactina",
      "D) Cortisol y aldosterona"
    ],
    "respuesta_correcta": "B) Estrógenos y progesterona",
    "explicacion_detallada": "Si no hay embarazo, el cuerpo lúteo degenera, lo que provoca una drástica disminución en los niveles sanguíneos de estrógenos y progesterona, desencadenando los espasmos vasculares que causan la menstruación."
  },
  {
    "materia": "Anatomía y Fisiología",
    "codigo_tema": "3.3.2",
    "enunciado": "¿Qué tipo de epitelio reviste internamente las trompas de Falopio para facilitar el transporte del ovocito hacia el útero?",
    "opciones": [
      "A) Epitelio plano estratificado no queratinizado",
      "B) Epitelio cilíndrico simple ciliado",
      "C) Epitelio cúbico simple",
      "D) Epitelio pseudoestratificado con esterocilios"
    ],
    "respuesta_correcta": "B) Epitelio cilíndrico simple ciliado",
    "explicacion_detallada": "La mucosa de la trompa de Falopio presenta un epitelio cilíndrico simple con células ciliadas; el movimiento sincrónico de sus cilios, ayudado por la contracción muscular tubárica, desplaza al ovocito o embrión hacia la cavidad uterina."
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
  print('20 preguntas inyectadas para el código 3.3.2.');
}
