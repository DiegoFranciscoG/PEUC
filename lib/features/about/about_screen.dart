import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';

const _examPage = 'https://www.ucuenca.edu.ec/admisiones/examen/';
const _guidePdf = 'https://www.ucuenca.edu.ec/wp-content/uploads/2026/07/Guia-del-Examen-de-Admision-2026.pdf';
const _syllabusPdf = 'https://www.ucuenca.edu.ec/wp-content/uploads/2026/07/Temarios_UCuenca-2026.pdf';
const _repository = 'https://github.com/DiegoFranciscoG/PEUC';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de P.E.U.C.')),
      body: AsyncView(
        value: ref.watch(bankProvider),
        builder: (bank) {
          final observed = bank.withObservation;
          final checks = {for (final c in AnswerCheck.values) c: bank.questions.where((q) => q.check == c).length};
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ReadableWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Section(
                      title: 'El examen UCuenca 2026 (datos oficiales)',
                      children: [
                        const _Bullet('60 preguntas de opción múltiple: 12 de cada componente (Matemáticas, Lengua y Literatura, Ciencias Sociales, Ciencias Naturales y Razonamiento Abstracto).'),
                        const _Bullet('70 minutos, en computador y de forma presencial; +50 % de tiempo para personas con discapacidad.'),
                        const _Bullet('Calificación: +1 por respuesta correcta, −1/3 por incorrecta y 0 si queda en blanco.'),
                        const _Bullet('Cada carrera pertenece a un campo de conocimiento que pondera los componentes de forma distinta.'),
                        const _Bullet('Puntaje de postulación: 60 % nota del examen + 40 % antecedentes académicos + acción afirmativa cuando corresponda. No hay puntaje mínimo.'),
                        const SizedBox(height: 8),
                        _WeightsTable(bank: bank),
                      ],
                    ),
                    _Section(
                      title: 'Cómo se verificó el banco',
                      children: [
                        _Bullet('Las ${bank.questions.length} preguntas y sus opciones se extrajeron del PDF oficial publicado por la UCuenca (SHA-256 ${bank.sourceSha256.substring(0, 12)}…).'),
                        _Bullet('Cada respuesta del banco resuelto se cruzó con la opción oficial: ${checks[AnswerCheck.text]} coinciden por texto, ${checks[AnswerCheck.image]} por imagen y ${checks[AnswerCheck.manual]} se verificaron a mano.'),
                        _Bullet('Cada pregunta se asignó a un subtema del temario oficial (26 de mayo de 2026).'),
                        _Bullet('${observed.length} preguntas llevan una nota de verificación (respuestas corregidas, ítems con error en el banco oficial o datos aproximados).'),
                      ],
                    ),
                    if (observed.isNotEmpty)
                      _Section(
                        title: 'Preguntas con nota de verificación',
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final q in observed)
                                ActionChip(
                                  label: Text('#${q.number}'),
                                  avatar: Icon(q.wasCorrected ? Icons.edit_note : Icons.info_outline, size: 18),
                                  onPressed: () => Navigator.of(context).pushNamed('/pregunta/${q.number}'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    _Section(
                      title: 'Fuentes oficiales',
                      children: [
                        _Link('Banco de preguntas 2026 (PDF)', bank.sourceUrl),
                        const _Link('Página del examen de admisión', _examPage),
                        const _Link('Guía del examen 2026 (PDF)', _guidePdf),
                        const _Link('Temario oficial 2026 (PDF)', _syllabusPdf),
                      ],
                    ),
                    _Section(
                      title: 'Privacidad',
                      children: const [
                        _Bullet('Sin cuentas, sin publicidad y sin analítica. Tu progreso se guarda solo en tu dispositivo (SQLite).'),
                        _Bullet('La aplicación funciona sin conexión: el banco y sus imágenes vienen incluidos.'),
                      ],
                    ),
                    _Section(
                      title: 'Aviso',
                      children: [
                        const _Bullet('Proyecto independiente y sin fines de lucro. No está afiliado ni avalado por la Universidad de Cuenca. Las preguntas pertenecen a la universidad, que las publicó para la preparación de los aspirantes.'),
                        const _Link('Código fuente (licencia MIT)', _repository),
                        Text('Versión del banco ${bank.version}', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35))),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link(this.label, this.url);

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.open_in_new, size: 20),
      title: Text(label),
      subtitle: Text(Uri.parse(url).host),
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
    );
  }
}

class _WeightsTable extends StatelessWidget {
  const _WeightsTable({required this.bank});

  final QuestionBank bank;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowHeight: 40,
        dataRowMinHeight: 36,
        dataRowMaxHeight: 40,
        columns: [
          const DataColumn(label: Text('Componente')),
          for (final f in knowledgeFields) DataColumn(label: Text(f.code), numeric: true, tooltip: f.name),
        ],
        rows: [
          for (final code in AdmissionRules.areaOrder)
            DataRow(cells: [
              DataCell(Text(bank.area(code).name)),
              for (final f in knowledgeFields) DataCell(Text('${f.weights[code]} %')),
            ]),
        ],
      ),
    );
  }
}
