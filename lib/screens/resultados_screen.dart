import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/examen_provider.dart';
import 'simulacion_screen.dart';
import 'dashboard_screen.dart';
import 'revision_errores_screen.dart';

class ResultadosScreen extends ConsumerWidget {
  const ResultadosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(examenProvider);
    final notifier = ref.read(examenProvider.notifier);

    final bool isOficial = estado.modo == ModoSimulacro.examenOficial;
    final int totalPreguntas = estado.preguntasSimulacro.length;
    final int correctasTotales = estado.respuestasCorrectas;
    final int errores = estado.respuestasSeleccionadas.values
        .where((v) => v != 'OMITIDA' && v != 'TIEMPO_AGOTADO')
        .length - correctasTotales;
    final double puntajeOficial = estado.puntajeOficial; // ya aplica +1/-0.5
    final int omitidas = totalPreguntas - correctasTotales - (errores.clamp(0, totalPreguntas));
    final double porcentajeAcierto = totalPreguntas == 0 ? 0.0 : (correctasTotales / totalPreguntas * 100);
    final isGood = isOficial ? puntajeOficial >= 30 : porcentajeAcierto >= 70;

    return Scaffold(
      appBar: AppBar(
        title: Text(isOficial ? 'Resultados Examen Oficial' : 'Resultados del Simulacro'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
             Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
                (route) => false,
             );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Puntaje General
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isGood
                        ? [const Color(0xFF1B5E20), const Color(0xFF2E7D32)]
                        : [const Color(0xFF7F0000), const Color(0xFFC62828)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (isGood ? Colors.green : Colors.red).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (isOficial) ...[
                      const Text('Tu Calificación P.E.U.C.',
                          style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text(
                        '${puntajeOficial >= 0 ? puntajeOficial.toStringAsFixed(1) : puntajeOficial.toStringAsFixed(1)} / 60.0',
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _badgeResultado('✓ $correctasTotales aciertos', Colors.greenAccent),
                          const SizedBox(width: 8),
                          _badgeResultado('✗ ${errores.clamp(0, totalPreguntas)} errores (-0.5c/u)', Colors.redAccent),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Precisión: ${porcentajeAcierto.round()}%  •  ${omitidas.clamp(0, totalPreguntas)} omitidas',
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ] else ...[
                      const Text('Resultado', style: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text('${porcentajeAcierto.round()}%',
                          style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w900, color: Colors.white)),
                      Text('$correctasTotales de $totalPreguntas correctas', style: const TextStyle(color: Colors.white70, fontSize: 15)),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              const Text(
                'Desempeño por Materia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Desglose por materia
              Expanded(
                child: Builder(
                  builder: (context) {
                    final materias = estado.preguntasSimulacro.map((p) => p.materia).toSet().toList();
                    return ListView.builder(
                      itemCount: materias.length,
                      itemBuilder: (context, index) {
                        final materia = materias[index];
                        final total = estado.totalPorMateria(materia);
                        final correctas = estado.puntajePorMateria(materia);
                        final incorrectas = total - correctas;
                    
                        final porc = (correctas / total);
                        Color barColor = porc >= 0.7 ? Colors.green : Colors.red;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    materia,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                  ),
                                  Text(
                                    '\$correctas/\$total',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: porc,
                                backgroundColor: Colors.grey.shade200,
                                color: barColor,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              if (incorrectas > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Temas a reforzar (\${incorrectas} errores)',
                                    style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
              
              const SizedBox(height: 16),
              
              if (isOficial && estado.sesionId != null && (totalPreguntas - correctasTotales) > 0)
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RevisionErroresScreen(sesionId: estado.sesionId!),
                      ),
                    );
                  },
                  icon: const Icon(Icons.manage_search_rounded, color: Colors.white),
                  label: const Text('Revisar Mis Errores', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              const SizedBox(height: 12),
              
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => const DashboardScreen()),
                     (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Volver al Inicio', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badgeResultado(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
