import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_screen.dart'; 
import '../providers/examen_provider.dart';
import 'simulacion_screen.dart';
import '../database/db_helper.dart';
import 'revision_errores_screen.dart';
import 'centro_estudio_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const _InicioTab(),
      const MainScreen(), // Materias list
      const CentroEstudioScreen(), // Centro de Estudio
      const _RendimientoTab(),
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF4F8EF7),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Práctica'),
          BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Estudio'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Rendimiento'),
        ],
      ),
    );
  }
}

class _InicioTab extends ConsumerWidget {
  const _InicioTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(examenProvider.notifier);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulador UCuenca',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.5),
            ),
            const SizedBox(height: 8),
            const Text('Nivel Avanzado EdTech', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 40),
            
            // Examen Oficial Button
            _BigButton(
              title: 'Examen Oficial (60 min)',
              subtitle: '60 preguntas, temporizador global, puntaje estricto (+1 / -0.5)',
              icon: Icons.timer_rounded,
              color: const Color(0xFFDB2777),
              onTap: () {
                notifier.iniciarExamenOficial();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SimulacionScreen()));
              },
            ),
            const SizedBox(height: 20),
            
            // Examen Adaptativo Button (Anki SM-2)
            _BigButton(
              title: 'Examen Adaptativo',
              subtitle: 'IA que prioriza tus debilidades y espacia repasos (SM-2)',
              icon: Icons.auto_awesome,
              color: const Color(0xFF10B981),
              onTap: () {
                notifier.iniciarExamenAdaptativo();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SimulacionScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Simulacro Inteligente Button
            _BigButton(
              title: 'Simulacro General',
              subtitle: 'Práctica aleatoria equilibrada de todas las materias',
              icon: Icons.psychology_rounded,
              color: const Color(0xFF4F8EF7),
              onTap: () {
                notifier.iniciarSimulacroIntensivo();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SimulacionScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _BigButton({required this.title, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RendimientoTab extends StatefulWidget {
  const _RendimientoTab();

  @override
  State<_RendimientoTab> createState() => _RendimientoTabState();
}

class _RendimientoTabState extends State<_RendimientoTab> {
  List<Map<String, dynamic>> _stats = [];
  List<Map<String, dynamic>> _sesiones = [];
  Map<String, dynamic> _globalStats = {'racha_dias': 0, 'tiempo_estudio_segundos': 0, 'total_logros': 0};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final stats = await DBHelper().getEstadisticasDetalladas();
    final sesiones = await DBHelper().getHistorialSesiones();
    final globalStats = await DBHelper().getUsuarioStats();
    setState(() {
      _stats = stats;
      _sesiones = sesiones;
      _globalStats = globalStats;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    
    if (_stats.isEmpty && _sesiones.isEmpty) {
      return const Center(child: Text('No hay datos suficientes en tu historial.'));
    }

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Dashboard Profesional', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
            ),
            // Resumen Global
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ResumenCard(icon: Icons.local_fire_department, color: Colors.orange, value: '${_globalStats['racha_dias'] ?? 0}', label: 'Días Racha'),
                  _ResumenCard(icon: Icons.timer, color: Colors.blue, value: '${((_globalStats['tiempo_estudio_segundos'] ?? 0) / 3600.0).toStringAsFixed(1)}h', label: 'Estudio'),
                  _ResumenCard(icon: Icons.emoji_events, color: Colors.amber, value: '${_globalStats['total_logros'] ?? 0}', label: 'Logros'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const TabBar(
              labelColor: Color(0xFF4F8EF7),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF4F8EF7),
              tabs: [
                Tab(text: 'Semáforo de Temas'),
                Tab(text: 'Historial'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Visual Bar Charts por materia y subtema
                  Builder(builder: (context) {
                    // Agrupar por materia
                    final Map<String, List<Map<String, dynamic>>> byMateria = {};
                    for (final s in _stats) {
                      final m = s['materia'] as String? ?? 'General';
                      byMateria.putIfAbsent(m, () => []).add(s);
                    }

                    final materias = byMateria.keys.toList();
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: materias.length,
                      itemBuilder: (context, mi) {
                        final materia = materias[mi];
                        final subtemas = byMateria[materia]!;
                        final totalAciertos = subtemas.fold<int>(0, (acc, s) => acc + (s['total_aciertos'] as int? ?? 0));
                        final totalIntentos = subtemas.fold<int>(0, (acc, s) => acc + (s['total_intentos'] as int? ?? 0));
                        final pctMateria = totalIntentos == 0 ? 0.0 : totalAciertos / totalIntentos;
                        final colorMateria = pctMateria >= 0.75 ? Colors.green : (pctMateria >= 0.5 ? Colors.orange : Colors.red);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Encabezado de Materia
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(materia, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87))),
                                  Text('${(pctMateria * 100).toStringAsFixed(0)}%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: colorMateria)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Barra global de materia
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: pctMateria,
                                  backgroundColor: Colors.grey.shade200,
                                  color: colorMateria,
                                  minHeight: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('$totalAciertos/$totalIntentos preguntas correctas', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              const Divider(height: 20),
                              // Subtemas
                              ...subtemas.map((s) {
                                final pct = (s['porcentaje_acierto'] as num?)?.toDouble() ?? 0.0;
                                final barColor = pct >= 0.75 ? Colors.green.shade400 : (pct >= 0.5 ? Colors.orange.shade400 : Colors.red.shade400);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(s['codigo_tema'] ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          Text('${(pct * 100).toStringAsFixed(0)}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: barColor)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: pct,
                                          backgroundColor: Colors.grey.shade100,
                                          color: barColor,
                                          minHeight: 7,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  // Tab 2: Sessions
                  ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _sesiones.length,
                    itemBuilder: (context, index) {
                      final sesion = _sesiones[index];
                      final isOficial = sesion['tipo_simulacro'] == 'Examen Oficial';
                      final DateTime date = DateTime.parse(sesion['fecha']);
                      final String dateStr = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, "0")}';
                      final double puntajeFinal = (sesion['puntaje_final'] as num).toDouble();
                      final int totalPreguntas = sesion['total_preguntas'] as int;
                      final String puntajeStr = isOficial 
                          ? '${puntajeFinal.toStringAsFixed(1)}/60'
                          : '${puntajeFinal.toInt()}/$totalPreguntas';
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isOficial ? Colors.pink.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                            child: Icon(isOficial ? Icons.star_rounded : Icons.history_edu_rounded, color: isOficial ? Colors.pink : Colors.blue),
                          ),
                          title: Text(sesion['tipo_simulacro'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(dateStr),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                puntajeStr,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Text('Puntaje', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RevisionErroresScreen(sesionId: sesion['id'])),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumenCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _ResumenCard({required this.icon, required this.color, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
