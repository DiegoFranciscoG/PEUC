import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/examen_provider.dart';
import '../models/pregunta.dart';
import 'resultados_screen.dart';
import '../widgets/abstract_reasoning_renderer.dart';
import '../widgets/figura_geometrica.dart';

class SimulacionScreen extends ConsumerWidget {
  const SimulacionScreen({super.key});

  Color _colorMateria(String materia) {
    switch (materia) {
      case 'Matemáticas':            return const Color(0xFF4F8EF7);
      case 'Lengua y Literatura':    return const Color(0xFF059669);
      case 'Ciencias Naturales':     return const Color(0xFFD97706);
      case 'Ciencias Sociales':      return const Color(0xFFDB2777);
      case 'Razonamiento Abstracto': return const Color(0xFF7C3AED);
      default:                       return const Color(0xFF4F8EF7);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(examenProvider);
    final notifier = ref.read(examenProvider.notifier);

    ref.listen(examenProvider, (_, next) {
      if (next.examenFinalizado) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultadosScreen()),
        );
      }
    });

    if (estado.estaCargando) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF4F8EF7))),
      );
    }

    if (estado.errorMensaje != null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Color(0xFFE53935), size: 56),
                const SizedBox(height: 16),
                Text(
                  estado.errorMensaje!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F8EF7)),
                  child: const Text('Volver', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (estado.preguntasSimulacro.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: const Center(
          child: Text('No hay preguntas disponibles para este subtema.', 
            style: TextStyle(fontSize: 16, color: Colors.black54)),
        ),
      );
    }

    if (estado.examenFinalizado) {
      return const Scaffold(backgroundColor: Colors.white, body: SizedBox.shrink());
    }

    final pregunta = estado.preguntasSimulacro[estado.indiceActual];
    final color    = _colorMateria(pregunta.materia);
    final progreso = (estado.indiceActual + 1) / estado.preguntasSimulacro.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────────────────────────
            _buildTopBar(context, estado, color, progreso),

            // ── Content ──────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Materia + Código badge
                    _buildMateriaBadge(pregunta, color),
                    const SizedBox(height: 16),

                    // Enunciado
                    _buildEnunciado(pregunta),
                    const SizedBox(height: 16),

                    // Abstract Reasoning panel
                    if (pregunta.materia == 'Razonamiento Abstracto' &&
                        pregunta.elementosAbstractos != null)
                      AbstractReasoningRenderer(pregunta: pregunta),

                    // Options
                    const SizedBox(height: 20),
                    if (pregunta.opcionesAbstractas != null && pregunta.opcionesAbstractas!.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: pregunta.opcionesAbstractas!.length,
                        itemBuilder: (ctx, i) =>
                            _buildAbstractOption(ctx, pregunta, i, estado, notifier),
                      )
                    else
                      ...List.generate(
                        pregunta.opciones.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildTextOption(ctx: context, pregunta: pregunta, i: i,
                              estado: estado, notifier: notifier),
                        ),
                      ),

                    // Symbolab-style explanation panel (Only show if NOT in Examen Oficial)
                    if (estado.respondioActual && estado.modo != ModoSimulacro.examenOficial)
                      _SymbolabPanel(
                        pregunta: pregunta, 
                        color: color, 
                        esCorrecta: pregunta.indiceRespuestaCorrectaAbstracta != null 
                            ? estado.respuestasSeleccionadas[pregunta.id] == pregunta.indiceRespuestaCorrectaAbstracta.toString()
                            : estado.respuestasSeleccionadas[pregunta.id] == pregunta.respuestaCorrecta
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // ── Bottom Button ─────────────────────────────────────────────
            if (estado.respondioActual)
              _buildNextButton(estado, notifier, color),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Builders
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context, ExamenState estado, Color color, double progreso) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close_rounded, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${estado.indiceActual + 1} / ${estado.preguntasSimulacro.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progreso,
                    backgroundColor: Colors.black12,
                    color: color,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _TimerBadge(estado: estado),
        ],
      ),
    );
  }

  Widget _buildMateriaBadge(Pregunta p, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(p.materia,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Text('Cód. ${p.codigoTema}',
            style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    );
  }

  Widget _buildEnunciado(Pregunta p) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: _buildRichText(
        p.enunciado,
        defaultStyle: const TextStyle(fontSize: 16, height: 1.6, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget _buildNextButton(ExamenState estado, ExamenNotifier notifier, Color color) {
    if (estado.modo == ModoSimulacro.examenOficial) {
      return const SizedBox.shrink(); // Avanza automático o no mostramos nada
    }

    if (estado.respondioActual) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            const Text('¿Qué tan seguro estabas de tu respuesta?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => notifier.siguientePregunta(confianza: 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red.shade900,
                      elevation: 0,
                    ),
                    child: const Text('😅 Adiviné', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => notifier.siguientePregunta(confianza: 2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade100,
                      foregroundColor: Colors.orange.shade900,
                      elevation: 0,
                    ),
                    child: const Text('🙂 Algo seguro', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => notifier.siguientePregunta(confianza: 3),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                      foregroundColor: Colors.green.shade900,
                      elevation: 0,
                    ),
                    child: const Text('😎 Muy seguro', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    
    // Si no ha respondido, no hay botón de siguiente (elijo una opción para avanzar/revisar)
    return const SizedBox.shrink();
  }

  Widget _buildAbstractOption(BuildContext context, Pregunta pregunta, int i, ExamenState estado, ExamenNotifier notifier) {
    final elemento = pregunta.opcionesAbstractas![i];
    final letras = ['A', 'B', 'C', 'D'];
    final letra = i < letras.length ? letras[i] : '${i + 1}';

    Color bgColor = Colors.white;
    Color borderColor = Colors.black12;
    Color letraColor = Colors.black54;
    IconData? trailingIcon;
    final isOficial = estado.modo == ModoSimulacro.examenOficial;

    if (estado.respondioActual) {
      final miRespuesta = estado.respuestasSeleccionadas[pregunta.id];
      final esCorrecta = pregunta.indiceRespuestaCorrectaAbstracta == i;
      final fueSeleccionada = miRespuesta == i.toString();

      if (isOficial) {
        if (fueSeleccionada) {
          bgColor = const Color(0xFF4F8EF7).withOpacity(0.05);
          borderColor = const Color(0xFF4F8EF7);
          letraColor = const Color(0xFF4F8EF7);
          trailingIcon = Icons.radio_button_checked_rounded;
        }
      } else {
        if (esCorrecta) {
          bgColor = const Color(0xFF059669).withOpacity(0.05);
          borderColor = const Color(0xFF059669);
          letraColor = const Color(0xFF059669);
          trailingIcon = Icons.check_circle_rounded;
        } else if (fueSeleccionada) {
          bgColor = Colors.red.withOpacity(0.05);
          borderColor = Colors.red;
          letraColor = Colors.red;
          trailingIcon = Icons.cancel_rounded;
        } else {
          bgColor = Colors.black.withOpacity(0.01);
          borderColor = Colors.black.withOpacity(0.05);
          letraColor = Colors.black26;
        }
      }
    }

    return GestureDetector(
      onTap: estado.respondioActual ? null : () => notifier.responderPregunta(i.toString()),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2.0),
        ),
        child: Stack(
          children: [
            Center(
              child: FiguraGeometrica(
                iconName: elemento.icono,
                rotacion: elemento.rotacion,
                relleno: elemento.relleno,
                tamano: elemento.tamano,
              ),
            ),
            Positioned(
              top: 0, left: 0,
              child: Container(
                width: 24, height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: letraColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(letra,
                    style: TextStyle(color: letraColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
              if (trailingIcon != null)
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(trailingIcon,
                        color: (isOficial && estado.respuestasSeleccionadas[pregunta.id] == i.toString())
                            ? const Color(0xFF4F8EF7)
                            : (trailingIcon == Icons.check_circle_rounded
                                ? const Color(0xFF059669) : Colors.red),
                        size: 24),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextOption({
    required BuildContext ctx,
    required Pregunta pregunta,
    required int i,
    required ExamenState estado,
    required ExamenNotifier notifier,
  }) {
    final opcion = pregunta.opciones[i];
    final letras = ['A', 'B', 'C', 'D'];
    final letra = i < letras.length ? letras[i] : '${i + 1}';

    Color bgColor = Colors.white;
    Color borderColor = Colors.black12;
    Color letraColor = Colors.black54;
    IconData? trailingIcon;
    final isOficial = estado.modo == ModoSimulacro.examenOficial;
    final miRespuesta = estado.respuestasSeleccionadas[pregunta.id];
    final fueSeleccionada = opcion == miRespuesta;

    if (estado.respondioActual) {
      final esCorrecta = opcion == pregunta.respuestaCorrecta;

      if (isOficial) {
        if (fueSeleccionada) {
          bgColor = const Color(0xFF4F8EF7).withOpacity(0.05);
          borderColor = const Color(0xFF4F8EF7);
          letraColor = const Color(0xFF4F8EF7);
          trailingIcon = Icons.radio_button_checked_rounded;
        }
      } else {
        if (esCorrecta) {
          bgColor = const Color(0xFF059669).withOpacity(0.05);
          borderColor = const Color(0xFF059669);
          letraColor = const Color(0xFF059669);
          trailingIcon = Icons.check_circle_rounded;
        } else if (fueSeleccionada && !esCorrecta) {
          bgColor = Colors.red.withOpacity(0.05);
          borderColor = Colors.red;
          letraColor = Colors.red;
          trailingIcon = Icons.cancel_rounded;
        } else {
          bgColor = Colors.black.withOpacity(0.01);
          borderColor = Colors.black.withOpacity(0.05);
          letraColor = Colors.black26;
        }
      }
    }

    return GestureDetector(
      onTap: estado.respondioActual ? null : () => notifier.responderPregunta(opcion),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2.0),
        ),
        child: Row(
          children: [
            Container(
              width: 30, height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: letraColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(letra,
                  style: TextStyle(color: letraColor, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRichText(
                  opcion,
                  defaultStyle: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black)),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon,
                  color: (isOficial && fueSeleccionada) 
                      ? const Color(0xFF4F8EF7)
                      : (trailingIcon == Icons.check_circle_rounded
                          ? const Color(0xFF059669) 
                          : Colors.red),
                  size: 22),
          ],
        ),
      ),
    );
  }

  static Widget _buildRichText(String texto, {required TextStyle defaultStyle}) {
    final parts = <Widget>[];
    final regex = RegExp(r'\$([^$]+)\$');
    int lastEnd = 0;
    final matches = regex.allMatches(texto);

    for (final match in matches) {
      if (match.start > lastEnd) {
        final segment = texto.substring(lastEnd, match.start);
        parts.add(_buildBoldText(segment, defaultStyle));
      }
      parts.add(
        Math.tex(
          match.group(1)!,
          textStyle: defaultStyle.copyWith(fontFamily: 'Math'),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < texto.length) {
      parts.add(_buildBoldText(texto.substring(lastEnd), defaultStyle));
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 2,
      children: parts,
    );
  }

  static Widget _buildBoldText(String text, TextStyle defaultStyle) {
    final parts = <TextSpan>[];
    final bold = RegExp(r'\*\*([^*]+)\*\*');
    int last = 0;
    for (final m in bold.allMatches(text)) {
      if (m.start > last) {
        parts.add(TextSpan(
          text: text.substring(last, m.start),
          style: defaultStyle,
        ));
      }
      parts.add(TextSpan(
        text: m.group(1),
        style: defaultStyle.copyWith(fontWeight: FontWeight.bold),
      ));
      last = m.end;
    }
    if (last < text.length) {
      parts.add(TextSpan(
        text: text.substring(last),
        style: defaultStyle,
      ));
    }
    return RichText(text: TextSpan(children: parts));
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Timer Badge Widget
// ──────────────────────────────────────────────────────────────────────────────

class _TimerBadge extends StatelessWidget {
  final ExamenState estado;
  const _TimerBadge({required this.estado});

  @override
  Widget build(BuildContext context) {
    final isGlobal = estado.modo == ModoSimulacro.examenOficial;
    final tiempoRestante = isGlobal ? estado.tiempoRestanteGlobal : estado.tiempoRestanteIndividual;
    
    final isRed = tiempoRestante <= (isGlobal ? 300 : 10); // Red when 5 mins left globally, or 10s left individually
    
    // Format mm:ss
    final minutes = (tiempoRestante / 60).floor();
    final seconds = tiempoRestante % 60;
    final timeStr = isGlobal 
        ? '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}'
        : '${seconds.toString().padLeft(2, "0")}s';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isRed ? Colors.red.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isRed ? Colors.red : Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_rounded, size: 16, color: isRed ? Colors.red : Colors.black87),
          const SizedBox(width: 4),
          Text(
            timeStr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: isRed ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Symbolab-Style Explanation Panel
// ──────────────────────────────────────────────────────────────────────────────

class _SymbolabPanel extends StatefulWidget {
  final Pregunta pregunta;
  final Color color;
  final bool esCorrecta;

  const _SymbolabPanel({required this.pregunta, required this.color, required this.esCorrecta});

  @override
  State<_SymbolabPanel> createState() => _SymbolabPanelState();
}

class _SymbolabPanelState extends State<_SymbolabPanel> {
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
    final color = widget.color;
    final p = widget.pregunta;
    final hasPasos = p.pasosResolucion != null && p.pasosResolucion!.isNotEmpty;
    final showVideo = !widget.esCorrecta && p.videoExplicativoUrl != null;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.lightbulb_rounded, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Explicación',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15)),
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

          // Explicación general
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: SimulacionScreen._buildRichText(
              p.explicacionDetallada,
              defaultStyle: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
            ),
          ),

          // Pasos Symbolab (expandible)
          if (hasPasos) ...[
            Divider(color: color.withOpacity(0.15), height: 1),
            InkWell(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              onTap: () => setState(() => _mostrarPasos = !_mostrarPasos),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      _mostrarPasos ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                      color: color, size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _mostrarPasos ? 'Ocultar resolución paso a paso' : 'Ver resolución paso a paso',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
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
                      child: _PasoWidget(
                        numeroPaso: i + 1,
                        texto: p.pasosResolucion![i],
                        color: color,
                      ),
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

// ──────────────────────────────────────────────────────────────────────────────
// Paso Widget (Renders bold text + LaTeX if any)
// ──────────────────────────────────────────────────────────────────────────────

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
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Text('$numeroPaso',
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(width: 10),
        Expanded(child: SimulacionScreen._buildRichText(texto, defaultStyle: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87))),
      ],
    );
  }
}
