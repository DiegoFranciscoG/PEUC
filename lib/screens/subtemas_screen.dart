import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/examen_provider.dart';
import 'simulacion_screen.dart';

final temasOficiales = {
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

class SubtemasScreen extends ConsumerStatefulWidget {
  final String materia;
  final Color color;

  const SubtemasScreen({super.key, required this.materia, required this.color});

  @override
  ConsumerState<SubtemasScreen> createState() => _SubtemasScreenState();
}

class _SubtemasScreenState extends ConsumerState<SubtemasScreen> {
  Map<String, String> nombresOficiales = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNombres();
  }

  Future<void> _loadNombres() async {
    try {
      final String temarioStr = await rootBundle.loadString('assets/data/temario_maestro.json');
      final List<dynamic> temarioList = jsonDecode(temarioStr);
      Map<String, String> nombres = {};
      for (var t in temarioList) {
        nombres[t['codigo']] = t['titulo_oficial'] ?? t['titulo'] ?? 'Subtema';
      }
      setState(() {
        nombresOficiales = nombres;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final codigos = temasOficiales[widget.materia] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.materia, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.black12, height: 1),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: codigos.length,
              separatorBuilder: (ctx, idx) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final codigo = codigos[i];
                final nombreOficial = nombresOficiales[codigo] ?? 'Subtema';

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(codigo,
                                style: TextStyle(color: widget.color, fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(nombreOficial,
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref.read(examenProvider.notifier).iniciarSimulacroIntensivo(codigoTemaFiltro: codigo);
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SimulacionScreen()));
                              },
                              icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                              label: const Text('Iniciar Simulacro Específico', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.color,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

