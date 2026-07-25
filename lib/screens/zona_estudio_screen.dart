import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final _temasOficiales = {
  'Matemáticas': ['1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6', '1.1.7', '1.2.1', '1.3.1'],
  'Lengua y Literatura': ['2.1.1', '2.2.1', '2.3.1', '2.4.1', '2.5.1'],
  'Ciencias Naturales': [
    '3.1.1', '3.1.2', '3.1.3', '3.2.1', '3.3.1', '3.3.2', 
    '3.4.1', '3.4.2', '3.4.3', '3.4.4', '3.4.5', '3.4.6', 
    '3.5.1', '3.6.1', 
    '3.7.1', '3.7.2', '3.7.3', '3.7.4', '3.7.5', '3.7.6', '3.7.7', '3.7.8',
    '3.8.1', '3.9.1', '3.10.1'
  ],
  'Ciencias Sociales': [
    '4.1.1', '4.1.2', '4.1.3', '4.2.1', '4.3.1', '4.4.1', 
    '4.5.1', '4.5.2', '4.5.3', '4.6.1', '4.7.1', '4.8.1', '4.9.1', '4.10.1', '4.11.1'
  ],
  'Razonamiento Abstracto': ['5.1.1', '5.1.2', '5.2.1', '5.2.2', '5.2.3', '5.3.1', '5.3.2', '5.3.3'],
};

final _infoMaterias = {
  'Matemáticas': {'icon': Icons.calculate_rounded, 'color': const Color(0xFF4F8EF7)},
  'Lengua y Literatura': {'icon': Icons.menu_book_rounded, 'color': const Color(0xFF059669)},
  'Ciencias Naturales': {'icon': Icons.science_rounded, 'color': const Color(0xFFD97706)},
  'Ciencias Sociales': {'icon': Icons.public_rounded, 'color': const Color(0xFFDB2777)},
  'Razonamiento Abstracto': {'icon': Icons.pattern_rounded, 'color': const Color(0xFF7C3AED)},
};

class ZonaEstudioScreen extends StatelessWidget {
  const ZonaEstudioScreen({super.key});

  Future<void> _abrirYouTube(String materia, String codigo) async {
    final query = 'Tema $codigo $materia UCuenca preparacion examen';
    final uri = Uri.parse('https://www.youtube.com/results?search_query=${Uri.encodeComponent(query)}');
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // ignore: avoid_print
      print('No se pudo abrir $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Zona de Estudio', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _temasOficiales.keys.length,
        separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final materia = _temasOficiales.keys.elementAt(i);
          final codigos = _temasOficiales[materia]!;
          final info = _infoMaterias[materia]!;
          final color = info['color'] as Color;
          final icon = info['icon'] as IconData;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 2))
              ],
            ),
            child: Theme(
              data: ThemeData(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                title: Text(
                  materia,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Text('${codigos.length} temas oficiales', style: const TextStyle(color: Colors.black54, fontSize: 12)),
                iconColor: color,
                collapsedIconColor: Colors.black38,
                children: codigos.map((codigo) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(codigo,
                              style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text("Ver clases recomendadas",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87)),
                        ),
                        IconButton(
                          onPressed: () => _abrirYouTube(materia, codigo),
                          icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.red),
                          tooltip: 'Buscar en YouTube',
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
