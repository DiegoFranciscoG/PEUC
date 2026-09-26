import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/theme.dart';
import '../../data/progress_repository.dart';
import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import 'practice_screen.dart';

/// Areas of the exam with coverage and accuracy.
class PracticeTab extends ConsumerWidget {
  const PracticeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    return AsyncView(
      value: ref.watch(bankProvider),
      builder: (bank) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Practica por componente', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Cada pregunta muestra la respuesta y su justificación al instante.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                for (final code in AdmissionRules.areaOrder) ...[
                  _AreaCard(area: bank.area(code), questions: bank.byArea(code), progress: progress),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AreaCard extends StatelessWidget {
  const _AreaCard({required this.area, required this.questions, required this.progress});

  final Area area;
  final List<Question> questions;
  final ProgressSnapshot progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AreaStyle.color(area.code);
    final seen = questions.where((q) => progress.seen.contains(q.number)).length;
    final accuracy = progress.byArea[area.code];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed('/area/${area.code}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(radius: 24, backgroundColor: color.withValues(alpha: 0.15), child: Icon(AreaStyle.icon(area.code), color: color)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(area.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${thousands(questions.length)} preguntas · ${thousands(seen)} vistas'
                      '${accuracy == null ? '' : ' · ${percent(accuracy.ratio * 100)} de aciertos'}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: questions.isEmpty ? 0 : seen / questions.length,
                      color: color,
                      backgroundColor: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// Topics of one area grouped by the official syllabus units.
class AreaScreen extends ConsumerWidget {
  const AreaScreen({super.key, required this.areaCode});

  final String areaCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    return AsyncView(
      value: ref.watch(bankProvider),
      builder: (bank) {
        final area = bank.area(areaCode);
        final topics = bank.topicsOf(areaCode);
        final units = <String, List<Topic>>{};
        for (final t in topics) {
          units.putIfAbsent('${t.unitCode} ${t.unit}', () => []).add(t);
        }
        return Scaffold(
          appBar: AppBar(title: Text(area.name)),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              ReadableWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FilledButton.icon(
                        onPressed: () => openPractice(context, ref, title: area.name, pool: bank.byArea(areaCode)),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Practicar 10 preguntas del componente'),
                      ),
                    ),
                    for (final unit in units.entries) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Text(unit.key, style: Theme.of(context).textTheme.titleSmall),
                      ),
                      for (final topic in unit.value) _TopicTile(topic: topic, bank: bank, progress: progress),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopicTile extends ConsumerWidget {
  const _TopicTile({required this.topic, required this.bank, required this.progress});

  final Topic topic;
  final QuestionBank bank;
  final ProgressSnapshot progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = bank.byTopic(topic.code);
    final accuracy = progress.byTopic[topic.code];
    return ListTile(
      leading: CircleAvatar(radius: 18, child: Text(topic.code.split('.').last)),
      title: Text(topic.title),
      subtitle: Text(
        '${topic.code} · ${questions.length} preguntas'
        '${accuracy == null ? '' : ' · ${percent(accuracy.ratio * 100)} de aciertos'}',
      ),
      trailing: const Icon(Icons.play_circle_outline),
      enabled: questions.isNotEmpty,
      onTap: () => openPractice(context, ref, title: 'Subtema ${topic.code}', pool: questions),
    );
  }
}
