import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database/db_helper.dart';
import 'subtema_teoria_screen.dart';

class CentroEstudioScreen extends StatefulWidget {
  const CentroEstudioScreen({super.key});

  @override
  State<CentroEstudioScreen> createState() => CentroEstudioScreenState();
}

class CentroEstudioScreenState extends State<CentroEstudioScreen> {
  // Estructura fija: materia → lista de subtemas del temario oficial
  Map<String, List<Map<String, dynamic>>> temariosOficiales = {};
  // Conteo real de preguntas de la BD por codigo_tema
  Map<String, int> conteoPreguntas = {};
  bool isLoading = true;

  final Map<String, IconData> _materiaIcons = {
    'Matemáticas': Icons.calculate_rounded,
    'Razonamiento Abstracto': Icons.psychology_rounded,
    'Lengua y Literatura': Icons.menu_book_rounded,
    'Ciencias Naturales': Icons.science_rounded,
    'Ciencias Sociales': Icons.public_rounded,
  };

  final Map<String, Color> _materiaColors = {
    'Matemáticas': const Color(0xFF4F8EF7),
    'Razonamiento Abstracto': const Color(0xFFAB47BC),
    'Lengua y Literatura': const Color(0xFF26A69A),
    'Ciencias Naturales': const Color(0xFF66BB6A),
    'Ciencias Sociales': const Color(0xFFFF7043),
  };

  final Map<String, LinearGradient> _materiaGradients = {
    'Matemáticas': const LinearGradient(colors: [Color(0xFF4F8EF7), Color(0xFF2563EB)]),
    'Razonamiento Abstracto': const LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF7B1FA2)]),
    'Lengua y Literatura': const LinearGradient(colors: [Color(0xFF26A69A), Color(0xFF00796B)]),
    'Ciencias Naturales': const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF388E3C)]),
    'Ciencias Sociales': const LinearGradient(colors: [Color(0xFFFF7043), Color(0xFFE64A19)]),
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 1. Cargar temario oficial (fuente de verdad fija)
      final String temarioStr = await rootBundle.loadString('assets/data/temario_maestro.json');
      final List<dynamic> temarioList = jsonDecode(temarioStr);

      Map<String, List<Map<String, dynamic>>> grupos = {};
      for (var t in temarioList) {
        final materia = t['area'] as String;
        if (!grupos.containsKey(materia)) {
          grupos[materia] = [];
        }
        grupos[materia]!.add({
          'codigo': t['codigo'],
          'titulo': t['titulo_oficial'] ?? t['titulo'] ?? 'Subtema',
          'area': materia,
        });
      }

      // 2. Contar preguntas reales por codigo_tema desde la BD
      final db = await DBHelper().database;
      final res = await db.rawQuery('''
        SELECT codigo_tema, COUNT(id) as total
        FROM preguntas
        GROUP BY codigo_tema
      ''');

      Map<String, int> conteo = {};
      for (var row in res) {
        final codigo = row['codigo_tema'] as String? ?? '';
        conteo[codigo] = row['total'] as int? ?? 0;
      }

      setState(() {
        temariosOficiales = grupos;
        conteoPreguntas = conteo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        temariosOficiales = {};
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalSubtemas = temariosOficiales.values.fold(0, (acc, l) => acc + l.length);
    final totalPreguntas = conteoPreguntas.values.fold(0, (acc, v) => acc + v);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF4F8EF7)))
          : temariosOficiales.isEmpty
              ? const Center(child: Text('Contenido en actualización para este tema', style: TextStyle(color: Colors.white, fontSize: 16)))
              : CustomScrollView(
                  slivers: [
                SliverAppBar(
                  expandedHeight: 160,
                  pinned: true,
                  backgroundColor: const Color(0xFF1A1D2E),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('P.E.U.C.', style: TextStyle(color: Color(0xFF4F8EF7), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        const Text('Centro de Estudio', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1A1D2E), Color(0xFF12152B)],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 60, 16, 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _statChip(Icons.library_books_rounded, '$totalSubtemas', 'Subtemas'),
                            _statChip(Icons.quiz_rounded, '$totalPreguntas', 'Preguntas'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final materia = temariosOficiales.keys.elementAt(index);
                        final subtemas = temariosOficiales[materia]!;
                        final color = _materiaColors[materia] ?? Colors.blueGrey;
                        final gradient = _materiaGradients[materia];
                        final icon = _materiaIcons[materia] ?? Icons.school_rounded;
                        final totalQ = subtemas.fold<int>(0, (acc, s) => acc + (conteoPreguntas[s['codigo']] ?? 0));

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1D2E),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              leading: Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(icon, color: Colors.white, size: 24),
                              ),
                              title: Text(
                                materia,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                              ),
                              subtitle: Text(
                                '${subtemas.length} subtemas • $totalQ preguntas',
                                style: TextStyle(color: color.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                              children: subtemas.map((s) {
                                final codigo = s['codigo'] as String;
                                final titulo = s['titulo'] as String;
                                final qCount = conteoPreguntas[codigo] ?? 0;
                                final hasEnough = qCount >= 20;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: color.withValues(alpha: 0.15), width: 0.5),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                    leading: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(codigo, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                    title: Text(titulo, style: const TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w500)),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          hasEnough ? Icons.check_circle_rounded : Icons.pending_rounded,
                                          size: 12,
                                          color: hasEnough ? Colors.greenAccent : Colors.orange,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$qCount preguntas',
                                          style: TextStyle(fontSize: 11, color: hasEnough ? Colors.greenAccent : Colors.orange),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.chevron_right_rounded, color: color.withValues(alpha: 0.6), size: 20),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubtemaTeoriaScreen(
                                            codigoTema: codigo,
                                            nombreSubtema: titulo,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      childCount: temariosOficiales.keys.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF4F8EF7), size: 22),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}
