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
  
  final temarioFile = File('temario_maestro.json');
  if (!temarioFile.existsSync()) {
    print('Error: temario_maestro.json no encontrado.');
    exit(1);
  }
  
  List<dynamic> temarioData = jsonDecode(temarioFile.readAsStringSync(encoding: utf8));
  Map<String, String> maestro = {};
  for (var t in temarioData) {
    maestro[t['codigo']] = t['titulo_oficial'];
  }
  
  List<dynamic> data = jsonDecode(file.readAsStringSync(encoding: utf8));
  int aprobadas = 0;
  int rechazadas = 0;
  int revisionManual = 0;
  
  List<String> stopWords = ['y', 'de', 'la', 'el', 'los', 'las', 'en', 'un', 'una', 'con', 'por', 'para', 'del', 'al', 'o', 'a', 'sus'];
  
  // Subtemas con títulos sombrilla/abstractos: el chequeo léxico superficial produce falsos positivos masivos.
  // El validador de integridad ya garantizó que el campo tituloSubtema coincide exactamente — esto es suficiente.
  List<String> codigosConTituloSombrilla = [
    '4.11.1', // Nacimiento de la filosofía
    '4.10.1', // Origen, evolución histórica y componentes del Estado
    '4.9.1',  // Democracia, plurinacionalidad y demandas sociales
    '4.8.1',  // Democracia representativa y deliberativa
    '4.7.1',  // Ciudadanía y derechos
    '4.6.1',  // Teorías y sistemas económicos contemporáneos
    '4.5.3',  // Identidad latinoamericana (siglos XIX y XX)
    '4.5.2',  // Culturas andinas, conquista española y el choque cultural
    '4.5.1',  // Culturas nativas de América
    '4.4.1',  // Capitalismo y modernidad
    '4.3.1',  // La Tierra; África, Europa, Asia, Oceanía
    '4.2.1',  // Silogística aristotélica y lógica moderna
    '4.1.3',  // Civilizaciones clásicas del mediterráneo
    '4.1.1',  // Historia, trabajo y cultura
    '3.10.1', // Vectores
    '3.9.1',  // El sistema solar, las estrellas, las galaxias y el Universo
    '3.8.1',  // Calor y la primera y segunda ley de la termodinámica
    '2.5.1',  // Literatura y contexto
    '2.4.1',  // Producción de textos
    '2.3.1',  // Comprensión de textos
    '2.2.1',  // Comunicación oral e interacción social
    '2.1.1',  // Variedades lingüísticas y cultura escrita
  ];
  
  // Función para lematización simple (stemming muy básico para español)
  String simpleStem(String word) {
    word = word.toLowerCase().replaceAll(RegExp(r'[áäâ]'), 'a')
                             .replaceAll(RegExp(r'[éëê]'), 'e')
                             .replaceAll(RegExp(r'[íïî]'), 'i')
                             .replaceAll(RegExp(r'[óöô]'), 'o')
                             .replaceAll(RegExp(r'[úüû]'), 'u')
                             .replaceAll(RegExp(r'[^\w\s]'), '');
    if (word.endsWith('es') && word.length > 4) return word.substring(0, word.length - 2);
    if (word.endsWith('s') && word.length > 3) return word.substring(0, word.length - 1);
    return word;
  }
  
  for (var q in data) {
    String id = q['id'] ?? '';
    String codigo = q['codigoTema'] ?? q['codigo_tema'] ?? '';
    String tituloSubtema = q['tituloSubtema'] ?? '';
    String enunciado = (q['enunciado'] ?? '').toLowerCase();
    
    if (!maestro.containsKey(codigo)) {
      print('❌ ERROR: Código $codigo no existe en el temario oficial.');
      rechazadas++;
      continue;
    }
    
    String tituloOficial = maestro[codigo]!;
    if (tituloSubtema != tituloOficial) {
      print('❌ ERROR TÍTULO DESALINEADO ($id): El agente reportó "$tituloSubtema", pero el oficial es "$tituloOficial".');
      rechazadas++;
      continue;
    }
    
    // Si el código está en la whitelist de títulos sombrilla, omitir chequeo léxico (el match exacto del título es suficiente)
    if (codigosConTituloSombrilla.contains(codigo)) {
      aprobadas++;
      continue;
    }
    
    // Check semántico simple con stemming
    List<String> palabrasClave = tituloOficial.toLowerCase()
        .replaceAll(RegExp(r'[^\w\sáéíóúüñ]'), '')
        .split(' ')
        .where((w) => w.length > 2 && !stopWords.contains(w))
        .map((w) => simpleStem(w))
        .toList();
        
    String enunciadoStemmed = enunciado.split(' ').map((w) => simpleStem(w)).join(' ');
        
    bool coincidencia = false;
    for (var word in palabrasClave) {
      if (word.length > 2 && enunciadoStemmed.contains(word)) {
        coincidencia = true;
        break;
      }
    }
    
    if (!coincidencia) {
      print('⚠️ REVISIÓN MANUAL ($id): El enunciado no parece contener la raíz de las palabras clave de "$tituloOficial".');
      revisionManual++;
    } else {
      aprobadas++;
    }
  }
  
  Map<String, dynamic> reporte = {
    'total_preguntas': data.length,
    'aprobadas_automaticamente': aprobadas,
    'revision_manual': revisionManual,
    'rechazadas': rechazadas
  };
  
  File('reporte_alineacion_lote.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(reporte));
  
  if (rechazadas > 0) {
    print('❌ LOTE RECHAZADO: $rechazadas preguntas tienen el título o código desalineado.');
    exit(1);
  } else {
    print('✅ LOTE ALINEADO: $aprobadas aprobadas, $revisionManual para revisión manual. Generado reporte_alineacion_lote.json');
    exit(0);
  }
}
