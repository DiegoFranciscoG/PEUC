import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/theme.dart';
import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../domain/option_order.dart';
import '../../domain/scoring.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../common/career_picker.dart';
import '../common/question_view.dart';

class ExamResultScreen extends ConsumerWidget {
  const ExamResultScreen({
    super.key,
    required this.questions,
    required this.answers,
    required this.order,
    required this.elapsed,
  });

  final List<Question> questions;
  final Map<int, String> answers;
  final Map<int, List<AnswerOption>> order;
  final Duration elapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final score = scoreExam(questions, answers);
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final field = settings.field;
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado del simulacro')),
      body: AsyncView(
        value: ref.watch(bankProvider),
        builder: (bank) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: theme.colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nota estimada del examen', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(percent(score.weightedPercent(field), digits: 1), style: theme.textTheme.displaySmall),
                          Text(settings.career == null ? 'Campo ${field.name}' : '${settings.career} · ${field.name}'),
                          const SizedBox(height: 12),
                          Text(
                            '${decimal(score.points, digits: 2)} de ${questions.length} puntos · '
                            '${score.correct} correctas · ${score.wrong} incorrectas · ${score.blank} en blanco · '
                            '${clock(elapsed)} min',
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: () => showCareerPicker(context),
                              icon: const Icon(Icons.school_outlined),
                              label: const Text('Cambiar carrera'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Por componente', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        for (final code in AdmissionRules.areaOrder)
                          if (score.components[code] case final c?)
                            ListTile(
                              leading: Icon(AreaStyle.icon(code), color: AreaStyle.color(code)),
                              title: Text(bank.area(code).name),
                              subtitle: Text('${c.correct} ✓   ${c.wrong} ✗   ${c.blank} sin responder · pesa ${field.weights[code]} %'),
                              trailing: Text('${decimal(c.points, digits: 2)} / ${c.total}', style: theme.textTheme.titleSmall),
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Tu nota en cada campo de conocimiento', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        for (final f in knowledgeFields)
                          ListTile(
                            dense: true,
                            selected: f.code == field.code,
                            title: Text(f.name),
                            trailing: Text(percent(score.weightedPercent(f), digits: 1)),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Regla oficial: +1 por respuesta correcta, −1/3 por incorrecta y 0 en blanco. '
                    'La nota combina los componentes con las ponderaciones del campo de tu carrera. '
                    'La UCuenca no publica la escala de la nota: aquí se muestra como porcentaje del máximo. '
                    'El puntaje de postulación suma además un 40 % de antecedentes académicos.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => ExamReviewScreen(questions: questions, answers: answers, order: order),
                    )),
                    icon: const Icon(Icons.fact_check_outlined),
                    label: const Text('Revisar respuestas'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Volver al inicio')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamReviewScreen extends ConsumerWidget {
  const ExamReviewScreen({super.key, required this.questions, required this.answers, required this.order});

  final List<Question> questions;
  final Map<int, String> answers;
  final Map<int, List<AnswerOption>> order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Revisión')),
      body: AsyncView(
        value: ref.watch(bankProvider),
        builder: (bank) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: questions.length,
          itemBuilder: (context, i) {
            final q = questions[i];
            final chosen = answers[q.number];
            final options = order[q.number] ?? q.options;
            final status = chosen == null ? null : q.isCorrect(chosen);
            return ReadableWidth(
              child: ExpansionTile(
                leading: Icon(
                  status == null ? Icons.remove_circle_outline : (status ? Icons.check_circle : Icons.cancel),
                  color: status == null ? scheme.outline : (status ? scheme.success : scheme.error),
                ),
                title: Text('${i + 1}. ${q.plainStem.isEmpty ? 'Pregunta con imagen' : q.plainStem}', maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text(bank.area(q.areaCode).name),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  QuestionView(question: q, options: options, areaName: bank.area(q.areaCode).name, selected: chosen, reveal: true),
                  FeedbackPanel(
                    question: q,
                    chosen: chosen,
                    correctDisplayLabel: displayLabel(options.indexWhere((o) => q.isCorrect(o.label))),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
