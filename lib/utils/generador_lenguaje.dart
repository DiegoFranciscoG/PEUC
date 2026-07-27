import 'dart:math';
import '../models/pregunta.dart';

class GeneradorLenguaje {
  static final Random _rand = Random();

  static int _ri(int min, int max) => min + _rand.nextInt(max - min + 1);
  static T _re<T>(List<T> list) => list[_rand.nextInt(list.length)];

  // 2.1.1 Variedades lingüísticas
  static Pregunta generarVariedades() {
    final quichuismos = [
      {'p': 'cancha', 's': 'espacio abierto', 'd': ['herramienta', 'comida típica', 'tipo de baile', 'recipiente de barro']},
      {'p': 'choclo', 's': 'maíz tierno', 'd': ['papa andina', 'plato de barro', 'instrumento', 'vasija']},
      {'p': 'guagua', 's': 'niño', 'd': ['anciano', 'animal doméstico', 'juguete', 'vehículo']},
      {'p': 'mishqui', 's': 'dulce', 'd': ['amargo', 'salado', 'picante', 'agrio']},
      {'p': 'shungo', 's': 'corazón', 'd': ['cabeza', 'estómago', 'espalda', 'mano']},
      {'p': 'yapa', 's': 'aumento', 'd': ['descuento', 'castigo', 'regalo caro', 'deuda']},
    ];
    final prefixes = [
      'En el español andino ecuatoriano, ',
      'Considerando las variedades lingüísticas del Ecuador, ',
      'Dentro del léxico cotidiano en la sierra ecuatoriana, ',
      'Según el uso popular en Ecuador, ',
      'En el contexto de los quichuismos, ',
      'Identifica el significado correcto: '
    ];
    final suffixes = [
      '¿qué significa la palabra',
      '¿cuál es el significado del término',
      '¿qué denota el vocablo',
      '¿qué quiere decir'
    ];

    final q = _re(quichuismos);
    final distractores = (q['d'] as List<String>).toList()..shuffle(_rand);
    final opciones = [q['s'] as String, distractores[0], distractores[1], distractores[2]]..shuffle(_rand);
    
    final enunciado = '${_re(prefixes)}${_re(suffixes)} "${q['p']}"?';

    return _b('2.1.1', enunciado, opciones, q['s'] as String);
  }

  // 2.2.1 Comunicación oral
  static Pregunta generarComunicacion() {
    final funciones = [
      {'f': 'fática', 'e': ['¡Aló! ¿Me escuchas?', 'Uno, dos, tres, probando micrófono.', '¿Me oyen bien al fondo?', '¡Hola! Qué gusto verte.'], 'd': ['metalingüística', 'poética', 'referencial', 'expresiva']},
      {'f': 'apelativa', 'e': ['¡Cierra la puerta rápido!', 'Por favor, entreguen el examen.', '¡No pises el césped!', 'Estudia para mañana.'], 'd': ['expresiva', 'fática', 'metalingüística', 'poética']},
      {'f': 'expresiva', 'e': ['¡Qué dolor tan grande siento!', '¡Ay, me golpeé muy fuerte!', '¡Qué alegría verte hoy!', 'Siento mucha tristeza.'], 'd': ['apelativa', 'referencial', 'poética', 'fática']},
      {'f': 'poética', 'e': ['Tus ojos son dos luceros que iluminan mi madrugada.', 'El viento susurraba secretos a los árboles.', 'Su cabello era un río de oro.', 'El mar lloraba en la playa.'], 'd': ['fática', 'apelativa', 'referencial', 'metalingüística']},
      {'f': 'referencial', 'e': ['El examen de admisión será el martes.', 'La capital de Ecuador es Quito.', 'El agua hierve a 100 grados.', 'Hoy llovió 30 milímetros.'], 'd': ['expresiva', 'apelativa', 'fática', 'poética']},
    ];
    final q = _re(funciones);
    final distractores = (q['d'] as List<String>).toList()..shuffle(_rand);
    final opciones = [q['f'] as String, distractores[0], distractores[1], distractores[2]]..shuffle(_rand);
    
    final p1 = ['Analiza este enunciado: ', 'Lee la siguiente frase: ', 'Observa esta expresión: ', 'En el siguiente texto: '];
    final p2 = ['¿Qué función del lenguaje predomina?', '¿Cuál es la función del lenguaje evidente?', '¿Qué función comunicativa se emplea principalmente?'];

    final enunciado = '${_re(p1)}"${_re(q['e'] as List<String>)}". ${_re(p2)}';

    return _b('2.2.1', enunciado, opciones, q['f'] as String);
  }

