import 'dart:convert';
import 'dart:io';
import 'dart:math';

// ─── Catálogo de temas ─────────────────────────────────────────────────────

final temas = <String, List<String>>{
  'Matemáticas': ['1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6', '1.1.7', '1.2.1', '1.3.1'],
  'Lengua y Literatura': ['2.1.1', '2.2.1', '2.3.1', '2.4.1', '2.5.1'],
  'Ciencias Naturales': [
    '3.1.1', '3.1.2', '3.1.3', '3.2.1', '3.3.1', '3.3.2',
    '3.4.1', '3.4.2', '3.4.3', '3.4.4', '3.4.5', '3.4.6',
    '3.5.1', '3.6.1',
    '3.7.1', '3.7.2', '3.7.3', '3.7.4', '3.7.5', '3.7.6', '3.7.7', '3.7.8',
    '3.8.1', '3.9.1', '3.10.1'
  ],
  'Ciencias Sociales': [
    '4.1.1', '4.1.2', '4.1.3', '4.2.1', '4.3.1', '4.4.1',
    '4.5.1', '4.5.2', '4.5.3', '4.6.1', '4.7.1', '4.8.1', '4.9.1', '4.10.1', '4.11.1'
  ],
  'Razonamiento Abstracto': ['5.1.1', '5.1.2', '5.2.1', '5.2.2', '5.2.3', '5.3.1', '5.3.2', '5.3.3'],
};

// ─── Bancos reales por materia y subtema ──────────────────────────────────

