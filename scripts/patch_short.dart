import 'dart:convert';
import 'dart:io';

void main() {
  // Patch 4.5.1 with 1 extra question
  final patch451 = [
    {
      "materia": "Ciencias Sociales",
      "codigo_tema": "4.5.1",
      "enunciado": "La ingeniería romana es considerada una de las más avanzadas de la antigüedad. El Acueducto de Segovia (España), construido entre los siglos I y II d.C., sigue en pie hoy. ¿Cuál era la innovación técnica clave que permitía a Roma construir estos acueductos de largas distancias sin bombas mecánicas?",
      "opciones": [
        "El diseño de una pendiente uniforme y calculada (entre 0.1% y 0.3%) desde la fuente hasta la ciudad destino, aprovechando exclusivamente la gravedad para mover el agua durante decenas de kilómetros.",
        "El uso de presas de vapor rudimentarias que calentaban el agua para crear presión suficiente para moverla cuesta arriba por los acueductos.",
        "La instalación de ruedas hidráulicas cada kilómetro que bombeaban el agua entre cada sección del acueducto de forma manual.",
        "El descubrimiento de que el agua fluye naturalmente de oeste a este en el hemisferio norte, por lo que todos los acueductos romanos fueron construidos en esa dirección."
      ],
      "respuesta_correcta": "El diseño de una pendiente uniforme y calculada (entre 0.1% y 0.3%) desde la fuente hasta la ciudad destino, aprovechando exclusivamente la gravedad para mover el agua durante decenas de kilómetros.",
      "explicacion_detallada": "Los ingenieros romanos (agrimensores) calculaban con precisión las diferencias de altitud entre la fuente y el destino. La pendiente debía ser suficiente para mantener el flujo sin erosionar el canal, pero no tan pronunciada que generara presiones excesivas. El agua fluía por gradiente gravitacional puro, sin ninguna bomba mecánica. Los puentes-acueducto (como el de Segovia o el Pont du Gard en Francia) eran soluciones de ingeniería para mantener el nivel del canal cuando el terreno era bajo, garantizando la continuidad de la pendiente calculada.",
      "pasos_resolucion": [
        "Identificar el principio básico: gravedad, sin bombas mecánicas.",
        "Comprender el rol del agrimensore: cálculo preciso de la pendiente uniforme (0.1-0.3%).",
        "Reconocer el Acueducto de Segovia como ejemplo clásico de este principio en funcionamiento durante casi 2 milenios."
      ],
      "video_explicativo_url": "https://www.youtube.com/results?search_query=Acueducto+romano+Segovia+ingenieria+pendiente+gravedad"
    }
  ];

  final patch481 = [
    {
      "materia": "Ciencias Sociales",
      "codigo_tema": "4.8.1",
      "enunciado": "El movimiento cartista (Chartism, 1838-1857) fue el primer movimiento obrero de masas de la historia. Sus demandas se articulaban en la 'People's Charter' (Carta del Pueblo) de 1838. ¿Cuáles eran sus seis exigencias fundamentales?",
      "opciones": [
        "Sufragio universal masculino, voto secreto, circunscripciones electorales iguales, pago de salario a los parlamentarios, abolición del requisito de propiedad para ser parlamentario y parlamentos anuales.",
        "Jornada laboral de 8 horas, salario mínimo nacional, abolición del trabajo infantil, sindicatos legales, seguro de desempleo y voto femenino.",
        "Abolición de la monarquía, república parlamentaria, sufragio universal incluyendo mujeres y esclavos libertos, separación Iglesia-Estado y libre comercio.",
        "Nacionalización de las minas y ferrocarriles, semana laboral de 5 días, educación pública gratuita hasta los 14 años, pensión de vejez y derecho a huelga."
      ],
      "respuesta_correcta": "Sufragio universal masculino, voto secreto, circunscripciones electorales iguales, pago de salario a los parlamentarios, abolición del requisito de propiedad para ser parlamentario y parlamentos anuales.",
      "explicacion_detallada": "El Cartismo fue un movimiento político-social de la clase trabajadora que canalizó su descontento no solo en términos laborales sino en términos de representación política. La exclusión de los trabajadores del derecho al voto (la Reform Act de 1832 solo había extendido el voto a la clase media con propiedades) era percibida como la causa estructural de su marginación. Las seis demandas de la People's Charter eran esencialmente reformas democráticas, no socialistas. Para entonces, ninguna se había logrado todavía; cinco de las seis se lograron en las décadas siguientes (solo los parlamentos anuales nunca se aprobaron).",
      "pasos_resolucion": [
        "Identificar el Cartismo como movimiento político de la clase trabajadora (no solo sindical).",
        "Memorizar las 6 demandas clave: voto masculino universal, voto secreto, circunscripciones iguales, pago a parlamentarios, sin requisito de propiedad, parlamentos anuales.",
        "Relacionar estas demandas con la exclusión de los trabajadores del sistema político de la Reform Act de 1832."
      ],
      "video_explicativo_url": "https://www.youtube.com/results?search_query=Cartismo+Chartism+Carta+del+Pueblo+1838+demandas"
    },
    {
      "materia": "Ciencias Sociales",
      "codigo_tema": "4.8.1",
      "enunciado": "La Revolución Industrial transformó la estructura familiar y los roles de género. ¿Cuál fue el impacto específico de la industrialización sobre el rol de la mujer de la clase trabajadora en contraste con la mujer de la clase media (burguesía)?",
      "opciones": [
        "Las mujeres obreras participaron masivamente en las fábricas con salarios inferiores a los hombres, mientras que el ideal burgués de la 'mujer del hogar' (la 'ángel del hogar' victoriana) excluía a las mujeres de clase media del trabajo remunerado como marca de estatus.",
        "Tanto las mujeres obreras como las burguesas fueron igualmente excluidas del trabajo industrial por las leyes de protección femenina aprobadas en 1820.",
        "Las mujeres burguesas lideraron la industrialización como empresarias y directoras de fábricas, mientras que las mujeres obreras permanecieron en el hogar cuidando a sus hijos.",
        "La Revolución Industrial igualó la situación de todas las mujeres sin distinción de clase, ya que todas podían votar y acceder a los mismos empleos desde 1833."
      ],
      "respuesta_correcta": "Las mujeres obreras participaron masivamente en las fábricas con salarios inferiores a los hombres, mientras que el ideal burgués de la 'mujer del hogar' ('ángel del hogar' victoriana) excluía a las mujeres de clase media del trabajo remunerado como marca de estatus.",
      "explicacion_detallada": "La división de género en la era industrial fue profundamente clasista. Las mujeres de la clase trabajadora siempre habían trabajado (en campo, servicio doméstico, manufacturas) y en la industria siguieron haciéndolo en las hilaturas y fábricas textiles, pero con salarios entre un tercio y la mitad de los masculinos. En cambio, la burguesía desarrolló el ideal de la 'domesticidad' (Sarah Ellis, 'Ángel del Hogar'): una mujer burguesa que trabajaba revelaba que su marido no ganaba suficiente, lo que era un estigma social. Esto creó dos regímenes de género radicalmente diferentes según la clase.",
      "pasos_resolucion": [
        "Distinguir las dos situaciones: mujer obrera (trabajo fabril forzoso por necesidad económica) vs. mujer burguesa (domesticidad como ideal y marca de estatus).",
        "Identificar el concepto de 'ángel del hogar' y la literatura prescriptiva victoriana.",
        "Comprender la paradoja: la industrialización tanto integró (obreras) como excluyó (burguesas) a las mujeres del trabajo remunerado, dependiendo de la clase."
      ],
      "video_explicativo_url": "https://www.youtube.com/results?search_query=Mujer+clase+obrera+burguesia+Revolucion+Industrial+angel+del+hogar"
    }
  ];

  final patch4101 = [
    {
      "materia": "Ciencias Sociales",
      "codigo_tema": "4.10.1",
      "enunciado": "El sistema de castas colonial en la América española establecía una jerarquía social basada principalmente en el origen étnico. ¿Qué nombre recibía el sistema pictórico que representaba visualmente las distintas categorías raciales resultantes de la mezcla?",
      "opciones": [
        "Los 'cuadros de castas' (pintura de castas): representaciones artísticas que mostraban las diferentes combinaciones de parejas de distintos orígenes (español+indígena=mestizo, español+negro=mulato, etc.) y sus descendientes, codificando visualmente la jerarquía racial colonial.",
        "Los 'escudos de linaje': documentos heráldicos que registraban el árbol genealógico de cada familia para demostrar la 'limpieza de sangre' ante las instituciones coloniales.",
        "Los 'padrones de tributación': registros administrativos que clasificaban a la población según su capacidad de pago, usando el color de piel como indicador auxiliar de la riqueza.",
        "Los 'libros de bautismo raciales': registros eclesiásticos donde los sacerdotes anotaban el color de piel exacto de cada bautizado para determinar si debía pagar diezmo pleno o reducido."
      ],
      "respuesta_correcta": "Los 'cuadros de castas' (pintura de castas): representaciones artísticas que mostraban las diferentes combinaciones de parejas de distintos orígenes (español+indígena=mestizo, español+negro=mulato, etc.) y sus descendientes, codificando visualmente la jerarquía racial colonial.",
      "explicacion_detallada": "La 'pintura de castas' fue un género pictórico propiamente americano del siglo XVIII, especialmente desarrollado en Nueva España (México). Típicamente se presentaba en series de 16 cuadros que mostraban parejas de diferentes categorías raciales y el hijo resultante, con una leyenda que nombraba la casta ('De español e india, mestizo', 'De negro e india, lobo', etc.). Aunque tenían una función aparentemente descriptiva o 'científica', en realidad legitimaban y naturalizaban la jerarquía social colonial basada en el origen étnico. Son documentos excepcionales para estudiar la ideología racial novohispana del siglo XVIII.",
      "pasos_resolucion": [
        "Identificar el género artístico: 'pintura de castas', un género propiamente novohispano del siglo XVIII.",
        "Describir su estructura: series de 16 cuadros con parejas de diferentes orígenes étnicos y sus descendientes nombrados.",
        "Analizar su función ideológica: naturalizar y legitimar visualmente la jerarquía racial colonial."
      ],
      "video_explicativo_url": "https://www.youtube.com/results?search_query=Pintura+de+castas+colonial+novohispana+sistema+castas"
    },
    {
      "materia": "Ciencias Sociales",
      "codigo_tema": "4.10.1",
      "enunciado": "La 'Noche Triste' (30 de junio de 1520) fue un episodio dramático en la conquista de México. ¿Qué ocurrió esa noche y cuál fue su consecuencia estratégica para Cortés?",
      "opciones": [
        "Los mexicas atacaron por sorpresa a los españoles que intentaban escapar de Tenochtitlan cargados con el tesoro de Moctezuma; murieron cientos de españoles y miles de aliados tlaxcaltecas, pero Cortés sobrevivió, reorganizó su ejército y regresó para el asedio final de la ciudad.",
        "Cortés fue capturado por los mexicas durante una emboscada nocturna en los canales de Tenochtitlan, y fue sacrificado en el Templo Mayor junto con todos sus capitanes principales.",
        "El ejército español sufrió una epidemia masiva de malaria que mató al 90% de sus efectivos en una sola noche, obligando al resto a firmar la paz con Moctezuma.",
        "Los aliados tlaxcaltecas traicionaron a Cortés por la noche y se pasaron al bando mexica, dejando a los españoles completamente solos frente al ejército de Tenochtitlan."
      ],
      "respuesta_correcta": "Los mexicas atacaron por sorpresa a los españoles que intentaban escapar de Tenochtitlan cargados con el tesoro de Moctezuma; murieron cientos de españoles y miles de aliados tlaxcaltecas, pero Cortés sobrevivió, reorganizó su ejército y regresó para el asedio final de la ciudad.",
      "explicacion_detallada": "Tras la matanza del Templo Mayor (ordenada por Alvarado) y la muerte de Moctezuma, la situación de los españoles en Tenochtitlan se volvió insostenible. La noche del 30 de junio de 1520, Cortés intentó escapar de la ciudad con todo el tesoro. Los mexicas los detectaron y atacaron en los puentes-calzada. Murieron entre 450 y 800 españoles (casi el 45% de sus efectivos) y miles de tlaxcaltecas, y se perdió todo el oro. Cortés reorganizó sus fuerzas en Tlaxcala y regresó un año después con un ejército mayor para el asedio de 75 días que destruyó Tenochtitlan.",
      "pasos_resolucion": [
        "Situar el contexto: los españoles atrapados en Tenochtitlan tras la matanza del Templo Mayor y la muerte de Moctezuma.",
        "Describir el evento: huida nocturna, descubrimiento mexica, ataque en las calzadas, pérdida del tesoro y gran parte del ejército.",
        "Identificar la consecuencia: reorganización en Tlaxcala y regreso para el asedio final de 1521."
      ],
      "video_explicativo_url": "https://www.youtube.com/results?search_query=Noche+Triste+Cortés+Tenochtitlan+1520"
    }
  ];

  // Inject 4.5.1 patch
  final main = 'assets/data/preguntas.json';
  final mainContent = File(main).readAsStringSync();
  List<dynamic> preguntas = jsonDecode(mainContent);
  preguntas.addAll(patch451);
  preguntas.addAll(patch481);
  preguntas.addAll(patch4101);
  File(main).writeAsStringSync(jsonEncode(preguntas));
  
  print('✅ Parches inyectados: 1 para 4.5.1, 2 para 4.8.1, 2 para 4.10.1');
}
