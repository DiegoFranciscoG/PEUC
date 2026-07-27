import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pregunta.dart';
import '../database/db_helper.dart';
import '../utils/generador_algoritmico.dart';


enum ModoSimulacro { general, porMateria, porSubtema, examenOficial, adaptativo }

class ExamenState {
  final List<Pregunta> preguntasSimulacro;
  final int indiceActual;
  final Map<String, String> respuestasSeleccionadas;
  final int tiempoRestanteGlobal; // For Examen Oficial (3600s)
  final int tiempoRestanteIndividual; // For Simulacro (60s)
  final Map<String, int> tiempoPorPregunta;
  final Map<String, int> nivelConfianza; // 1: Adiviné, 2: Algo Seguro, 3: Muy Seguro
  final bool examenFinalizado;
  final bool estaCargando;
  final ModoSimulacro modo;
  final String? materiaFiltro;
  final String? codigoTemaFiltro;
  final int? sesionId;
  final String? errorMensaje; // Non-null when a DB error prevents loading

  ExamenState({
    this.preguntasSimulacro = const [],
    this.indiceActual = 0,
    this.respuestasSeleccionadas = const {},
    this.tiempoRestanteGlobal = 0,
    this.tiempoRestanteIndividual = 60,
    this.tiempoPorPregunta = const {},
    this.nivelConfianza = const {},
    this.examenFinalizado = false,
    this.estaCargando = false,
    this.modo = ModoSimulacro.general,
    this.materiaFiltro,
    this.codigoTemaFiltro,
    this.sesionId,
    this.errorMensaje,
  });

  ExamenState copyWith({
    List<Pregunta>? preguntasSimulacro,
    int? indiceActual,
    Map<String, String>? respuestasSeleccionadas,
    int? tiempoRestanteGlobal,
    int? tiempoRestanteIndividual,
    Map<String, int>? tiempoPorPregunta,
    Map<String, int>? nivelConfianza,
    bool? examenFinalizado,
    bool? estaCargando,
    ModoSimulacro? modo,
    String? materiaFiltro,
    String? codigoTemaFiltro,
    int? sesionId,
    String? errorMensaje,
  }) {
    return ExamenState(
      preguntasSimulacro: preguntasSimulacro ?? this.preguntasSimulacro,
      indiceActual: indiceActual ?? this.indiceActual,
      respuestasSeleccionadas: respuestasSeleccionadas ?? this.respuestasSeleccionadas,
      tiempoRestanteGlobal: tiempoRestanteGlobal ?? this.tiempoRestanteGlobal,
      tiempoRestanteIndividual: tiempoRestanteIndividual ?? this.tiempoRestanteIndividual,
      tiempoPorPregunta: tiempoPorPregunta ?? this.tiempoPorPregunta,
      nivelConfianza: nivelConfianza ?? this.nivelConfianza,
      examenFinalizado: examenFinalizado ?? this.examenFinalizado,
      estaCargando: estaCargando ?? this.estaCargando,
      modo: modo ?? this.modo,
      materiaFiltro: materiaFiltro ?? this.materiaFiltro,
      codigoTemaFiltro: codigoTemaFiltro ?? this.codigoTemaFiltro,
      sesionId: sesionId ?? this.sesionId,
      errorMensaje: errorMensaje ?? this.errorMensaje,
    );
  }

  bool get respondioActual {
    if (preguntasSimulacro.isEmpty) return false;
    return respuestasSeleccionadas.containsKey(preguntasSimulacro[indiceActual].id);
  }

  int get bancoCompleto => 1240;

  double get puntajeOficial {
    double puntaje = 0;
    for (var p in preguntasSimulacro) {
      final resp = respuestasSeleccionadas[p.id];
      if (resp != null && resp != 'TIEMPO_AGOTADO' && resp != 'OMITIDA') {
        if (_esCorrecta(p)) {
          puntaje += 1.0;
        } else {
          puntaje -= 0.5;
        }
      }
    }
    return puntaje;
  }
  
  int get respuestasCorrectas {
    int c = 0;
    for (var p in preguntasSimulacro) {
      if (_esCorrecta(p)) c++;
    }
    return c;
  }

  bool _esCorrecta(Pregunta p) {
    final resp = respuestasSeleccionadas[p.id];
    if (resp == null) return false;
    if (p.indiceRespuestaCorrectaAbstracta != null) {
      return resp == p.indiceRespuestaCorrectaAbstracta.toString();
    }
    return resp == p.respuestaCorrecta;
  }

  int puntajePorMateria(String materia) {
    return preguntasSimulacro
        .where((p) => p.materia == materia)
        .where((p) => _esCorrecta(p))
        .length;
  }

  int totalPorMateria(String materia) {
    return preguntasSimulacro.where((p) => p.materia == materia).length;
  }