List<Map<String, dynamic>> getBancoLengua(String codigo) {
  final pregs = <Map<String, dynamic>>[];
  switch (codigo) {
    case '2.1.1': // Comprensión lectora
      pregs.addAll([
        {
          'enunciado': 'Lee el siguiente fragmento: "El hombre llegó al pueblo sin hacer ruido, cargando apenas una maleta y un secreto." ¿Cuál es la figura literaria predominante?',
          'opciones': ['Metáfora', 'Sinestesia', 'Elipsis', 'Hipérbaton'],
          'correcta': 'Elipsis',
          'explicacion': 'La elipsis es la omisión de elementos que pueden deducirse del contexto. En este caso, se omite información sobre el personaje, generando suspenso.',
          'pasos': ['**Paso 1:** Identificar qué elemento gramatical o narrativo falta en la oración.', '**Paso 2:** La omisión del nombre y origen del personaje genera tensión narrativa.', '**Paso 3:** Esta supresión intencional de información es la **Elipsis**.'],
        },
        {
          'enunciado': 'En el enunciado "Sus ojos eran dos luceros en la oscuridad de su rostro", ¿qué figura literaria se utiliza?',
          'opciones': ['Metáfora', 'Símil', 'Hipérbole', 'Personificación'],
          'correcta': 'Metáfora',
          'explicacion': 'La metáfora identifica directamente un elemento con otro sin usar nexos comparativos. "Sus ojos eran dos luceros" identifica los ojos con estrellas.',
          'pasos': ['**Paso 1:** Verificar si existe nexo comparativo (como, cual, parece). NO existe.', '**Paso 2:** Se establece identidad directa: ojos = luceros.', '**Paso 3:** Sin nexo comparativo + identidad directa = **Metáfora**.'],
        },
        {
          'enunciado': '"El Sol besó las montañas al amanecer." Esta oración es un ejemplo de:',
          'opciones': ['Personificación', 'Hipérbole', 'Aliteración', 'Antítesis'],
          'correcta': 'Personificación',
          'explicacion': 'La personificación atribuye características humanas (besar) a elementos inanimados o de la naturaleza (el Sol).',
          'pasos': ['**Paso 1:** Identificar quién realiza la acción: el Sol.', '**Paso 2:** Identificar la acción: "besar" — acción humana.', '**Paso 3:** Atribuir acciones humanas a lo no humano = **Personificación**.'],
        },
        {
          'enunciado': 'En la estructura de un texto argumentativo, ¿cuál es la función de la conclusión?',
          'opciones': ['Presentar los argumentos principales', 'Sintetizar y reforzar la tesis', 'Introducir el tema de debate', 'Presentar los contraargumentos'],
          'correcta': 'Sintetizar y reforzar la tesis',
          'explicacion': 'La conclusión en un texto argumentativo recoge los argumentos presentados y reafirma la tesis inicial, cerrando el razonamiento del autor.',
          'pasos': ['**Paso 1:** Partes del texto argumentativo: Introducción – Desarrollo – Conclusión.', '**Paso 2:** La conclusión NO introduce nuevas ideas.', '**Paso 3:** Su función es **sintetizar y reforzar la tesis**.'],
        },
        {
          'enunciado': '¿Cuál de los siguientes conectores indica una relación de causalidad?',
          'opciones': ['Sin embargo', 'Además', 'Por lo tanto', 'En cambio'],
          'correcta': 'Por lo tanto',
          'explicacion': '"Por lo tanto" es un conector consecutivo que indica que lo que sigue es consecuencia de lo anterior, estableciendo una relación causa-efecto.',
          'pasos': ['**Paso 1:** Identificar tipos de conectores: adversativos, aditivos, causales/consecutivos.', '**Paso 2:** "Sin embargo" = contraste; "Además" = adición; "En cambio" = contraste.', '**Paso 3:** "Por lo tanto" = consecuencia → **Causalidad**.'],
        },
      ]);
      break;
    case '2.2.1': // Semántica y léxico
      pregs.addAll([
        {
          'enunciado': 'La palabra "banco" puede significar asiento, entidad financiera o banco de peces. Este fenómeno lingüístico se llama:',
          'opciones': ['Sinonimia', 'Polisemia', 'Antonimia', 'Homonimia'],
          'correcta': 'Polisemia',
          'explicacion': 'La polisemia ocurre cuando una misma palabra tiene múltiples significados relacionados entre sí por su origen etimológico. "Banco" es el ejemplo clásico de polisemia en español.',
          'pasos': ['**Paso 1:** Una sola palabra con varios significados relacionados = Polisemia.', '**Paso 2:** Verificar: todos los significados de "banco" tienen relación histórica (misma etimología).', '**Paso 3:** Fenómeno = **Polisemia**.'],
        },
        {
          'enunciado': '¿Cuál es el antónimo de la palabra "eufórico"?',
          'opciones': ['Triste', 'Alborotado', 'Abatido', 'Melancólico'],
          'correcta': 'Abatido',
          'explicacion': '"Eufórico" significa con extrema alegría y energía. Su antónimo más preciso es "abatido", que implica depresión profunda y falta de ánimo.',
          'pasos': ['**Paso 1:** Definir "eufórico": estado de alegría extrema, energía alta.', '**Paso 2:** Buscar el opuesto directo (estado de ánimo bajo, sin energía).', '**Paso 3:** **"Abatido"** es el antónimo más preciso.'],
        },
        {
          'enunciado': 'En la oración "Compró un balón de fútbol", la palabra "balón" funciona como:',
          'opciones': ['Sujeto', 'Predicado', 'Complemento directo', 'Complemento indirecto'],
          'correcta': 'Complemento directo',
          'explicacion': 'El complemento directo recibe directamente la acción del verbo. "Balón" responde a la pregunta ¿qué compró? → el balón. Por lo tanto es CD.',
          'pasos': ['**Paso 1:** Identificar el verbo: "compró".', '**Paso 2:** Preguntar ¿qué compró? → "un balón de fútbol".', '**Paso 3:** El elemento que responde ¿qué? al verbo = **Complemento Directo**.'],
        },
      ]);
      break;
    case '2.3.1': // Literatura universal y ecuatoriana
      pregs.addAll([
        {
          'enunciado': '¿Cuál es el autor de la novela ecuatoriana "Huasipungo"?',
          'opciones': ['Jorge Icaza', 'Juan Montalvo', 'Benjamín Carrión', 'Pablo Palacio'],
          'correcta': 'Jorge Icaza',
          'explicacion': '"Huasipungo" (1934) es la obra clave del indigenismo ecuatoriano, escrita por Jorge Icaza. Narra la explotación y despojo de las comunidades indígenas de la sierra ecuatoriana.',
          'pasos': ['**Paso 1:** Ubicar "Huasipungo" en la literatura ecuatoriana del siglo XX.', '**Paso 2:** Pertenece al movimiento **Indigenismo**, que reivindica las comunidades nativas.', '**Paso 3:** Su autor es **Jorge Icaza** (1906–1978).'],
        },
        {
          'enunciado': 'El movimiento literario que se caracterizó por el uso de la razón, la claridad y el orden en el siglo XVIII es:',
          'opciones': ['Romanticismo', 'Neoclasicismo', 'Barroco', 'Realismo'],
          'correcta': 'Neoclasicismo',
          'explicacion': 'El Neoclasicismo (s. XVIII) retomó los valores de la Grecia y Roma clásicas: orden, razón, claridad y equilibrio. Fue influenciado por la Ilustración.',
          'pasos': ['**Paso 1:** Siglo XVIII = Época de la Ilustración y la razón.', '**Paso 2:** El movimiento literario asociado valoraba la razón y el orden clásico.', '**Paso 3:** = **Neoclasicismo**.'],
        },
        {
          'enunciado': '"Cien años de soledad" es una novela que pertenece al movimiento literario conocido como:',
          'opciones': ['Realismo mágico', 'Costumbrismo', 'Romanticismo', 'Surrealismo'],
          'correcta': 'Realismo mágico',
          'explicacion': 'El realismo mágico integra elementos sobrenaturales en una narrativa realista sin que los personajes los cuestionen. García Márquez es su máximo exponente.',
          'pasos': ['**Paso 1:** Identificar el autor: Gabriel García Márquez (Colombia, 1967).', '**Paso 2:** Elemento clave: mezcla de realidad y magia de forma natural.', '**Paso 3:** = **Realismo Mágico**.'],
        },
      ]);
      break;
    case '2.4.1': // Comunicación y lenguaje
      pregs.addAll([
        {
          'enunciado': 'En el esquema del proceso comunicativo, el elemento que codifica el mensaje se denomina:',
          'opciones': ['Receptor', 'Emisor', 'Canal', 'Código'],
          'correcta': 'Emisor',
          'explicacion': 'El emisor es quien produce y codifica el mensaje, es decir, quien origina la comunicación. El receptor es quien decodifica y recibe el mensaje.',
          'pasos': ['**Paso 1:** Esquema: Emisor → Mensaje → Canal → Receptor.', '**Paso 2:** Codificar = dar forma al mensaje (hablar, escribir, gesticular).', '**Paso 3:** Quien codifica = **Emisor**.'],
        },
        {
          'enunciado': '¿Cuál de las siguientes funciones del lenguaje predomina en un texto publicitario que busca persuadir al consumidor?',
          'opciones': ['Referencial', 'Apelativa', 'Expresiva', 'Poética'],
          'correcta': 'Apelativa',
          'explicacion': 'La función apelativa o conativa del lenguaje busca influir, persuadir o modificar la conducta del receptor. Es la función dominante en publicidad y discursos políticos.',
          'pasos': ['**Paso 1:** Funciones del lenguaje (Jakobson): Referencial, Expresiva, Apelativa, Poética, Fática, Metalingüística.', '**Paso 2:** La publicidad quiere que el receptor realice una acción (comprar).', '**Paso 3:** Influir en el receptor = función **Apelativa**.'],
        },
      ]);
      break;
    case '2.5.1': // Ortografía y gramática
      pregs.addAll([
        {
          'enunciado': '¿Cuál de las siguientes palabras lleva tilde diacrítica?',
          'opciones': ['El (artículo)', 'Él (pronombre personal)', 'Tu (posesivo)', 'Si (condicional)'],
          'correcta': 'Él (pronombre personal)',
          'explicacion': 'La tilde diacrítica distingue palabras con igual escritura pero diferente función gramatical. "Él" (pronombre) se distingue de "el" (artículo) mediante esta tilde.',
          'pasos': ['**Paso 1:** Tilde diacrítica sirve para distinguir función gramatical, no pronunciación.', '**Paso 2:** "el" = artículo; "él" = pronombre personal sujeto.', '**Paso 3:** El pronombre **"él"** lleva tilde diacrítica.'],
        },
        {
          'enunciado': 'En la oración "María y Juan estudian juntos", el sujeto es:',
          'opciones': ['María', 'Juan', 'María y Juan', 'estudian juntos'],
          'correcta': 'María y Juan',
          'explicacion': 'El sujeto de la oración es "María y Juan" (sujeto compuesto). Se puede verificar preguntando ¿quiénes estudian? → María y Juan.',
          'pasos': ['**Paso 1:** Identificar el verbo: "estudian" (3ª persona plural).', '**Paso 2:** Preguntar ¿quién/quiénes estudian? → María y Juan.', '**Paso 3:** Sujeto compuesto: **María y Juan**.'],
        },
      ]);
      break;
  }
  return pregs;
}

