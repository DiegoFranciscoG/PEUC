import 'dart:convert';

class ElementoAbstracto {
  final String icono;
  final int rotacion;
  final String relleno;
  final double tamano;

  ElementoAbstracto({
    required this.icono,
    required this.rotacion,
    required this.relleno,
    required this.tamano,
  });

  factory ElementoAbstracto.fromMap(Map<String, dynamic> map) {
    return ElementoAbstracto(
      icono: map['icono'] as String,
      rotacion: map['rotacion'] as int,
      relleno: map['relleno'] as String,
      tamano: (map['tamano'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icono': icono,
      'rotacion': rotacion,
      'relleno': relleno,
      'tamano': tamano,
    };
  }
}

class Pregunta {
  final String id;
  final String materia;
  final String codigoTema;
  final String enunciado;
  final String? imagenEnunciado;
  final bool esOpcionesImagen;
  final List<String> opciones;
  final String respuestaCorrecta;
  final String explicacionDetallada;
  
  // Advanced Pedagogy Fields
  final String dificultad; // Facil, Medio, Dificil, Experto
  final String nivelCognitivo; // Ej: Aplicacion, Analisis, Memoria
  final String competencia; // Competencia evaluada
  final int tiempoEstimado; // En segundos
  final String origen; // banco_original, documento_pdf, generada_ia, algoritmo
  
  // Advanced EdTech Fields (Symbolab-style & Video)
  final List<String>? pasosResolucion;
  final String? videoExplicativoUrl;
  
  // Abstract Reasoning Fields
  final String? tipoEjercicioAbstracto;
  final List<ElementoAbstracto>? elementosAbstractos;
  final List<ElementoAbstracto>? opcionesAbstractas;
  final int? indiceRespuestaCorrectaAbstracta;

  Pregunta({
    required this.id,
    required this.materia,
    required this.codigoTema,
    required this.enunciado,
    this.imagenEnunciado,
    this.esOpcionesImagen = false,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacionDetallada,
    this.dificultad = 'Medio',
    this.nivelCognitivo = 'Comprension',
    this.competencia = 'General',
    this.tiempoEstimado = 60,
    this.origen = 'banco_original',
    this.pasosResolucion,
    this.videoExplicativoUrl,
    this.tipoEjercicioAbstracto,
    this.elementosAbstractos,
    this.opcionesAbstractas,
    this.indiceRespuestaCorrectaAbstracta,
  });

  factory Pregunta.fromMap(Map<String, dynamic> map) {
    List<ElementoAbstracto>? elementosAbstractos;
    if (map['elementos_abstractos'] != null) {
      final parsed = json.decode(map['elementos_abstractos']) as List;
      elementosAbstractos = parsed.map((e) => ElementoAbstracto.fromMap(e)).toList();
    }

    List<ElementoAbstracto>? opcionesAbstractas;
    if (map['opciones_abstractas'] != null) {
      final parsed = json.decode(map['opciones_abstractas']) as List;
      opcionesAbstractas = parsed.map((e) => ElementoAbstracto.fromMap(e)).toList();
    }
    
    List<String>? pasosResolucion;
    if (map['pasos_resolucion'] != null) {
      pasosResolucion = List<String>.from(json.decode(map['pasos_resolucion']));
    }

    return Pregunta(
      id: map['id'] as String,
      materia: map['materia'] as String,
      codigoTema: map['codigo_tema'] as String,
      enunciado: map['enunciado'] as String,
      imagenEnunciado: map['imagen_enunciado'] as String?,
      esOpcionesImagen: (map['es_opciones_imagen'] == 1 || map['es_opciones_imagen'] == true),
      opciones: List<String>.from(json.decode(map['opciones'].toString()) ?? []),
      respuestaCorrecta: map['respuesta_correcta'] as String,
      explicacionDetallada: map['explicacion_detallada'] as String,
      dificultad: map['dificultad'] as String? ?? 'Medio',
      nivelCognitivo: map['nivel_cognitivo'] as String? ?? 'Comprension',
      competencia: map['competencia'] as String? ?? 'General',
      tiempoEstimado: map['tiempo_estimado'] as int? ?? 60,
      origen: map['origen'] as String? ?? 'banco_original',
      pasosResolucion: pasosResolucion,
      videoExplicativoUrl: map['video_explicativo_url'] as String?,
      tipoEjercicioAbstracto: map['tipo_ejercicio_abstracto'] as String?,
      elementosAbstractos: elementosAbstractos,
      opcionesAbstractas: opcionesAbstractas,
      indiceRespuestaCorrectaAbstracta: int.tryParse(map['respuesta_correcta'].toString()),
    );
  }
}
