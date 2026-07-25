import 'dart:convert';
import 'dart:io';

String fixMojibake(String text) {
  if (text.contains('Ã©') || text.contains('Ã±') || text.contains('Ã')) {
    try {
      return utf8.decode(latin1.encode(text), allowMalformed: true);
    } catch (e) {
      return text;
    }
  }
  return text;
}

void main() {
  print('=== EJECUTANDO LIMPIEZA TAREA 1 Y 3 ===');

  List<dynamic> temario = jsonDecode(File('assets/data/temario_maestro.json').readAsStringSync());
  Set<String> codigosValidos = temario.map((t) => t['codigo'].toString()).toSet();

  // 1. Limpiar Preguntas (Fantasmas + Mojibake)
  List<dynamic> preguntas = jsonDecode(File('assets/data/preguntas.json').readAsStringSync());
  List<dynamic> preguntasLimpias = [];
  int fantasmasBorrados = 0;
  int preguntasFijas = 0;

  for (var p in preguntas) {
    Map<String, dynamic> q = Map<String, dynamic>.from(p);
    String cod = q['codigo_tema']?.toString() ?? '';
    
    if (!codigosValidos.contains(cod)) {
      fantasmasBorrados++;
      continue;
    }

    // Fix Mojibake
    bool fixed = false;
    if (q['enunciado'] != null) {
      String oldText = q['enunciado'].toString();
      q['enunciado'] = fixMojibake(oldText);
      if (oldText != q['enunciado']) fixed = true;
    }
    
    if (q['opciones'] != null) {
      List<dynamic> ops = q['opciones'];
      for (int i = 0; i < ops.length; i++) {
        String oldOp = ops[i].toString();
        ops[i] = fixMojibake(oldOp);
        if (oldOp != ops[i]) fixed = true;
      }
    }
    
    if (q['respuesta_correcta'] != null) {
      String oldR = q['respuesta_correcta'].toString();
      q['respuesta_correcta'] = fixMojibake(oldR);
      if (oldR != q['respuesta_correcta']) fixed = true;
    }
    
    if (q['explicacion_detallada'] != null) {
      String oldEx = q['explicacion_detallada'].toString();
      q['explicacion_detallada'] = fixMojibake(oldEx);
      if (oldEx != q['explicacion_detallada']) fixed = true;
    }

    // Fix Materia Cruzada en Preguntas Matemáticas (la Tarea 0 mostró que todas las matemáticas estaban mal cruzadas con Ciencias Sociales o similar)
    // Wait, let's fix the 'Materia Correcta' issue by looking up the real materia in temario_maestro
    var temaMaestro = temario.firstWhere((t) => t['codigo'] == cod, orElse: () => null);
    if (temaMaestro != null) {
      q['materia'] = temaMaestro['area'] ?? temaMaestro['materia'];
    }

    if (fixed) preguntasFijas++;
    preguntasLimpias.add(q);
  }

  File('assets/data/preguntas.json').writeAsStringSync(jsonEncode(preguntasLimpias));
  print('Preguntas fantasmas borradas: ' + fantasmasBorrados.toString());
  print('Preguntas con mojibake reparado: ' + preguntasFijas.toString());

  // 2. Limpiar Teoría (Fantasmas + Mojibake)
  List<dynamic> teoria = jsonDecode(File('assets/data/teoria.json').readAsStringSync());
  List<dynamic> teoriaLimpia = [];
  int teoriaFantasmas = 0;
  int teoriaFija = 0;

  for (var t in teoria) {
    Map<String, dynamic> teo = Map<String, dynamic>.from(t);
    String cod = teo['codigo_tema']?.toString() ?? '';
    
    if (!codigosValidos.contains(cod)) {
      teoriaFantasmas++;
      continue;
    }

    bool fixed = false;
    if (teo['titulo'] != null) {
      String oldText = teo['titulo'].toString();
      teo['titulo'] = fixMojibake(oldText);
      if (oldText != teo['titulo']) fixed = true;
    }
    
    if (teo['contenido_markdown'] != null) {
      String oldText = teo['contenido_markdown'].toString();
      teo['contenido_markdown'] = fixMojibake(oldText);
      if (oldText != teo['contenido_markdown']) fixed = true;
    }
    
    var temaMaestro = temario.firstWhere((tm) => tm['codigo'] == cod, orElse: () => null);
    if (temaMaestro != null) {
      teo['materia'] = temaMaestro['area'] ?? temaMaestro['materia'];
    }

    if (fixed) teoriaFija++;
    teoriaLimpia.add(teo);
  }

  File('assets/data/teoria.json').writeAsStringSync(jsonEncode(teoriaLimpia));
  print('Teorías fantasmas borradas: ' + teoriaFantasmas.toString());
  print('Teorías con mojibake reparado: ' + teoriaFija.toString());

}