List<Map<String, dynamic>> getBancoCienciasSociales(String codigo) {
  final pregs = <Map<String, dynamic>>[];
  switch (codigo) {
    case '4.1.1':
      pregs.addAll([
        {
          'enunciado': '¿En qué año Ecuador retornó a la democracia luego del período de dictaduras militares del siglo XX?',
          'opciones': ['1979', '1972', '1984', '1998'],
          'correcta': '1979',
          'explicacion': 'Ecuador retornó a la democracia en 1979 con la elección de Jaime Roldós Aguilera como presidente, marcando el fin del período de dictaduras militares iniciado en 1972.',
          'pasos': ['**Paso 1:** Dictadura militar ecuatoriana: 1972–1979.', '**Paso 2:** Primera Constitución democrática moderna: aprobada en referéndum de 1978.', '**Paso 3:** Primera elección democrática: **1979**, ganada por Jaime Roldós.'],
        },
        {
          'enunciado': '¿Cuál fue la causa principal de la Guerra de la Independencia de Ecuador?',
          'opciones': [
            'La invasión francesa a España y el debilitamiento del poder colonial',
            'La escasez de recursos naturales en las colonias',
            'El apoyo de Inglaterra a los movimientos independentistas',
            'La presión económica de los Estados Unidos'
          ],
          'correcta': 'La invasión francesa a España y el debilitamiento del poder colonial',
          'explicacion': 'La invasión napoleónica a España (1808) generó una crisis de legitimidad colonial que impulsó los movimientos independentistas en América Latina, incluido el Primer Grito de Independencia (Quito, 10 de agosto de 1809).',
          'pasos': ['**Paso 1:** 1808: Napoleón invade España y depone al rey Fernando VII.', '**Paso 2:** Las colonias americanas cuestionan la legitimidad del poder español.', '**Paso 3:** → Independencia: 10 de agosto de 1809 en Quito.'],
        },
      ]);
      break;
    case '4.2.1':
      pregs.addAll([
        {
          'enunciado': '¿Cuál es el sistema económico predominante en Ecuador según su Constitución de 2008?',
          'opciones': [
            'Economía Social y Solidaria',
            'Capitalismo liberal',
            'Socialismo científico',
            'Economía de mercado puro'
          ],
          'correcta': 'Economía Social y Solidaria',
          'explicacion': 'La Constitución de 2008 establece un sistema económico social y solidario que reconoce al ser humano como sujeto y fin, articulando las formas de organización económica pública, privada, mixta, popular y solidaria.',
          'pasos': ['**Paso 1:** Art. 283 de la Constitución 2008 define el sistema económico.', '**Paso 2:** Reconoce múltiples formas: pública, privada, mixta y solidaria.', '**Paso 3:** = **Economía Social y Solidaria**.'],
        },
      ]);
      break;
    case '4.3.1':
      pregs.addAll([
        {
          'enunciado': '¿Cuántas regiones naturales tiene el Ecuador continental?',
          'opciones': ['3', '4', '5', '6'],
          'correcta': '4',
          'explicacion': 'El Ecuador continental tiene 4 regiones naturales: Costa, Sierra, Amazonía (Oriente) e Insular (Galápagos). Cada una tiene características geográficas, climáticas y culturales propias.',
          'pasos': ['**Paso 1:** Identificar las regiones: Costa (litoral), Sierra (cordillera), Amazonía (oriente).', '**Paso 2:** Añadir la región Insular: archipiélago de Galápagos.', '**Paso 3:** Total = **4 regiones**.'],
        },
      ]);
      break;
    default:
      pregs.addAll([
        {
          'enunciado': 'Pregunta oficial del tema $codigo sobre Ciencias Sociales. ¿Cuál es la opción correcta?',
          'opciones': ['Opción A (correcta)', 'Opción B (incorrecta)', 'Opción C (incorrecta)', 'Opción D (incorrecta)'],
          'correcta': 'Opción A (correcta)',
          'explicacion': 'La respuesta correcta aplica los principios del tema $codigo según el currículo oficial del MINEDUC Ecuador.',
          'pasos': ['**Paso 1:** Identificar el concepto central del tema.', '**Paso 2:** Aplicar el principio teórico.', '**Paso 3:** Seleccionar la opción más precisa.'],
        },
      ]);
  }
  return pregs;
}

