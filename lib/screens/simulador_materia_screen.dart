import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/examen_provider.dart';
import 'simulacion_screen.dart';

const _materias = [
  {'nombre': 'Matemáticas', 'icon': Icons.calculate_rounded, 'color': Color(0xFF4F8EF7), 'emoji': '📐'},
  {'nombre': 'Lengua y Literatura', 'icon': Icons.menu_book_rounded, 'color': Color(0xFF059669), 'emoji': '📖'},
  {'nombre': 'Ciencias Naturales', 'icon': Icons.science_rounded, 'color': Color(0xFFD97706), 'emoji': '🔬'},
  {'nombre': 'Ciencias Sociales', 'icon': Icons.public_rounded, 'color': Color(0xFFDB2777), 'emoji': '🌍'},
  {'nombre': 'Razonamiento Abstracto', 'icon': Icons.pattern_rounded, 'color': Color(0xFF7C3AED), 'emoji': '🧩'},
];

class SimuladorMateriaScreen extends ConsumerWidget {
  const SimuladorMateriaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulador por Materia')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _materias.length,
          separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final m = _materias[index];
            final nombre = m['nombre'] as String;
            final color = m['color'] as Color;
            final emoji = m['emoji'] as String;
            final icon = m['icon'] as IconData;

            return GestureDetector(
              onTap: () {
                ref.read(examenProvider.notifier).iniciarSimulacroIntensivo(materiaFiltro: nombre);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SimulacionScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1D2E),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: color.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: color, size: 26),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$emoji $nombre',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Simulacro exclusivo de esta área',
                              style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
                        ],
                      ),
                    ),
                    Icon(Icons.play_circle_filled_rounded, color: color, size: 32),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
