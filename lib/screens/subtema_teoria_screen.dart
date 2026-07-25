import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/teoria.dart';
import '../database/db_helper.dart';

class SubtemaTeoriaScreen extends StatefulWidget {
  final String codigoTema;
  final String nombreSubtema;

  const SubtemaTeoriaScreen({
    super.key,
    required this.codigoTema,
    required this.nombreSubtema,
  });

  @override
  State<SubtemaTeoriaScreen> createState() => _SubtemaTeoriaScreenState();
}

class _SubtemaTeoriaScreenState extends State<SubtemaTeoriaScreen> {
  Teoria? _teoria;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTeoria();
  }

  Future<void> _loadTeoria() async {
    try {
      final teoria = await DBHelper().getTeoriaPorSubtema(widget.codigoTema);
      setState(() {
        _teoria = teoria;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _teoria = null;
        _loading = false;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.nombreSubtema)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_teoria == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.nombreSubtema),
          backgroundColor: const Color(0xFF4F8EF7),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Teoría aún no disponible',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Pronto agregaremos el contenido para el tema ${widget.codigoTema}',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_teoria!.titulo.isNotEmpty ? _teoria!.titulo : widget.nombreSubtema),
        backgroundColor: const Color(0xFF4F8EF7),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4F8EF7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Tema ${_teoria!.codigoTema} • ${_teoria!.materia}',
                style: const TextStyle(color: Color(0xFF4F8EF7), fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            if (_teoria!.contenidoMarkdown.isNotEmpty)
              MarkdownBody(
                data: _teoria!.contenidoMarkdown,
                selectable: true,
                builders: {
                  'latex': LatexElementBuilder(),
                },
                extensionSet: md.ExtensionSet(
                  [LatexBlockSyntax()],
                  [LatexInlineSyntax()],
                ),
                styleSheet: MarkdownStyleSheet(
                  h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  p: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            if (_teoria!.formulaClave.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(color: Colors.amber.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text('Fórmula Clave', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Math.tex(
                        _teoria!.formulaClave,
                        textStyle: const TextStyle(fontSize: 22, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (_teoria!.videoUrl.isNotEmpty) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _launchUrl(_teoria!.videoUrl),
                  icon: const Icon(Icons.play_circle_fill),
                  label: const Text('Ver Video Explicativo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