  // 2.3.1 Comprensión de textos
  static Pregunta generarComprension() {
    final analogias = [
      {'p': 'página es a libro', 'r': 'tecla es a piano', 'd': ['agua es a vaso', 'madera es a árbol', 'luz es a foco', 'llanta es a calle']},
      {'p': 'pintor es a brocha', 'r': 'escritor es a pluma', 'd': ['músico es a canción', 'carpintero es a mesa', 'médico es a hospital', 'chef es a comida']},
      {'p': 'aleta es a pez', 'r': 'ala es a ave', 'd': ['pelo es a mamífero', 'escama es a reptil', 'pata es a insecto', 'cuerno es a toro']},
      {'p': 'fuego es a ceniza', 'r': 'evento es a recuerdo', 'd': ['agua es a hielo', 'tierra es a lodo', 'viento es a huracán', 'sol es a sombra']},
      {'p': 'médico es a paciente', 'r': 'profesor es a alumno', 'd': ['abogado es a juez', 'policía es a ladrón', 'actor es a teatro', 'piloto es a avión']},
      {'p': 'hambre es a comida', 'r': 'sed es a bebida', 'd': ['sueño es a cama', 'frío es a bufanda', 'calor es a piscina', 'cansancio es a descanso']},
      {'p': 'llave es a candado', 'r': 'contraseña es a computadora', 'd': ['puerta es a casa', 'caja es a fuerte', 'secreto es a diario']},
      {'p': 'reloj es a tiempo', 'r': 'termómetro es a temperatura', 'd': ['brújula es a norte', 'balanza es a peso', 'metro es a distancia']},
    ];
    final q = _re(analogias);
    final distractores = (q['d'] as List<String>).toList()..shuffle(_rand);
    final opciones = [q['r'] as String, distractores[0], distractores[1], distractores[2]]..shuffle(_rand);

    final pref = ['Completa la siguiente analogía: ', 'Encuentra la relación correcta para esta analogía: ', '¿Qué opción completa lógicamente la analogía? '];
    final enunciado = '${_re(pref)}${q['p']} como...';

    return _b('2.3.1', enunciado, opciones, q['r'] as String);
  }

  // 2.4.1 Producción de textos
  static Pregunta generarProduccion() {
    final oraciones = [
      {'c': 'Aunque', 'e': ['llovía a cántaros, salimos.', 'estaba enfermo, fue a trabajar.', 'no tenía dinero, viajó.'], 't': 'concesivo', 'd': ['causal', 'condicional', 'consecutivo', 'copulativo']},
      {'c': 'Porque', 'e': ['no estudió, reprobó.', 'llegó tarde, no entró.', 'comió mucho, se enfermó.'], 't': 'causal', 'd': ['concesivo', 'adversativo', 'copulativo', 'condicional']},
      {'c': 'Sin embargo', 'e': ['tenía dinero, no compró nada.', 'estudió mucho, reprobó el examen.', 'corrió rápido, llegó último.'], 't': 'adversativo', 'd': ['consecutivo', 'causal', 'condicional', 'disyuntivo']},
      {'c': 'Por lo tanto', 'e': ['aprobó el examen, celebrará hoy.', 'ahorró mucho, comprará la casa.', 'entrenó duro, ganó la medalla.'], 't': 'consecutivo', 'd': ['concesivo', 'adversativo', 'causal', 'condicional']},
    ];
    final q = _re(oraciones);
    final distractores = (q['d'] as List<String>).toList()..shuffle(_rand);
    final opciones = [q['t'] as String, distractores[0], distractores[1], distractores[2]]..shuffle(_rand);

    final ej = _re(q['e'] as List<String>);
    final pref = ['En la oración', 'Analizando la frase', 'Considerando el texto'];
    final suf = ['¿qué tipo de conector lógico es', '¿cómo se clasifica el conector', '¿qué función cumple el nexo'];

    final enunciado = '${_re(pref)} "${q['c']} $ej", ${_re(suf)} "${q['c']}"?';

    return _b('2.4.1', enunciado, opciones, q['t'] as String);
  }

