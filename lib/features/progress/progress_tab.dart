import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/theme.dart';
import '../../data/progress_repository.dart';
import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../practice/practice_screen.dart';

class ProgressTab extends ConsumerWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    return AsyncView(
      value: ref.watch(bankProvider),
      builder: (bank) {
        final overall = progress.overall;
        final weakest = progress.byTopic.entries.where((e) => e.value.attempts >= 3).toList()
          ..sort((a, b) => a.value.ratio.compareTo(b.value.ratio));
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: _Metric(value: thousands(progress.seen.length), label: 'preguntas vistas de ${thousands(bank.questions.length)}')),
                      const SizedBox(width: 8),
                      Expanded(child: _Metric(value: percent(overall.ratio * 100), label: 'de aciertos en ${thousands(overall.attempts)} respuestas')),
                      const SizedBox(width: 8),
                      Expanded(child: _Metric(value: '${progress.sessions.length}', label: 'simulacros')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Aciertos por componente', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          for (final code in AdmissionRules.areaOrder)
                            _AreaBar(area: bank.area(code), accuracy: progress.byArea[code]),
                        ],
                      ),
                    ),
                  ),
                  if (weakest.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text('Subtemas para reforzar', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Card(
                      child: Column(
                        children: [
                          for (final entry in weakest.take(5))
                            ListTile(
                              leading: Icon(AreaStyle.icon(bank.topic(entry.key).areaCode), color: AreaStyle.color(bank.topic(entry.key).areaCode)),
                              title: Text(bank.topic(entry.key).title),
                              subtitle: Text('${entry.key} · ${percent(entry.value.ratio * 100)} de ${entry.value.attempts} respuestas'),
                              trailing: const Icon(Icons.play_circle_outline),
                              onTap: () => openPractice(context, ref, title: 'Subtema ${entry.key}', pool: bank.byTopic(entry.key)),
                            ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text('Historial de simulacros', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (progress.sessions.isEmpty)
                    Text('Aún no has hecho simulacros.', style: theme.textTheme.bodyMedium)
                  else
                    Card(
                      child: Column(
                        children: [
                          for (final s in progress.sessions.take(20))
                            ListTile(
                              title: Text('${percent(s.weightedPercent, digits: 1)} · ${fieldByCode(s.fieldCode).name}'),
                              subtitle: Text('${shortDate(s.startedAt)} · ${s.correct} ✓ ${s.wrong} ✗ ${s.blank} — · ${clock(s.duration)} min'),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Card(
                    child: SwitchListTile(
                      title: const Text('Barajar opciones'),
                      subtitle: const Text('Evita memorizar la letra de la respuesta. Las opciones tipo "todas las anteriores" no se mueven.'),
                      value: settings.shuffleOptions,
                      onChanged: (value) => ref.read(settingsProvider.notifier).setShuffleOptions(value),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _confirmReset(context, ref),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Borrar mi progreso'),
                  ),
                  Text(
                    'Tu progreso se guarda solo en este dispositivo: no hay cuentas ni se envían datos a ningún servidor.',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Borrar tu progreso?'),
        content: const Text('Se eliminarán tus respuestas, simulacros y preguntas guardadas de este dispositivo.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (ok != true) return;
    await (await ref.read(progressRepositoryProvider.future)).clearProgress();
    ref.invalidate(progressProvider);
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _AreaBar extends StatelessWidget {
  const _AreaBar({required this.area, required this.accuracy});

  final Area area;
  final Accuracy? accuracy;

  @override
  Widget build(BuildContext context) {
    final color = AreaStyle.color(area.code);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(AreaStyle.icon(area.code), color: color, size: 20),
          const SizedBox(width: 8),
          SizedBox(width: 150, child: Text(area.name)),
          Expanded(
            child: LinearProgressIndicator(
              value: accuracy?.ratio ?? 0,
              minHeight: 10,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(accuracy == null ? '—' : percent(accuracy!.ratio * 100), textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
