import 'dart:io';
import 'dart:convert';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Error: Se debe proporcionar la ruta del archivo JSON a validar.');
    exit(1);
  }
  
  final file = File(args[0]);
  if (!file.existsSync()) {
    print('Error: Archivo no encontrado: ${args[0]}');
    exit(1);
  }
  
  List<dynamic> data = jsonDecode(file.readAsStringSync(encoding: utf8));
  int errores = 0;
  
  for (var q in data) {
    String id = q['id'] ?? '';
    String materia = q['materia'] ?? '';
    String codigo = q['codigoTema'] ?? q['codigo_tema'] ?? '';
    List<dynamic>? opciones = q['opciones'];
    String respuesta = q['respuesta_correcta'] ?? q['respuestaCorrecta'] ?? '';
    String enunciado = q['enunciado'] ?? '';
    
    // Validar aislamiento de código vs materia
    bool errorMateria = false;
    if (materia == 'Matemáticas' && !codigo.startsWith('1.')) errorMateria = true;
    if (materia == 'Lengua y Literatura' && !codigo.startsWith('2.')) errorMateria = true;
    if (materia == 'Ciencias Naturales' && !codigo.startsWith('3.')) errorMateria = true;
    if (materia == 'Ciencias Sociales' && !codigo.startsWith('4.')) errorMateria = true;
    if (materia == 'Razonamiento Abstracto' && !codigo.startsWith('5.')) errorMateria = true;
    
    if (errorMateria) {
      print('❌ ERROR INTEGRIDAD: ID $id tiene materia "$materia" pero código "$codigo".');
      errores++;
    }
    
    // Validar opciones y respuesta
    List<dynamic>? opcionesList;
    if (opciones is String) {
      try {
        opcionesList = jsonDecode(opciones as String);
      } catch (_) {}
    } else if (opciones is List) {
      opcionesList = opciones;
    }

    if (opcionesList == null || opcionesList.length != 4) {
      print('❌ ERROR FORMATO: ID $id no tiene 4 opciones (tiene ${opcionesList?.length ?? 0}).');
      errores++;
    } else {
      bool hasEmptyOption = false;
      for (var op in opcionesList) {
        if (op == null || op.toString().trim().isEmpty) hasEmptyOption = true;
      }
      if (hasEmptyOption) {
        print('❌ ERROR FORMATO: ID $id contiene opciones vacías.');
        errores++;
      }

      bool matchFound = false;
      for (var op in opcionesList) {
        if (op.toString().trim() == respuesta.trim() || 
            op.toString().trim().contains(respuesta.trim()) || 
            respuesta.trim().contains(op.toString().trim())) {
          matchFound = true;
          break;
        }
      }
      if (!matchFound) {
        print('❌ ERROR LÓGICO: ID $id la respuesta_correcta ("$respuesta") NO está dentro de las opciones.');
        errores++;
      }
    }
    // Validar que no haya placeholders prohibidos
    final regexes = [
      RegExp(r'Pregunta Académica', caseSensitive: false),
      RegExp(r'según el currículo oficial', caseSensitive: false),
      RegExp(r'postulado incorrecto', caseSensitive: false),
    ];
    for (var r in regexes) {
      if (r.hasMatch(enunciado) || (opciones != null && r.hasMatch(opciones.join(' ')))) {
        print('❌ ERROR PLACEHOLDER: ID $id contiene texto basura/metatexto prohibido.');
        errores++;
      }
    }
  }
  
  if (errores == 0) {
    print('✅ INTEGRIDAD PERFECTA: El lote de ${data.length} preguntas pasó todas las validaciones de materia, código, opciones y placeholders.');
    exit(0);
  } else {
    print('❌ VALIDACIÓN FALLIDA: Se encontraron $errores errores. EL LOTE NO DEBE SER MERGEADO.');
    exit(1);
  }
}
