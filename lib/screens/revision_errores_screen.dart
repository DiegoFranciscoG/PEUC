import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/pregunta.dart';
import '../database/db_helper.dart';

class RevisionErroresScreen extends StatefulWidget {
  final int sesionId;
  const RevisionErroresScreen({super.key, required this.sesionId});

  @override
  State<RevisionErroresScreen> createState() => _RevisionErroresScreenState();
}

class _RevisionErroresScreenState extends State<RevisionErroresScreen> {
  List<Pregunta> _errores = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadErrores();
  }

  Future<void> _loadErrores() async {
    final data = await DBHelper().getErroresDeSesion(widget.sesionId);
    setState(() {
      _errores = data.map((json) => Pregunta.fromMap(json)).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_errores.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mis Errores')),
        body: const Center(child: Text('¡Excelente! No tuviste errores en esta sesión.', style: TextStyle(fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Errores (\${_errores.length})'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _errores.length,
        separatorBuilder: (_, __) => const Divider(height: 40, thickness: 2),
        itemBuilder: (context, index) {
          final p = _errores[index];
          final esAbstracto = p.materia == 'Razonamiento Abstracto' && p.indiceRespuestaCorrectaAbstracta != null;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pregunta \${index + 1} - \${p.materia}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              if (p.enunciado.isNotEmpty)
                Text(
                  p.enunciado,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.5),
                ),
              const SizedBox(height: 12),
              
              // Only showing what the correct answer was (since user failed it)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        esAbstracto ? 'Opción Correcta: \${String.fromCharCode(65 + p.indiceRespuestaCorrectaAbstracta!)}' : 'Respuesta Correcta:\\n\${p.respuestaCorrecta}',
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              _RevisionSymbolabPanel(pregunta: p),
            ],
          );
        },
      ),
    );
  }
}

class _RevisionSymbolabPanel extends StatefulWidget {
  final Pregunta pregunta;

  const _RevisionSymbolabPanel({required this.pregunta});

  @override
  State<_RevisionSymbolabPanel> createState() => _RevisionSymbolabPanelState();
}

class _RevisionSymbolabPanelState extends State<_RevisionSymbolabPanel> {
  bool _mostrarPasos = false;

  Future<void> _abrirVideo() async {
    if (widget.pregunta.videoExplicativoUrl == null) return;
    final uri = Uri.parse(widget.pregunta.videoExplicativoUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.pregunta;
    final color = const Color(0xFF4F8EF7);
    final hasPasos = p.pasosResolucion != null && p.pasosResolucion!.isNotEmpty;
    final showVideo = p.videoExplicativoUrl != null;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.lightbulb_rounded, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Explicación y Corrección', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                if (showVideo)
                  GestureDetector(
                    onTap: _abrirVideo,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_circle_fill_rounded, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text('Video', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Text(p.explicacionDetallada, style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87)),
          ),

          if (hasPasos) ...[
            Divider(color: color.withOpacity(0.15), height: 1),
            InkWell(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              onTap: () => setState(() => _mostrarPasos = !_mostrarPasos),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Icon(_mostrarPasos ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: color, size: 20),
                    const SizedBox(width: 6),
                    Text(_mostrarPasos ? 'Ocultar resolución paso a paso' : 'Ver resolución paso a paso', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ),
            if (_mostrarPasos)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  border: Border(top: BorderSide(color: color.withOpacity(0.1))),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(p.pasosResolucion!.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PasoWidget(numeroPaso: i + 1, texto: p.pasosResolucion![i], color: color),
                    );
                  }),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _PasoWidget extends StatelessWidget {
  final int numeroPaso;
  final String texto;
  final Color color;

  const _PasoWidget({required this.numeroPaso, required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
          child: Text('\$numeroPaso', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(width: 10),
        Expanded(child: _buildTextoConFormulas(texto)),
      ],
    );
  }

  Widget _buildTextoConFormulas(String texto) {
    final parts = <Widget>[];
    final regex = RegExp(r'\$([^$]+)\$');
    int lastEnd = 0;
    final matches = regex.allMatches(texto);

    for (final match in matches) {
      if (match.start > lastEnd) {
        parts.add(_buildBoldText(texto.substring(lastEnd, match.start)));
      }
      parts.add(Math.tex(match.group(1)!, textStyle: const TextStyle(fontSize: 14)));
      lastEnd = match.end;
    }
    if (lastEnd < texto.length) {
      parts.add(_buildBoldText(texto.substring(lastEnd)));
    }

    return Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 2, children: parts);
  }

  Widget _buildBoldText(String text) {
    final parts = <TextSpan>[];
    final bold = RegExp(r'\*\*([^*]+)\*\*');
    int last = 0;
    for (final m in bold.allMatches(text)) {
      if (m.start > last) {
        parts.add(TextSpan(text: text.substring(last, m.start), style: const TextStyle(color: Colors.black87)));
      }
      parts.add(TextSpan(text: m.group(1), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)));
      last = m.end;
    }
    if (last < text.length) {
      parts.add(TextSpan(text: text.substring(last), style: const TextStyle(color: Colors.black87)));
    }
    return RichText(text: TextSpan(style: const TextStyle(fontSize: 14, height: 1.5), children: parts));
  }
}