  String get tituloSimulacro {
    switch (modo) {
      case ModoSimulacro.porSubtema:
        return 'Simulacro: ${codigoTemaFiltro ?? ""}';
      case ModoSimulacro.porMateria:
        return 'Simulacro: ${materiaFiltro ?? ""}';
      case ModoSimulacro.general:
        return 'Simulacro Inteligente';
      case ModoSimulacro.examenOficial:
        return 'Examen Oficial (60 min)';
      case ModoSimulacro.adaptativo:
        return 'Examen Adaptativo (SM-2)';
    }
  }
}

class ExamenNotifier extends StateNotifier<ExamenState> {
  ExamenNotifier() : super(ExamenState());

  Timer? _timerGlobal;
  Timer? _timerIndividual;
  int _tiempoInicioIndividual = 60;



  Future<void> iniciarExamenOficial() async {
    state = ExamenState(estaCargando: true, modo: ModoSimulacro.examenOficial);
    _cancelAllTimers();

    final db = DBHelper();
    // Examen de 60 preguntas: Matemáticas(12), Lengua(12), Naturales(12), Sociales(12), Abstracto(12)
    List<Pregunta> lista = [];
    lista.addAll(await db.getSimulacroPorMateria('Matemáticas', 12));
    lista.addAll(await db.getSimulacroPorMateria('Lengua y Literatura', 12));
    lista.addAll(await db.getSimulacroPorMateria('Ciencias Naturales', 12)); // DB will have theoretical ones
    lista.addAll(await db.getSimulacroPorMateria('Ciencias Sociales', 12));
    lista.addAll(await db.getSimulacroPorMateria('Razonamiento Abstracto', 12));

    lista.shuffle();
    
    int sId = await db.crearSesionExamen('Examen Oficial', lista.length);

    state = state.copyWith(
      preguntasSimulacro: lista,
      estaCargando: false,
      tiempoRestanteGlobal: 3600, // 60 minutos
      sesionId: sId,
    );

    if (lista.isNotEmpty) {
      _iniciarTemporizadorGlobal();
    }
  }

  Future<void> iniciarSimulacroIntensivo({
    String? materiaFiltro,
    String? codigoTemaFiltro,
  }) async {
    state = ExamenState(
      estaCargando: true,
      modo: codigoTemaFiltro != null
          ? ModoSimulacro.porSubtema
          : (materiaFiltro != null ? ModoSimulacro.porMateria : ModoSimulacro.general),
      materiaFiltro: materiaFiltro,
      codigoTemaFiltro: codigoTemaFiltro,
    );
    _cancelAllTimers();

    try {
      final db = DBHelper();
      List<Pregunta> lista = [];

      if (codigoTemaFiltro != null) {
        lista = await db.getSimulacroPorSubtema(codigoTemaFiltro, 20);
      } else if (materiaFiltro != null) {
        lista = await db.getSimulacroPorMateria(materiaFiltro, 20);
      } else {
        lista = await db.getSimulacroGeneral(20);
        lista.shuffle();
      }

      int sId = await db.crearSesionExamen(
        codigoTemaFiltro != null ? 'Subtema: $codigoTemaFiltro' : (materiaFiltro != null ? 'Materia: $materiaFiltro' : 'Simulacro Inteligente'),
        lista.length,
      );

      state = state.copyWith(
        preguntasSimulacro: lista,
        estaCargando: false,
        tiempoRestanteIndividual: 60,
        sesionId: sId,
      );

      if (lista.isNotEmpty) {
        _tiempoInicioIndividual = 60;
        _iniciarTemporizadorIndividual();
      }
    } catch (e, stack) {
      // Guard: any DB/parse error resolves the loading state with an error,
      // preventing the spinner from hanging forever.
      debugPrint('❌ Error cargando simulacro ($codigoTemaFiltro | $materiaFiltro): $e\n$stack');
      state = state.copyWith(
        estaCargando: false,
        preguntasSimulacro: [],
        errorMensaje: 'No se pudo cargar el contenido. Intenta de nuevo.',
      );
    }
  }

  Future<void> iniciarExamenAdaptativo() async {
    state = ExamenState(
      estaCargando: true,
      modo: ModoSimulacro.adaptativo,
    );
    _cancelAllTimers();

    try {
      final db = DBHelper();
      List<Pregunta> lista = await db.getSimulacroAdaptativo(20);
      lista.shuffle();

      int sId = await db.crearSesionExamen('Examen Adaptativo (Repetición Espaciada)', lista.length);

      state = state.copyWith(
        preguntasSimulacro: lista,
        estaCargando: false,
        tiempoRestanteIndividual: 60,
        sesionId: sId,
      );

      if (lista.isNotEmpty) {
        _tiempoInicioIndividual = 60;
        _iniciarTemporizadorIndividual();
      }
    } catch (e, stack) {
      debugPrint('❌ Error cargando examen adaptativo: $e\n$stack');
      state = state.copyWith(
        estaCargando: false,
        preguntasSimulacro: [],
        errorMensaje: 'No se pudo cargar el examen adaptativo. Intenta de nuevo.',
      );
    }
  }