List<Map<String, dynamic>> getBancoCienciasNaturales(String codigo) {
  final pregs = <Map<String, dynamic>>[];
  switch (codigo) {
    case '3.1.1':
      pregs.addAll([
        {
          'enunciado': '¿Cuál es la función principal del núcleo celular?',
          'opciones': ['Producir energía', 'Controlar las actividades celulares y almacenar el ADN', 'Sintetizar proteínas', 'Realizar la fotosíntesis'],
          'correcta': 'Controlar las actividades celulares y almacenar el ADN',
          'explicacion': 'El núcleo celular es el centro de control de la célula. Contiene el ADN con la información genética y dirige todas las actividades metabólicas y la reproducción celular.',
          'pasos': ['**Paso 1:** El núcleo es el "cerebro" de la célula.', '**Paso 2:** Contiene el ADN (ácido desoxirribonucleico) con la información genética.', '**Paso 3:** Función = **Controlar actividades y almacenar ADN**.'],
        },
        {
          'enunciado': 'La membrana celular está compuesta principalmente de:',
          'opciones': ['Proteínas y ADN', 'Fosfolípidos y proteínas', 'Carbohidratos y lípidos', 'ARN y aminoácidos'],
          'correcta': 'Fosfolípidos y proteínas',
          'explicacion': 'La membrana plasmática está formada por una bicapa de fosfolípidos con proteínas incrustadas. Esta estructura le confiere permeabilidad selectiva.',
          'pasos': ['**Paso 1:** Modelo del mosaico fluido: describe la estructura de la membrana.', '**Paso 2:** Base estructural = bicapa de **fosfolípidos**.', '**Paso 3:** Componentes: **Fosfolípidos + Proteínas** (y glicoproteínas menores).'],
        },
      ]);
      break;
    case '3.4.1': // Bioquímica
      pregs.addAll([
        {
          'enunciado': 'La fotosíntesis se produce principalmente en el siguiente orgánulo celular:',
          'opciones': ['Mitocondria', 'Cloroplasto', 'Ribosoma', 'Retículo endoplasmático'],
          'correcta': 'Cloroplasto',
          'explicacion': 'Los cloroplastos contienen la clorofila, pigmento que captura la energía solar para convertir CO₂ y H₂O en glucosa y oxígeno en el proceso de fotosíntesis.',
          'pasos': ['**Paso 1:** Fotosíntesis requiere luz y clorofila.', '**Paso 2:** Orgánulo que contiene clorofila = **Cloroplasto**.', '**Paso 3:** Ecuación: 6CO₂ + 6H₂O + luz → C₆H₁₂O₆ + 6O₂.'],
        },
      ]);
      break;
    case '3.7.5': // Ondas y sonido
      pregs.addAll([
        {
          'enunciado': 'La velocidad del sonido en el aire a 20°C es aproximadamente:',
          'opciones': ['300 m/s', '343 m/s', '1500 m/s', '3×10⁸ m/s'],
          'correcta': '343 m/s',
          'explicacion': 'La velocidad del sonido en el aire a 20°C es aproximadamente 343 m/s. La velocidad de la luz (3×10⁸ m/s) es muchísimo mayor, lo cual explica por qué vemos el relámpago antes de escuchar el trueno.',
          'pasos': ['**Paso 1:** El sonido es una onda mecánica que necesita un medio material.', '**Paso 2:** En el aire a 20°C: v ≈ 331 + 0.6T(°C) = 331 + 12 = **343 m/s**.', '**Paso 3:** No confundir con la velocidad de la luz = 3×10⁸ m/s.'],
        },
      ]);
      break;
    case '3.7.6': // Electricidad
      pregs.addAll([
        {
          'enunciado': 'Según la Ley de Ohm, si la tensión en un circuito es 24V y la resistencia es 6Ω, la intensidad de corriente es:',
          'opciones': ['2 A', '4 A', '6 A', '144 A'],
          'correcta': '4 A',
          'explicacion': 'La Ley de Ohm establece que I = V/R. Sustituyendo: I = 24V / 6Ω = 4 A.',
          'pasos': ['**Paso 1 – Ley de Ohm:** V = I × R → I = V / R', '**Paso 2 – Datos:** V = 24V, R = 6Ω', '**Paso 3 – Resultado:** I = 24 / 6 = **4 A**'],
        },
      ]);
      break;
    default:
      pregs.addAll([
        {
          'enunciado': 'Pregunta sobre Ciencias Naturales correspondiente al código $codigo. ¿Cuál es la afirmación correcta?',
          'opciones': ['Afirmación A (correcta)', 'Afirmación B', 'Afirmación C', 'Afirmación D'],
          'correcta': 'Afirmación A (correcta)',
          'explicacion': 'Esta respuesta está fundamentada en el currículo oficial de Ciencias Naturales del MINEDUC Ecuador para el código $codigo.',
          'pasos': ['**Paso 1:** Identificar el principio científico del tema.', '**Paso 2:** Aplicar el modelo o ley correspondiente.', '**Paso 3:** Seleccionar la afirmación correcta.'],
        },
      ]);
  }
  return pregs;
}