  // 2.5.1 Literatura y contexto
  static Pregunta generarLiteratura() {
    final autores = [
      {'a': 'Jorge Icaza', 'o': ['Huasipungo', 'El Chulla Romero y Flores', 'Barro de la Sierra'], 'd': ['Cumandá', 'Las cruces sobre el agua', 'Los Sangurimas', 'Polvo y ceniza', 'A la costa']},
      {'a': 'Joaquín Gallegos Lara', 'o': ['Las cruces sobre el agua', 'Los que se van'], 'd': ['Huasipungo', 'Polvo y ceniza', 'Cumandá', 'El árbol del bien y del mal']},
      {'a': 'José de la Cuadra', 'o': ['Los Sangurimas', 'Horno', 'Repisas'], 'd': ['Huasipungo', 'Las cruces sobre el agua', 'Cumandá', 'A la costa']},
      {'a': 'Juan León Mera', 'o': ['Cumandá', 'Ojeada histórico-crítica'], 'd': ['Huasipungo', 'Los Sangurimas', 'Polvo y ceniza', 'María']},
      {'a': 'Medardo Ángel Silva', 'o': ['El árbol del bien y del mal', 'María Jesús'], 'd': ['Boletín y elegía de las mitas', 'Huasipungo', 'Cumandá', 'Emancipada']},
      {'a': 'Luis A. Martínez', 'o': ['A la costa'], 'd': ['Huasipungo', 'Cumandá', 'Los Sangurimas', 'Polvo y ceniza']},
    ];
    final q = _re(autores);
    final distractores = (q['d'] as List<String>).toList()..shuffle(_rand);
    final obra = _re(q['o'] as List<String>);
    final opciones = [obra, distractores[0], distractores[1], distractores[2]]..shuffle(_rand);

    final pref = [
      '¿Cuál de las siguientes obras de la literatura ecuatoriana pertenece a',
      'Selecciona el título del libro escrito por',
      'Entre las siguientes opciones, ¿qué obra fue creada por',
      'Identifica la novela o poemario de'
    ];

    final enunciado = '${_re(pref)} ${q['a']}?';

    return _b('2.5.1', enunciado, opciones, obra);
  }

  static Pregunta obtenerPreguntaParaSubtema(String codigoTema) {
    switch (codigoTema) {
      case '2.1.1': return generarVariedades();
      case '2.2.1': return generarComunicacion();
      case '2.3.1': return generarComprension();
      case '2.4.1': return generarProduccion();
      case '2.5.1': return generarLiteratura();
      default: return generarVariedades();
    }
  }

  static Pregunta _b(String tema, String enunciado, List<String> opciones, String correcta) {
    return Pregunta(
      id: 'gen_len_${DateTime.now().microsecondsSinceEpoch}_${_rand.nextInt(9999999)}',
      materia: 'Lengua y Literatura',
      codigoTema: tema,
      enunciado: enunciado,
      opciones: opciones,
      respuestaCorrecta: correcta,
      explicacionDetallada: 'Respuesta validada según el temario de Literatura y Gramática.',
      pasosResolucion: [],
      videoExplicativoUrl: null,
    );
  }
}
