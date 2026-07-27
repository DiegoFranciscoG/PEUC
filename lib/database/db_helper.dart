import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'dart:io';
import '../models/pregunta.dart';
import '../models/teoria.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return await databaseFactory.openDatabase(
        'peuc_v6.db',
        options: OpenDatabaseOptions(
          version: 18,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        ),
      );
    }
    String path = join(await getDatabasesPath(), 'peuc_v6.db');
    return await openDatabase(
      path,
      version: 18,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE preguntas(
        id TEXT PRIMARY KEY,
        materia TEXT,
        codigo_tema TEXT,
        enunciado TEXT,
        imagen_enunciado TEXT,
        es_opciones_imagen INTEGER,
        opciones TEXT,
        respuesta_correcta TEXT,
        explicacion_detallada TEXT,
        pasos_resolucion TEXT,
        video_explicativo_url TEXT,
        tipo_ejercicio_abstracto TEXT,
        elementos_abstractos TEXT,
        opciones_abstractas TEXT,
        dificultad TEXT,
        nivel_cognitivo TEXT,
        competencia TEXT,
        tiempo_estimado INTEGER,
        origen TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sesiones_examen(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo_simulacro TEXT,
        puntaje_final REAL,
        total_preguntas INTEGER,
        fecha TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE historial_preguntas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sesion_id INTEGER,
        pregunta_id TEXT,
        codigo_tema TEXT,
        acierto INTEGER,
        tiempo_empleado_segundos INTEGER,
        nivel_confianza INTEGER DEFAULT 0,
        fecha TEXT,
        FOREIGN KEY (sesion_id) REFERENCES sesiones_examen (id),
        FOREIGN KEY (pregunta_id) REFERENCES preguntas (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE estadisticas_usuario(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        racha_dias INTEGER DEFAULT 0,
        tiempo_estudio_segundos INTEGER DEFAULT 0,
        ultima_conexion TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE logros_usuario(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        logro_id TEXT,
        fecha_desbloqueo TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE repaso_espaciado(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pregunta_id TEXT,
        facilidad REAL DEFAULT 2.5,
        intervalo INTEGER DEFAULT 0,
        repeticiones INTEGER DEFAULT 0,
        proxima_revision TEXT,
        FOREIGN KEY (pregunta_id) REFERENCES preguntas (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE teoria(
        id TEXT PRIMARY KEY,
        codigo_tema TEXT UNIQUE,
        materia TEXT,
        titulo TEXT,
        contenido_markdown TEXT,
        formula_clave TEXT,
        video_url TEXT
      )
    ''');

    await _cargarJSON(db);
    await _cargarTeoriaJSON(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE preguntas ADD COLUMN dificultad TEXT');
      await db.execute('ALTER TABLE preguntas ADD COLUMN nivel_cognitivo TEXT');
      await db.execute('ALTER TABLE preguntas ADD COLUMN competencia TEXT');
      await db.execute('ALTER TABLE preguntas ADD COLUMN tiempo_estimado INTEGER');
      await db.execute('ALTER TABLE preguntas ADD COLUMN origen TEXT');
      await db.execute('ALTER TABLE historial_preguntas ADD COLUMN nivel_confianza INTEGER DEFAULT 0');
      
      await db.execute('''
        CREATE TABLE estadisticas_usuario(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          racha_dias INTEGER DEFAULT 0,
          tiempo_estudio_segundos INTEGER DEFAULT 0,
          ultima_conexion TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE logros_usuario(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          logro_id TEXT,
          fecha_desbloqueo TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE repaso_espaciado(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pregunta_id TEXT,
          facilidad REAL DEFAULT 2.5,
          intervalo INTEGER DEFAULT 0,
          repeticiones INTEGER DEFAULT 0,
          proxima_revision TEXT,
          FOREIGN KEY (pregunta_id) REFERENCES preguntas (id)
        )
      ''');

      await _cargarJSON(db);
    }
    
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE teoria(
          id TEXT PRIMARY KEY,
          codigo_tema TEXT,
          materia TEXT,
          titulo TEXT,
          contenido_markdown TEXT,
          formula_clave TEXT,
          video_url TEXT
        )
      ''');
      await _cargarTeoriaJSON(db);
    }

    if (oldVersion < 4) {
      // Version 4 forces a reload of JSON to clean up any mojibake or ghost placeholders
      await _cargarJSON(db);
      await _cargarTeoriaJSON(db);
    }
    if (oldVersion < 6) {
      // Version 6: P.E.U.C. complete clean rebuild with validated content
      await db.execute('DELETE FROM preguntas');
      await db.execute('DELETE FROM teoria');
      await _cargarJSON(db);
      await _cargarTeoriaJSON(db);
    }
    if (oldVersion < 15) {
      // Version 15: Fix LaTeX Markdown, YouTube links and empty question loading
      await db.execute('DROP TABLE IF EXISTS preguntas');
      await db.execute('DROP TABLE IF EXISTS sesiones_examen');
      await db.execute('DROP TABLE IF EXISTS historial_preguntas');
      await db.execute('DROP TABLE IF EXISTS estadisticas_usuario');
      await db.execute('DROP TABLE IF EXISTS logros_usuario');
      await db.execute('DROP TABLE IF EXISTS repaso_espaciado');
      await db.execute('DROP TABLE IF EXISTS teoria');
      await _onCreate(db, newVersion);
    }
    if (oldVersion < 16) {
      await db.execute('DELETE FROM preguntas');
      await db.execute('DELETE FROM teoria');
      await _cargarJSON(db);
      await _cargarTeoriaJSON(db);
    }
    if (oldVersion < 17) {
      // Version 17: Fix null IDs on Ciencias Sociales questions - reload full JSON with proper IDs
      await db.execute('DELETE FROM preguntas');
      await _cargarJSON(db);
    }
    if (oldVersion < 18) {
      // Version 18: Fix broken schema objects in Ciencias Sociales
      await db.execute('DELETE FROM preguntas');
      await _cargarJSON(db);
    }
  }

  Future<void> forzarActualizacionDeContenido() async {
    final db = await database;
    await db.execute('DELETE FROM preguntas');
    await db.execute('DELETE FROM teoria');
    await _cargarJSON(db);
    await _cargarTeoriaJSON(db);
  }

  Future<void> _cargarJSON(Database db) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final useDownloaded = prefs.getBool('use_downloaded_content') ?? false;
      final downloadedPath = prefs.getString('downloaded_preguntas_path');
      
      String response;
      if (useDownloaded && downloadedPath != null && await File(downloadedPath).exists()) {
        response = await File(downloadedPath).readAsString();
      } else {
        response = await rootBundle.loadString('assets/data/preguntas.json');
      }
      
      final List<dynamic> data = json.decode(response);
      
      Batch batch = db.batch();
      List<String> validIds = [];
      for (var rawMap in data) {
        final preguntaMap = Map<String, dynamic>.from(rawMap);
        validIds.add(preguntaMap['id'] ?? '');

      // Support both camelCase (new questions) and snake_case (old questions)
      final codigoTema = preguntaMap['codigoTema'] ?? preguntaMap['codigo_tema'] ?? '';
      final respuestaCorrecta = preguntaMap['respuestaCorrecta'] ?? preguntaMap['respuesta_correcta'] ?? '';
      final explicacionDetallada = preguntaMap['explicacionDetallada'] ?? preguntaMap['explicacion_detallada'] ?? '';
      final imagenEnunciado = preguntaMap['imagenEnunciado'] ?? preguntaMap['imagen_enunciado'];
      final esOpcionesImagen = preguntaMap['esOpcionesImagen'] ?? preguntaMap['es_opciones_imagen'] ?? false;
      final videoExplicativoUrl = preguntaMap['videoExplicativoUrl'] ?? preguntaMap['video_explicativo_url'];
      final tipoEjercicioAbstracto = preguntaMap['tipoEjercicioAbstracto'] ?? preguntaMap['tipo_ejercicio_abstracto'];
      final elementosAbstractos = preguntaMap['elementosAbstractos'] ?? preguntaMap['elementos_abstractos'];
      final opcionesAbstractas = preguntaMap['opcionesAbstractas'] ?? preguntaMap['opciones_abstractas'];
      
      // pasos_resolucion (snake) or pasosResolucion (camel)
      final pasosRaw = preguntaMap['pasosResolucion'] ?? preguntaMap['pasos_resolucion'];

      // opciones - could already be a List or a JSON string
      String opcionesJson;
      final opcionesRaw = preguntaMap['opciones'];
      if (opcionesRaw is List) {
        opcionesJson = json.encode(opcionesRaw);
      } else {
        opcionesJson = opcionesRaw?.toString() ?? '[]';
      }

      final dificultad = preguntaMap['dificultad'] ?? 'Medio';
      final nivelCognitivo = preguntaMap['nivelCognitivo'] ?? preguntaMap['nivel_cognitivo'] ?? 'Comprension';
      final competencia = preguntaMap['competencia'] ?? 'General';
      final tiempoEstimado = preguntaMap['tiempoEstimado'] ?? preguntaMap['tiempo_estimado'] ?? 60;
      final origen = preguntaMap['origen'] ?? 'banco_original';

      // FORZAR MATERIA SEGÚN EL PRIMER DÍGITO DEL CÓDIGO
      String materiaCorregida = preguntaMap['materia'] ?? '';
      if (codigoTema.startsWith('1.')) materiaCorregida = 'Matemáticas';
      else if (codigoTema.startsWith('2.')) materiaCorregida = 'Lengua y Literatura';
      else if (codigoTema.startsWith('3.')) materiaCorregida = 'Ciencias Naturales';
      else if (codigoTema.startsWith('4.')) materiaCorregida = 'Ciencias Sociales';
      else if (codigoTema.startsWith('5.')) materiaCorregida = 'Razonamiento Abstracto';
      
      Map<String, dynamic> p = {
        'id': preguntaMap['id'],
        'materia': materiaCorregida,
        'enunciado': preguntaMap['enunciado'],
        'codigo_tema': codigoTema,
        'respuesta_correcta': respuestaCorrecta,
        'explicacion_detallada': explicacionDetallada,
        'opciones': opcionesJson,
        'imagen_enunciado': imagenEnunciado,
        'es_opciones_imagen': (esOpcionesImagen == true || esOpcionesImagen == 1) ? 1 : 0,
        'video_explicativo_url': videoExplicativoUrl,
        'tipo_ejercicio_abstracto': tipoEjercicioAbstracto,
        'pasos_resolucion': pasosRaw != null ? (pasosRaw is String ? pasosRaw : json.encode(pasosRaw)) : null,
        'elementos_abstractos': elementosAbstractos != null ? (elementosAbstractos is String ? elementosAbstractos : json.encode(elementosAbstractos)) : null,
        'opciones_abstractas': opcionesAbstractas != null ? (opcionesAbstractas is String ? opcionesAbstractas : json.encode(opcionesAbstractas)) : null,
        'dificultad': dificultad,
        'nivel_cognitivo': nivelCognitivo,
        'competencia': competencia,
        'tiempo_estimado': tiempoEstimado,
        'origen': origen,
      };

      batch.insert(
        'preguntas',
        p,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

      if (validIds.isNotEmpty) {
        final existingRows = await db.query('preguntas', columns: ['id']);
        for (var row in existingRows) {
          final existingId = row['id'] as String;
          if (!validIds.contains(existingId)) {
            await db.delete('preguntas', where: 'id = ?', whereArgs: [existingId]);
          }
        }
      }
    } catch (e) {
      print('🛑 ERROR CRÍTICO CARGANDO JSON: \$e');
    }
  }

  // ── Modos de Consulta ──────────────────────────────────────────────

  Future<List<Pregunta>> getSimulacroGeneral(int limit) async {
    final db = await database;
    List<Pregunta> seleccionadas = [];
    
    final materias = [
      'Matemáticas',
      'Lengua y Literatura',
      'Ciencias Naturales',
      'Ciencias Sociales',
      'Razonamiento Abstracto'
    ];
    
    int limitPerSubject = (limit / materias.length).ceil();

    for (var materia in materias) {
      String prefix = '';
      if (materia == 'Matemáticas') prefix = '1.%';
      else if (materia == 'Lengua y Literatura') prefix = '2.%';
      else if (materia == 'Ciencias Naturales') prefix = '3.%';
      else if (materia == 'Ciencias Sociales') prefix = '4.%';
      else if (materia == 'Razonamiento Abstracto') prefix = '5.%';

      final res = await db.query(
        'preguntas',
        where: 'codigo_tema LIKE ?',
        whereArgs: [prefix],
        orderBy: 'RANDOM()',
        limit: limitPerSubject,
      );
      seleccionadas.addAll(res.map((json) => Pregunta.fromMap(json)).toList());
    }
    
    int remaining = limit - seleccionadas.length;
    if (remaining > 0) {
      List<String> excludedIds = seleccionadas.map((e) => e.id).toList();
      String placeholders = excludedIds.map((e) => '?').join(',');
      String whereClause = excludedIds.isNotEmpty ? 'id NOT IN ($placeholders)' : '';
      
      final randomRes = await db.query(
        'preguntas',
        where: whereClause.isEmpty ? null : whereClause,
        whereArgs: excludedIds.isEmpty ? null : excludedIds,
        orderBy: 'RANDOM()',
        limit: remaining,
      );
      seleccionadas.addAll(randomRes.map((json) => Pregunta.fromMap(json)).toList());
    }

    return seleccionadas..shuffle();
  }

  Future<List<Pregunta>> getSimulacroAdaptativo(int limit) async {
    final db = await database;
    
    // Calcular rendimiento por subtema
    final List<Map<String, dynamic>> stats = await db.rawQuery('''
      SELECT codigo_tema, 
             CAST(SUM(acierto) AS FLOAT) / COUNT(*) as rendimiento,
             COUNT(*) as total_intentos
      FROM historial_preguntas
      GROUP BY codigo_tema
    ''');

    List<String> debiles = [];
    List<String> medios = [];
    List<String> dominados = [];

    for (var row in stats) {
      double r = row['rendimiento'] as double;
      String cod = row['codigo_tema'] as String;
      if (r < 0.5) {
        debiles.add(cod);
      } else if (r < 0.8) {
        medios.add(cod);
      } else {
        dominados.add(cod);
      }
    }

    int qDebiles = (limit * 0.4).round();
    int qMedios = (limit * 0.3).round();
    int qDominados = (limit * 0.2).round();
    int qRandom = limit - qDebiles - qMedios - qDominados;

    List<Pregunta> seleccionadas = [];

    // Helper para extraer de una lista de subtemas
    Future<void> extraerPorGrupo(List<String> subtemas, int cantidad) async {
      if (cantidad <= 0) return;
      if (subtemas.isEmpty) {
        qRandom += cantidad; // Si no hay suficientes subtemas en este grupo, pasarlo a random
        return;
      }
      String placeholders = subtemas.map((e) => '?').join(',');
      List<String> excludedIds = seleccionadas.map((e) => e.id).toList();
      String excludedQuery = excludedIds.isNotEmpty ? ' AND id NOT IN (${excludedIds.map((e) => "?").join(",")})' : '';
      
      List<dynamic> args = [...subtemas];
      args.addAll(excludedIds);

      final res = await db.query(
        'preguntas',
        where: 'codigo_tema IN ($placeholders) $excludedQuery',
        whereArgs: args,
        orderBy: 'RANDOM()',
        limit: cantidad,
      );
      seleccionadas.addAll(res.map((json) => Pregunta.fromMap(json)).toList());
      
      // Si no se llenó el cupo, pasar el remanente a random
      qRandom += (cantidad - res.length);
    }

    await extraerPorGrupo(debiles, qDebiles);
    await extraerPorGrupo(medios, qMedios);
    await extraerPorGrupo(dominados, qDominados);

    // Fill the rest with random (10% + overflow)
    if (qRandom > 0) {
      List<String> excludedIds = seleccionadas.map((e) => e.id).toList();
      String whereClause = excludedIds.isNotEmpty ? 'id NOT IN (${excludedIds.map((e) => "?").join(",")})' : '';
      
      final randomRes = await db.query(
        'preguntas',
        where: whereClause.isEmpty ? null : whereClause,
        whereArgs: excludedIds.isEmpty ? null : excludedIds,
        orderBy: 'RANDOM()',
        limit: qRandom,
      );
      seleccionadas.addAll(randomRes.map((json) => Pregunta.fromMap(json)).toList());
    }

    return seleccionadas..shuffle();
  }

  Future<List<Pregunta>> getSimulacroPorMateria(String materia, int limit) async {
    final db = await database;
    String prefix = '';
    if (materia == 'Matemáticas') prefix = '1.%';
    else if (materia == 'Lengua y Literatura') prefix = '2.%';
    else if (materia == 'Ciencias Naturales') prefix = '3.%';
    else if (materia == 'Ciencias Sociales') prefix = '4.%';
    else if (materia == 'Razonamiento Abstracto') prefix = '5.%';

    final res = await db.query(
      'preguntas',
      where: 'codigo_tema LIKE ?',
      whereArgs: [prefix],
      orderBy: 'RANDOM()',
      limit: limit,
    );
    return res.map((json) => Pregunta.fromMap(json)).toList();
  }

  Future<List<Pregunta>> getSimulacroPorSubtema(String codigoTema, int limit) async {
    final db = await database;
    final res = await db.query(
      'preguntas',
      where: 'codigo_tema = ?',
      whereArgs: [codigoTema],
      orderBy: 'RANDOM()',
      limit: limit,
    );
    return res.map((json) => Pregunta.fromMap(json)).toList();
  }
  
  Future<Pregunta?> getPreguntaById(String id) async {
    final db = await database;
    final res = await db.query('preguntas', where: 'id = ?', whereArgs: [id], limit: 1);
    if (res.isNotEmpty) {
      return Pregunta.fromMap(res.first);
    }
    return null;
  }

  // ── Historial y Estadísticas Avanzadas (Fase 4) ──────────────────────

  Future<int> crearSesionExamen(String tipoSimulacro, int totalPreguntas) async {
    final db = await database;
    return await db.insert('sesiones_examen', {
      'tipo_simulacro': tipoSimulacro,
      'total_preguntas': totalPreguntas,
      'puntaje_final': 0.0,
      'fecha': DateTime.now().toIso8601String(),
    });
  }
  
  Future<void> actualizarPuntajeSesion(int sesionId, double puntaje) async {
    final db = await database;
    await db.update('sesiones_examen', {'puntaje_final': puntaje}, where: 'id = ?', whereArgs: [sesionId]);
  }

  Future<void> registrarRespuesta(int sesionId, String preguntaId, String codigoTema, bool acierto, int tiempoSegundos) async {
    final db = await database;
    await db.insert('historial_preguntas', {
      'sesion_id': sesionId,
      'pregunta_id': preguntaId,
      'codigo_tema': codigoTema,
      'acierto': acierto ? 1 : 0,
      'tiempo_empleado_segundos': tiempoSegundos,
      'nivel_confianza': 0,
      'fecha': DateTime.now().toIso8601String(),
    });
  }

  Future<void> actualizarConfianzaRespuesta(int sesionId, String preguntaId, int nivelConfianza) async {
    final db = await database;
    await db.update(
      'historial_preguntas',
      {'nivel_confianza': nivelConfianza},
      where: 'sesion_id = ? AND pregunta_id = ?',
      whereArgs: [sesionId, preguntaId],
    );
  }

  Future<List<Map<String, dynamic>>> getEstadisticasDetalladas() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        p.materia, 
        h.codigo_tema, 
        COUNT(h.id) as total_intentos, 
        SUM(h.acierto) as total_aciertos,
        CAST(SUM(h.acierto) AS FLOAT) / COUNT(h.id) as porcentaje_acierto
      FROM historial_preguntas h
      JOIN preguntas p ON h.pregunta_id = p.id
      GROUP BY p.materia, h.codigo_tema
      ORDER BY p.materia, p.codigo_tema
    ''');
  }

  Future<Map<String, dynamic>> getUsuarioStats() async {
    final db = await database;
    final stats = await db.query('estadisticas_usuario', limit: 1);
    final logros = await db.query('logros_usuario');
    if (stats.isNotEmpty) {
      final stat = Map<String, dynamic>.from(stats.first);
      stat['total_logros'] = logros.length;
      return stat;
    }
    return {'racha_dias': 0, 'tiempo_estudio_segundos': 0, 'total_logros': 0};
  }

  Future<List<Map<String, dynamic>>> getHistorialSesiones() async {
    final db = await database;
    return await db.query('sesiones_examen', orderBy: 'id DESC', limit: 50);
  }
  
  // Devuelve los datos de las preguntas falladas en una sesión específica
  Future<List<Map<String, dynamic>>> getErroresDeSesion(int sesionId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        p.*, h.tiempo_empleado_segundos
      FROM historial_preguntas h
      JOIN preguntas p ON h.pregunta_id = p.id
      WHERE h.sesion_id = ? AND h.acierto = 0
    ''', [sesionId]);
  }

  Future<void> _cargarTeoriaJSON(Database db) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final useDownloaded = prefs.getBool('use_downloaded_content') ?? false;
      final downloadedPath = prefs.getString('downloaded_teoria_path');
      
      String response;
      if (useDownloaded && downloadedPath != null && await File(downloadedPath).exists()) {
        response = await File(downloadedPath).readAsString();
      } else {
        response = await rootBundle.loadString('assets/data/teoria.json');
      }

      final List<dynamic> data = json.decode(response);
        
      Batch batch = db.batch();
      for (var rawMap in data) {
        final teoriaMap = Map<String, dynamic>.from(rawMap);
        batch.insert('teoria', {
          'id': teoriaMap['id'] ?? '',
          'codigo_tema': teoriaMap['codigoTema'] ?? teoriaMap['codigo_tema'] ?? '',
          'materia': teoriaMap['materia'] ?? '',
          'titulo': teoriaMap['titulo'] ?? '',
          'contenido_markdown': teoriaMap['contenidoMarkdown'] ?? teoriaMap['contenido_markdown'] ?? '',
          'formula_clave': teoriaMap['formulaClave'] ?? teoriaMap['formula_clave'] ?? '',
          'video_url': teoriaMap['videoUrl'] ?? teoriaMap['video_url'] ?? '',
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      // Ignore if file is missing
      print('Error cargando teoria: $e');
    }
  }

  Future<Teoria?> getTeoriaPorSubtema(String codigoTema) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'teoria',
      where: 'codigo_tema = ?',
      whereArgs: [codigoTema],
    );

    if (maps.isNotEmpty) {
      return Teoria.fromMap(maps.first);
    }
    return null;
  }
}