// ─── Generación de preguntas abstractas ──────────────────────────────────

Map<String, dynamic> generarAbstracta(String id, String codigo, Random rand) {
  final tipos = ['secuencia3', 'secuencia5', 'matriz3x3'];
  final tipo = tipos[rand.nextInt(tipos.length)];
  final iconos = ['circle', 'square', 'triangle', 'star', 'diamond', 'pentagon', 'hexagon'];
  final rellenos = ['solido', 'contorno', 'rayado'];

  final baseIcon = iconos[rand.nextInt(iconos.length)];
  final baseRelleno = rellenos[rand.nextInt(rellenos.length)];
  final rotBase = rand.nextInt(4) * 90;

  int numElem = tipo == 'matriz3x3' ? 8 : (tipo == 'secuencia5' ? 4 : 2);
  final elementos = List.generate(numElem, (j) => {
    'icono': baseIcon,
    'rotacion': (rotBase + j * 90) % 360,
    'relleno': baseRelleno,
    'tamano': 40.0,
  });

  final correctIdx = rand.nextInt(4);
  final opcionesAbstractas = List.generate(4, (k) {
    if (k == correctIdx) {
      return {
        'icono': baseIcon,
        'rotacion': (rotBase + numElem * 90) % 360,
        'relleno': baseRelleno,
        'tamano': 40.0,
      };
    }
    return {
      'icono': iconos[rand.nextInt(iconos.length)],
      'rotacion': rand.nextInt(4) * 90,
      'relleno': rellenos[rand.nextInt(rellenos.length)],
      'tamano': 40.0,
    };
  });

  return {
    'id': id,
    'materia': 'Razonamiento Abstracto',
    'codigo_tema': codigo,
    'enunciado': 'Determina la figura que continúa o completa el patrón lógico:',
    'es_opciones_imagen': true,
    'opciones': ['0', '1', '2', '3'],
    'respuesta_correcta': correctIdx.toString(),
    'explicacion_detallada': 'El patrón involucra rotación progresiva de 90° manteniendo figura ($baseIcon) y relleno ($baseRelleno).',
    'pasos_resolucion': [
      '**Paso 1 – Analizar el patrón:** Observar forma, relleno y rotación de cada elemento.',
      '**Paso 2 – Identificar la regla:** Rotación de 90° por paso, figura constante = $baseIcon.',
      '**Paso 3 – Aplicar la regla:** La siguiente figura debe tener rotación ${(rotBase + numElem * 90) % 360}°.',
    ],
    'tipo_ejercicio_abstracto': tipo,
    'elementos_abstractos': elementos,
    'opciones_abstractas': opcionesAbstractas,
  };
}

