import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pregunta.dart';

class ApiService {
  static const String _cacheKey = 'preguntas_cache';

  /// Obtiene las preguntas priorizando la caché. Si no hay caché o se fuerza actualización,
  /// simula una descarga desde la nube.
  Future<List<Pregunta>> obtenerPreguntas({bool forzarActualizacion = false}) async {
    final prefs = await SharedPreferences.getInstance();

    if (!forzarActualizacion && prefs.containsKey(_cacheKey)) {
      // Cargar desde caché local
      final String? jsonString = prefs.getString(_cacheKey);
      if (jsonString != null) {
        return _decodificarPreguntas(jsonString);
      }
    }

    // Simulación de descarga desde web
    // En producción aquí iría: await http.get(Uri.parse('https://api.ejemplo.com/preguntas'));
    // Para la prueba, cargamos el JSON local simulando latencia de red.
    await Future.delayed(const Duration(seconds: 2)); 
    final String jsonString = await rootBundle.loadString('assets/data/preguntas_mock.json');

    // Guardar en caché
    await prefs.setString(_cacheKey, jsonString);

    return _decodificarPreguntas(jsonString);
  }

  List<Pregunta> _decodificarPreguntas(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((item) => Pregunta.fromMap(item)).toList();
  }
}
