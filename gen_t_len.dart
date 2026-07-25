import 'dart:convert';
import 'dart:io';

void main() {
  final List<Map<String, dynamic>> data = [
    {
      "codigo_tema": "2.1.1",
      "materia": "Lengua y Literatura",
      "titulo": "Comunicación Oral y Escrita",
      "contenido_markdown": r'''### Introducción
La comunicación es el proceso mediante el cual los seres humanos intercambian información, ideas, sentimientos y significados. Dentro del amplio espectro de la comunicación humana, destacan dos modalidades fundamentales: la comunicación oral y la comunicación escrita. Ambas comparten el objetivo de transmitir mensajes, pero difieren significativamente en sus características, canales de transmisión, inmediatez y estructura formal. Comprender estas diferencias es esencial para desarrollar competencias comunicativas eficaces en diversos contextos, desde una conversación casual hasta la redacción de un documento académico.

En la vida cotidiana, alternamos constantemente entre la oralidad y la escritura. Mientras que la primera suele ser más espontánea y dependiente del contexto inmediato, la segunda requiere una mayor planificación y rigurosidad gramatical, permitiendo que el mensaje perdure en el tiempo y cruce fronteras espaciales.

### Conceptos Clave
1. **Comunicación Oral**:
   - **Canal Auditivo**: Se percibe a través del oído.
   - **Inmediatez y Efimeridad**: El mensaje se produce y recibe en tiempo real y, a menos que sea grabado, desaparece al instante.
   - **Espontaneidad**: Suele ser menos planificada, lo que permite la rectificación sobre la marcha, repeticiones y el uso de muletillas.
   - **Elementos Paralingüísticos y Extralingüísticos**: Se apoya fuertemente en el tono de voz, el ritmo, los gestos, la postura y el contacto visual.
   - **Interacción Directa**: Fomenta el feedback o retroalimentación inmediata por parte del receptor.

2. **Comunicación Escrita**:
   - **Canal Visual**: Se percibe a través de la vista (o del tacto, en el caso del Braille).
   - **Durabilidad**: El mensaje queda fijado en un soporte (papel, pantalla digital), permitiendo su revisión y lectura diferida en el tiempo.
   - **Planificación**: Exige una estructuración mental previa, cuidando la ortografía, la sintaxis y la coherencia del texto.
   - **Ausencia de Contexto Compartido**: Como el emisor y el receptor no suelen compartir el mismo espacio-tiempo, el texto debe ser lo suficientemente claro y autónomo para ser comprendido por sí mismo.
   - **Formalidad**: Tiende a ser más formal y a respetar estrictamente las normas del lenguaje.

3. **Diferencias Principales**:
   - **Sintaxis**: La oralidad utiliza frases más cortas y estructuras más simples o inacabadas; la escritura emplea una sintaxis más compleja y elaborada.
   - **Léxico**: El vocabulario oral puede ser coloquial e impreciso; el escrito suele ser más preciso, variado y adaptado al registro del texto.

### Ejemplos Resueltos
**Ejemplo 1: Transformación de un mensaje oral a escrito**
- *Oral*: "Hola Juan, te llamaba para decirte que no voy a poder ir a la reunión de mañana porque me surgió un imprevisto, avísale al jefe porfa."
- *Escrito (Correo formal)*: "Estimado Juan: Me dirijo a usted para informarle que, debido a un imprevisto de fuerza mayor, no podré asistir a la reunión programada para el día de mañana. Le ruego que comunique esta situación a la dirección. Atentamente."

**Ejemplo 2: Análisis de situación comunicativa**
- *Situación*: Un debate político en televisión.
- *Análisis*: Aunque utiliza el canal oral y hay espontaneidad, es una oralidad "planificada", donde los ponentes han preparado sus argumentos (rasgo de lo escrito), pero se apoyan en la gestualidad, el tono y la interrupción (rasgos de lo oral).'''
    },
    {
      "codigo_tema": "2.2.1",
      "materia": "Lengua y Literatura",
      "titulo": "Elementos y Factores de la Comunicación",
      "contenido_markdown": r'''### Introducción
Para que el acto comunicativo se lleve a cabo de manera efectiva, no basta con la simple intención de transmitir un mensaje. Es necesario que interactúen de forma coordinada una serie de elementos o factores que estructuran este proceso. El lingüista Roman Jakobson fue uno de los principales teóricos en sistematizar estos elementos, demostrando que la comunicación es un sistema dinámico donde cada pieza juega un rol vital. Si alguno de estos elementos falla, se produce lo que en teoría de la comunicación se conoce como "ruido", lo que dificulta o impide la comprensión del mensaje.

Entender los elementos de la comunicación nos permite no solo mejorar nuestra capacidad de transmitir ideas, sino también desarrollar un pensamiento crítico al analizar los discursos que recibimos diariamente en medios de comunicación, redes sociales y relaciones interpersonales.

### Conceptos Clave
1. **Emisor**:
   Es la persona, grupo o entidad que elabora y transmite el mensaje. Su tarea principal es la codificación, es decir, traducir sus ideas en signos (palabras, imágenes, gestos) que puedan ser interpretados.

2. **Receptor**:
   Es el destinatario del mensaje, quien lo recibe y lo descodifica. La interpretación del mensaje por parte del receptor está influenciada por su cultura, conocimientos previos y estado emocional.

3. **Mensaje**:
   Es la información concreta que el emisor transmite al receptor. Es el contenido de la comunicación, estructurado según las reglas del código utilizado.

4. **Código**:
   Es el sistema de signos y las reglas para combinarlos que comparten el emisor y el receptor para que el mensaje sea comprensible. El idioma español, el lenguaje de señas, las señales de tráfico o el código Morse son ejemplos de códigos.

5. **Canal**:
   Es el medio físico a través del cual viaja el mensaje desde el emisor hasta el receptor. Puede ser natural (el aire por donde viajan las ondas sonoras de la voz) o artificial (un cable telefónico, una pantalla de ordenador, una hoja de papel).

6. **Contexto (o Situación Comunicativa)**:
   Son las circunstancias espaciales, temporales, socioculturales y psicológicas que rodean el acto comunicativo y que ayudan a comprender el sentido exacto del mensaje. La palabra "banco" significa algo diferente si estamos en un parque o en una zona financiera.

7. **Ruido y Redundancia**:
   - *Ruido*: Cualquier interferencia que altere la recepción del mensaje (sonidos fuertes, letra ilegible, mala conexión a internet).
   - *Redundancia*: Repetición de elementos para asegurar que el mensaje llegue a pesar del ruido (alzar la voz, subrayar palabras).

### Ejemplos Resueltos
**Ejemplo 1: Análisis de una situación cotidiana**
- *Situación*: Un profesor explica la lección de matemáticas en el aula utilizando la pizarra.
- *Análisis*:
  - **Emisor**: El profesor.
  - **Receptor**: Los estudiantes presentes en el aula.
  - **Mensaje**: La explicación sobre el tema de matemáticas (ej. ecuaciones de segundo grado).
  - **Código**: El idioma español y el lenguaje matemático (números y símbolos).
  - **Canal**: El aire (voz) y la pizarra (visual).
  - **Contexto**: Un entorno educativo, en horario de clases.

**Ejemplo 2: Identificación de fallos comunicativos (Ruido)**
- *Situación*: María le envía un mensaje de WhatsApp a Pedro en inglés, pero Pedro solo habla español y además tiene poca señal de internet.
- *Análisis*: Hay dos tipos de ruido. Un ruido de canal o técnico (la mala conexión a internet) y un ruido semántico (la falta de un código compartido, ya que Pedro no entiende inglés), lo que impide que el mensaje sea descodificado correctamente.'''
    },
    {
      "codigo_tema": "2.3.1",
      "materia": "Lengua y Literatura",
      "titulo": "Las Funciones del Lenguaje",
      "contenido_markdown": r'''### Introducción
El lenguaje no es simplemente una herramienta para describir el mundo; es un instrumento versátil que utilizamos con múltiples propósitos o intenciones. Cuando hablamos o escribimos, no siempre queremos informar de algo objetivo; a veces buscamos expresar nuestros sentimientos, influir en la conducta de otra persona, asegurar que el canal de comunicación sigue abierto, o incluso hablar del lenguaje mismo. 

Basado en su modelo de los elementos de la comunicación, Roman Jakobson estableció que el lenguaje cumple diversas funciones dependiendo del elemento de la comunicación en el que se centre el acto comunicativo. Comprender las funciones del lenguaje es fundamental para la comprensión lectora y el análisis de textos, ya que nos revela la intención principal del autor.

### Conceptos Clave
1. **Función Representativa o Referencial**:
   - **Enfoque**: Se centra en el **Contexto** o referente.
   - **Objetivo**: Transmitir información de manera objetiva, sin valoraciones personales.
   - **Características**: Uso de oraciones enunciativas, modo indicativo, vocabulario denotativo (literal) y tercera persona.
   - **Uso frecuente**: Textos científicos, periodísticos, manuales, enciclopedias.

2. **Función Expresiva o Emotiva**:
   - **Enfoque**: Se centra en el **Emisor**.
   - **Objetivo**: Expresar los sentimientos, emociones, opiniones y estados de ánimo del que habla.
   - **Características**: Uso de la primera persona, exclamaciones, interjecciones, adjetivos valorativos y verbos en subjuntivo (que expresan deseo).
   - **Uso frecuente**: Diarios íntimos, poesía lírica, conversaciones coloquiales.

3. **Función Apelativa o Conativa**:
   - **Enfoque**: Se centra en el **Receptor**.
   - **Objetivo**: Influir, persuadir, ordenar o llamar la atención del oyente para que actúe de determinada manera.
   - **Características**: Uso de la segunda persona, imperativos, vocativos, oraciones interrogativas y tono de mandato o ruego.
   - **Uso frecuente**: Publicidad, discursos políticos, sermones, manuales de instrucciones, leyes.

4. **Función Fática o de Contacto**:
   - **Enfoque**: Se centra en el **Canal**.
   - **Objetivo**: Iniciar, prolongar, interrumpir o asegurar que el canal de comunicación funciona correctamente.
   - **Características**: Fórmulas de saludo, despedida, frases hechas, preguntas de comprobación.
   - **Uso frecuente**: Saludos ("Hola"), comprobaciones telefónicas ("¿Me escuchas?"), conversaciones de ascensor.

5. **Función Metalingüística**:
   - **Enfoque**: Se centra en el **Código**.
   - **Objetivo**: Utilizar el lenguaje para hablar o explicar aspectos del propio lenguaje.
   - **Características**: Definiciones, aclaraciones gramaticales u ortográficas, uso de comillas para destacar palabras.
   - **Uso frecuente**: Diccionarios, clases de gramática, libros de lingüística.

6. **Función Poética o Estética**:
   - **Enfoque**: Se centra en el **Mensaje**.
   - **Objetivo**: Llamar la atención sobre la forma en que se dice el mensaje, buscando la belleza y el goce estético.
   - **Características**: Uso de figuras literarias (metáforas, rimas, aliteraciones), vocabulario connotativo, ritmo y musicalidad.
   - **Uso frecuente**: Literatura (poesía, novela, teatro), refranes, eslóganes publicitarios.

### Ejemplos Resueltos
**Ejemplo 1: Identificación de la función principal**
- *Oración*: "¡Qué alegría verte después de tanto tiempo!"
- *Solución*: Predomina la **Función Expresiva**, ya que el emisor (centrado en sí mismo) manifiesta su estado emocional (alegría) mediante una oración exclamativa.

**Ejemplo 2: Análisis de un texto publicitario**
- *Texto*: "¡Compra ahora el nuevo modelo y descubre la verdadera velocidad! Disponible en tiendas."
- *Solución*:
  - Función principal: **Apelativa**, porque busca modificar la conducta del receptor para que realice la acción de comprar (uso del imperativo "compra", "descubre").
  - Función secundaria: **Poética** (ligera) y **Referencial** (al informar que está "disponible en tiendas").

**Ejemplo 3: Diferenciación Metalingüística y Referencial**
- *Oración 1*: "El agua hierve a 100 grados Celsius." -> Función **Referencial** (informa sobre un hecho físico).
- *Oración 2*: "La palabra 'agua' es un sustantivo femenino." -> Función **Metalingüística** (usa el lenguaje para explicar una regla del español).'''
    },
    {
      "codigo_tema": "2.4.1",
      "materia": "Lengua y Literatura",
      "titulo": "Niveles y Registros del Lenguaje",
      "contenido_markdown": r'''### Introducción
El lenguaje no es homogéneo ni uniforme; varía enormemente dependiendo de quién lo utiliza, dónde se utiliza y con quién se habla. Un mismo individuo no habla de la misma manera cuando expone una tesis doctoral que cuando conversa con sus amigos en una cafetería. Estas variaciones se sistematizan a través del estudio de los niveles y registros del lenguaje.

Los niveles del lenguaje responden a factores socioculturales, es decir, al grado de instrucción y conocimiento lingüístico del hablante. Por su parte, los registros lingüísticos responden a la situación comunicativa, es decir, a la adaptación que hace el hablante según el contexto, el tema, el canal y la relación con su interlocutor. Dominar diferentes niveles y registros es lo que define a un hablante competente.

### Conceptos Clave
1. **Nivel Culto (o Estándar Superior)**:
   - Es el modelo ideal del idioma, caracterizado por una enorme riqueza léxica, precisión y rigor sintáctico.
   - **Características**: Respeta estrictamente las normas ortográficas y gramaticales; utiliza un vocabulario amplio, abstracto y especializado; presenta una pronunciación cuidada y sintaxis compleja.
   - **Uso**: Ámbitos académicos, literarios, discursos formales, documentos oficiales y ensayos.

2. **Nivel Coloquial o Familiar (Estándar Medio)**:
   - Es el nivel más utilizado en la comunicación cotidiana. Es correcto pero menos rígido que el culto.
   - **Características**: Predomina la naturalidad y la espontaneidad. Se apoya en la entonación y los gestos. Uso frecuente de muletillas ("bueno", "o sea"), frases hechas, refranes, diminutivos afectivos y acortamiento de palabras ("profe", "bici").
   - **Uso**: Conversaciones con amigos, familiares, compañeros de trabajo en ambientes relajados, correos electrónicos informales.

3. **Nivel Vulgar (o Subestándar)**:
   - Se caracteriza por el desconocimiento de las normas lingüísticas, asociado generalmente a un bajo nivel de instrucción.
   - **Características**: Uso de vulgarismos, que son incorrecciones que afectan a la pronunciación ("abuja" por aguja, "haiga" por haya), a la morfología y sintaxis ("me se cayó", "andé" por anduve), y uso excesivo de groserías o palabras malsonantes.
   - **Uso**: No es adecuado en ninguna situación comunicativa formal. Su aparición suele limitarse a contextos muy informales o de marginalidad.

4. **Registros Lingüísticos (Adecuación)**:
   La elección entre un estilo formal o informal depende de:
   - **La relación entre los interlocutores**: Relación simétrica (amigos, hermanos) propicia el registro informal; relación asimétrica (jefe-empleado, juez-acusado) exige registro formal.
   - **El canal**: La escritura suele requerir más formalidad que la oralidad.
   - **El tema**: Temas especializados o científicos exigen un registro formal, mientras que temas cotidianos permiten uno informal.

5. **Jerga y Argot**:
   - **Jerga**: Variedad lingüística utilizada por un grupo social o profesional específico (jerga médica, jerga jurídica, jerga juvenil). Facilita la comunicación rápida entre los miembros del grupo, pero excluye a los que no pertenecen a él.
   - **Argot**: Un tipo específico de jerga, muchas veces asociada a grupos marginales que buscan ocultar el significado de sus mensajes al resto de la sociedad.

### Ejemplos Resueltos
**Ejemplo 1: Diferenciación de Niveles**
- *Situación*: Comunicar que alguien ha fallecido.
- *Nivel Culto*: "El ilustre escritor ha fallecido a causa de una insuficiencia cardíaca severa."
- *Nivel Coloquial*: "El abuelo nos dejó anoche, qué pena más grande."
- *Nivel Vulgar*: "El viejo estiró la pata de un infarto."
- *Explicación*: El mensaje es el mismo, pero la forma (el léxico y la estructura) cambia drásticamente según el nivel sociocultural.

**Ejemplo 2: Análisis de Adecuación (Registros)**
- *Situación*: Un joven va a una entrevista de trabajo en un bufete de abogados y dice: "¡Qué onda, jefe! Yo soy un máquina para los pleitos, te lo juro por mi madre."
- *Análisis*: El joven está cometiendo un error de adecuación al utilizar un **registro coloquial/juvenil** en una situación que exige un **registro formal**. Aunque su lenguaje pueda ser correcto en su grupo de amigos (su nivel), no sabe adaptarlo al contexto, demostrando baja competencia comunicativa.'''
    },
    {
      "codigo_tema": "2.5.1",
      "materia": "Lengua y Literatura",
      "titulo": "Tipología Textual y Estructura del Texto",
      "contenido_markdown": r'''### Introducción
A lo largo de nuestra vida interactuamos con una infinidad de textos: desde un poema de amor y un manual de instrucciones de una lavadora, hasta una noticia de periódico o un ensayo filosófico. Evidentemente, no todos se escriben ni se leen de la misma manera. Para clasificar esta enorme diversidad, la lingüística ha desarrollado el concepto de "tipología textual".

La tipología textual clasifica los textos basándose en su intención comunicativa (para qué se escriben) y su estructura interna o trama (cómo se organizan). Conocer estas tipologías es una herramienta indispensable para mejorar la comprensión lectora, ya que nos permite anticipar la estructura de lo que vamos a leer y extraer la información relevante con mayor eficacia.

### Conceptos Clave
Según su intención comunicativa y su estructura dominante, los textos se clasifican en cinco grandes tipologías básicas:

1. **Textos Narrativos**:
   - **Intención**: Relatar hechos, sucesos o historias que les ocurren a unos personajes en un espacio y tiempo determinados.
   - **Estructura típica**: Planteamiento (introducción de personajes y situación), Nudo (conflicto o desarrollo de la acción) y Desenlace (resolución).
   - **Rasgos lingüísticos**: Abundancia de verbos de acción y movimiento, uso del pretérito (perfecto e imperfecto), marcadores temporales (luego, después, entonces).
   - **Ejemplos**: Cuentos, novelas, leyendas, fábulas, noticias periodísticas (crónicas), biografías.

2. **Textos Descriptivos**:
   - **Intención**: Decir cómo es algo o alguien (personas, animales, objetos, lugares, sentimientos) mediante palabras, creando una imagen mental en el receptor.
   - **Tipos**: Descripción objetiva (técnica, sin emociones) y subjetiva (literaria, con valoraciones del autor).
   - **Rasgos lingüísticos**: Predominio de sustantivos y, sobre todo, adjetivos calificativos; verbos de estado (ser, estar, parecer); uso de comparaciones y metáforas en la descripción literaria.
   - **Ejemplos**: Guías turísticas, catálogos de venta, retratos literarios, diarios.

3. **Textos Expositivos (o Informativos)**:
   - **Intención**: Transmitir información, explicar un tema de forma clara, ordenada y objetiva para que el receptor lo comprenda.
   - **Estructura típica**: Introducción (presentación del tema), Desarrollo (explicación detallada) y Conclusión (síntesis de ideas).
   - **Rasgos lingüísticos**: Lenguaje objetivo y claro, tercera persona, conectores lógicos de causa, consecuencia y orden, uso de tecnicismos si el tema es especializado.
   - **Ejemplos**: Libros de texto escolares, enciclopedias, artículos de divulgación científica, conferencias.

4. **Textos Argumentativos**:
   - **Intención**: Persuadir, convencer al receptor o defender una opinión (tesis) aportando razones, pruebas o argumentos.
   - **Estructura típica**: Tesis (idea principal a defender), Cuerpo argumentativo (razones, ejemplos, datos que apoyan la tesis) y Conclusión.
   - **Rasgos lingüísticos**: Uso de conectores de contraste (sin embargo, no obstante), expresiones de opinión (en mi opinión, creo que), preguntas retóricas, verbos de pensamiento.
   - **Ejemplos**: Editoriales de periódicos, artículos de opinión, ensayos, debates, discursos políticos, publicidad.

5. **Textos Instructivos o Directivos**:
   - **Intención**: Guiar el comportamiento del receptor, dar órdenes, consejos o enseñar a hacer algo paso a paso.
   - **Estructura típica**: Objetivo general o materiales necesarios, seguido de una secuencia ordenada y numerada de pasos.
   - **Rasgos lingüísticos**: Uso abundante del imperativo (haga, corte) o del infinitivo (hacer, cortar), conectores de orden (primero, después, finalmente), lenguaje preciso y directo.
   - **Ejemplos**: Recetas de cocina, manuales de usuario, leyes, reglamentos, prescripciones médicas.

### Ejemplos Resueltos
**Ejemplo 1: Identificación de secuencias en un texto mixto**
- *Texto*: "El guepardo es un felino de cuerpo esbelto y patas largas (1). Ayer, un ejemplar joven logró atrapar a una gacela tras una intensa carrera (2)."
- *Solución*: La mayoría de los textos son mixtos. La oración (1) es de tipo **descriptivo** (dice cómo es, usando adjetivos como "esbelto" y "largas"). La oración (2) es de tipo **narrativo** (relata un suceso en un momento específico usando verbos de acción).

**Ejemplo 2: Diferenciación entre Exposición y Argumentación**
- *Texto A*: "El calentamiento global es el aumento a largo plazo de la temperatura media del sistema climático de la Tierra, impulsado principalmente por la emisión de gases de efecto invernadero."
- *Texto B*: "Debemos reducir urgentemente nuestras emisiones de carbono, ya que es evidente que el calentamiento global está destruyendo nuestro planeta y poniendo en riesgo a las futuras generaciones."
- *Análisis*: El Texto A es **Expositivo**, ya que define y explica objetivamente un fenómeno sin emitir juicios. El Texto B es **Argumentativo**, ya que defiende una postura (hay que reducir emisiones) e intenta persuadir al lector apelando a las consecuencias negativas.'''
    }
  ];

  final file = File('c:/Users/diego/Desktop/ExamenCuenca/app_ucuenca/assets/data/gen_t_len.json');
  if (!file.parent.existsSync()) {
    file.parent.createSync(recursive: true);
  }
  file.writeAsStringSync(jsonEncode(data));
  print('Generacion exitosa.');
}