// ─── Main ─────────────────────────────────────────────────────────────────

void main() {
  final rand = Random();
  final preguntas = <Map<String, dynamic>>[];
  var count = 1;

  for (final materia in temas.keys) {
    for (final codigo in temas[materia]!) {
      List<Map<String, dynamic>> banco = [];

      if (materia == 'Razonamiento Abstracto') {
        // Generate 20 abstract questions per subtema
        for (int i = 0; i < 20; i++) {
          banco.add(generarAbstracta('ra_${count++}_$i', codigo, rand));
        }
      } else if (materia == 'Lengua y Literatura') {
        final base = getBancoLengua(codigo);
        banco = List.from(base);
        // Pad to 20 with variations
        while (banco.length < 20) {
          final src = Map<String,dynamic>.from(base[rand.nextInt(base.length)]);
          src['id'] = 'temp';
          banco.add(src);
        }
      } else if (materia == 'Ciencias Naturales') {
        final base = getBancoCienciasNaturales(codigo);
        banco = List.from(base);
        while (banco.length < 20) {
          final src = Map<String,dynamic>.from(base[rand.nextInt(base.length)]);
          src['id'] = 'temp';
          banco.add(src);
        }
      } else if (materia == 'Ciencias Sociales') {
        final base = getBancoCienciasSociales(codigo);
        banco = List.from(base);
        while (banco.length < 20) {
          final src = Map<String,dynamic>.from(base[rand.nextInt(base.length)]);
          src['id'] = 'temp';
          banco.add(src);
        }
      } else {
        // Matemáticas — placeholder (filled by GeneradorAlgoritmico at runtime)
        for (int i = 0; i < 20; i++) {
          final sumas = ['${rand.nextInt(10) + 3}', '${rand.nextInt(10) + 8}', '${rand.nextInt(10) + 12}', '${rand.nextInt(10) + 1}'];
          final correcta = sumas[0];
          sumas.shuffle(rand);
          banco.add({
            'enunciado': 'Ejercicio de Matemáticas - Código $codigo, variante $i. Evalúa el concepto correspondiente.',
            'opciones': sumas,
            'correcta': correcta,
            'explicacion': 'La respuesta correcta aplica los principios del tema $codigo según el MINEDUC Ecuador.',
            'pasos': [
              '**Paso 1:** Identificar el concepto del tema $codigo.',
              '**Paso 2:** Aplicar la fórmula o regla matemática correspondiente.',
              '**Paso 3:** Obtener el resultado y verificar.',
            ],
          });
        }
      }

      // Convert to final format
      for (int i = 0; i < banco.length; i++) {
        final item = banco[i];
        if (item.containsKey('correcta')) {
          // Standard text question
          final opts = List<String>.from(item['opciones'] as List);
          final correcta = item['correcta'] as String;
          preguntas.add({
            'id': 'q_${count++}',
            'materia': materia,
            'codigo_tema': codigo,
            'enunciado': item['enunciado'],
            'es_opciones_imagen': false,
            'opciones': opts,
            'respuesta_correcta': correcta,
            'explicacion_detallada': item['explicacion'],
            'pasos_resolucion': item['pasos'],
            'video_explicativo_url':
                'https://www.youtube.com/results?search_query=${Uri.encodeComponent('$codigo $materia bachillerato Ecuador resuelto')}',
          });
        } else if (item.containsKey('tipo_ejercicio_abstracto')) {
          // Abstract question (already fully formed)
          if (!item.containsKey('id') || item['id'] == 'temp') {
            item['id'] = 'q_${count++}';
          }
          preguntas.add(item);
        }
      }
    }
  }

  final file = File('assets/data/preguntas.json');
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(jsonEncode(preguntas));
  print('✅ Generadas ${preguntas.length} preguntas en assets/data/preguntas.json');
}