  void responderPregunta(String respuesta) {
    if (state.examenFinalizado || state.respondioActual) return;

    final preguntaActual = state.preguntasSimulacro[state.indiceActual];
    final nuevasRespuestas = Map<String, String>.from(state.respuestasSeleccionadas);
    nuevasRespuestas[preguntaActual.id] = respuesta;

    // Calculamos el tiempo usado. En modo examen global es un poco más complejo, 
    // pero para registrar historial usaremos una aproximación o un temporizador interno si quisiéramos.
    final tiempoUsado = state.modo == ModoSimulacro.examenOficial 
        ? 15 // Placeholder para modo global
        : _tiempoInicioIndividual - state.tiempoRestanteIndividual;
        
    final nuevoTiempoPorPregunta = Map<String, int>.from(state.tiempoPorPregunta);
    nuevoTiempoPorPregunta[preguntaActual.id] = tiempoUsado;

    // En modo simulacro individual paramos el timer para que lea la explicación.
    // En modo examen oficial, el timer global sigue corriendo, pero avanzamos a la siguiente pregunta automáticamente.
    if (state.modo != ModoSimulacro.examenOficial) {
      _timerIndividual?.cancel();
    }

    final bool acierto;
    if (preguntaActual.indiceRespuestaCorrectaAbstracta != null) {
      acierto = respuesta == preguntaActual.indiceRespuestaCorrectaAbstracta.toString();
    } else {
      acierto = respuesta == preguntaActual.respuestaCorrecta;
    }

    if (state.sesionId != null) {
      DBHelper().registrarRespuesta(
        state.sesionId!,
        preguntaActual.id,
        preguntaActual.codigoTema,
        acierto,
        tiempoUsado,
      );
    }

    state = state.copyWith(
      respuestasSeleccionadas: nuevasRespuestas,
      tiempoPorPregunta: nuevoTiempoPorPregunta,
    );
    
    // Auto advance in Examen Oficial
    if (state.modo == ModoSimulacro.examenOficial) {
       Future.delayed(const Duration(milliseconds: 300), () {
          siguientePregunta();
       });
    }
  }

  void siguientePregunta({int? confianza}) {
    if (state.indiceActual < state.preguntasSimulacro.length - 1) {
      final nuevasConfianzas = Map<String, int>.from(state.nivelConfianza);
      if (confianza != null) {
        nuevasConfianzas[state.preguntasSimulacro[state.indiceActual].id] = confianza;
        // Opcional: Actualizar en BD
        DBHelper().actualizarConfianzaRespuesta(state.sesionId!, state.preguntasSimulacro[state.indiceActual].id, confianza);
      }

      _tiempoInicioIndividual = 60;
      state = state.copyWith(
        indiceActual: state.indiceActual + 1,
        tiempoRestanteIndividual: 60,
        nivelConfianza: nuevasConfianzas,
      );
      if (state.modo != ModoSimulacro.examenOficial) {
        _iniciarTemporizadorIndividual();
      }
    } else {
      final nuevasConfianzas = Map<String, int>.from(state.nivelConfianza);
      if (confianza != null) {
        nuevasConfianzas[state.preguntasSimulacro[state.indiceActual].id] = confianza;
        DBHelper().actualizarConfianzaRespuesta(state.sesionId!, state.preguntasSimulacro[state.indiceActual].id, confianza);
      }
      state = state.copyWith(nivelConfianza: nuevasConfianzas);
      finalizarExamen();
    }
  }

  void _cancelAllTimers() {
    _timerGlobal?.cancel();
    _timerIndividual?.cancel();
  }

  void _iniciarTemporizadorIndividual() {
    _timerIndividual?.cancel();
    _timerIndividual = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.tiempoRestanteIndividual > 0) {
        state = state.copyWith(tiempoRestanteIndividual: state.tiempoRestanteIndividual - 1);
      } else {
        timer.cancel();
        responderPregunta('TIEMPO_AGOTADO');
      }
    });
  }
  
  void _iniciarTemporizadorGlobal() {
    _timerGlobal?.cancel();
    _timerGlobal = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.tiempoRestanteGlobal > 0) {
        state = state.copyWith(tiempoRestanteGlobal: state.tiempoRestanteGlobal - 1);
      } else {
        timer.cancel();
        finalizarExamen();
      }
    });
  }

  void finalizarExamen() {
    _cancelAllTimers();
    state = state.copyWith(examenFinalizado: true);
    
    if (state.sesionId != null) {
      final double puntajeFinal = state.modo == ModoSimulacro.examenOficial 
          ? state.puntajeOficial 
          : state.respuestasCorrectas.toDouble();
      DBHelper().actualizarPuntajeSesion(state.sesionId!, puntajeFinal);
    }
  }

  @override
  void dispose() {
    _cancelAllTimers();
    super.dispose();
  }
}

final examenProvider = StateNotifierProvider<ExamenNotifier, ExamenState>((ref) {
  return ExamenNotifier();
});
