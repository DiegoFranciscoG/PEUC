import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/theme.dart';
import '../../data/progress_repository.dart';
import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../common/career_picker.dart';
import '../practice/practice_screen.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    return AsyncView(
      value: ref.watch(bankProvider),
      builder: (bank) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!ref.watch(persistentStorageProvider)) ...[
                  const _StorageWarning(),
                  const SizedBox(height: 12),
                ],
                _BankCard(bank: bank),
                const SizedBox(height: 12),
                const _ExamCard(),
                const SizedBox(height: 12),
                _QuickActions(bank: bank, progress: progress),
                const SizedBox(height: 12),
                _FieldCard(settings: settings, bank: bank),
                if (progress.sessions.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _LastExamCard(session: progress.sessions.first),
                ],
                const SizedBox(height: 16),
                Text(
                  'Aplicación independiente y sin fines de lucro, no afiliada a la Universidad de Cuenca. '
                  'Las preguntas provienen del banco que la universidad publicó el 27 de julio de 2026.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageWarning extends StatelessWidget {
  const _StorageWarning();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.errorContainer,
      child: ListTile(
        leading: Icon(Icons.cloud_off, color: scheme.onErrorContainer),
        title: Text('Tu progreso no se guardará', style: TextStyle(color: scheme.onErrorContainer)),
        subtitle: Text(
          'Este navegador no permite guardar datos (modo privado o almacenamiento bloqueado). '
          'Puedes practicar igual, pero el avance se perderá al cerrar.',
          style: TextStyle(color: scheme.onErrorContainer),
        ),
      ),
    );
  }
}

class _BankCard extends StatelessWidget {
  const _BankCard({required this.bank});

  final QuestionBank bank;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final observed = bank.withObservation.length;
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Banco oficial 2026', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Examen de admisión · Universidad de Cuenca', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Stat(value: thousands(bank.questions.length), label: 'preguntas'),
                _Stat(value: '${bank.areas.length}', label: 'componentes'),
                _Stat(value: '${bank.topics.length}', label: 'subtemas'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.verified_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Respuestas cruzadas con las opciones oficiales; $observed con nota de verificación.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: theme.colorScheme.surface.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(12)),
      child: Text.rich(TextSpan(children: [
        TextSpan(text: '$value ', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        TextSpan(text: label, style: theme.textTheme.bodyMedium),
      ])),
    );
  }
}

class _ExamCard extends StatelessWidget {
  const _ExamCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.timer_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(child: Text('Simulacro oficial', style: theme.textTheme.titleLarge)),
            ]),
            const SizedBox(height: 8),
            Text(
              '${AdmissionRules.totalQuestions} preguntas · ${AdmissionRules.questionsPerArea} por componente · '
              '${AdmissionRules.examDuration.inMinutes} minutos · +1 correcta, −1/3 incorrecta',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/simulacro'),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Empezar simulacro'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends ConsumerWidget {
  const _QuickActions({required this.bank, required this.progress});

  final QuestionBank bank;
  final ProgressSnapshot progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wrong = bank.questions.where((q) => progress.lastWrong.contains(q.number)).toList();
    final unseen = bank.questions.where((q) => !progress.seen.contains(q.number)).toList();
    final saved = bank.questions.where((q) => progress.bookmarks.contains(q.number)).toList();
    return Row(
      children: [
        Expanded(
          child: _ActionTile(
            icon: Icons.replay,
            title: 'Errores',
            subtitle: '${wrong.length} por repasar',
            onTap: () => openPractice(context, ref, title: 'Repaso de errores', pool: wrong),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionTile(
            icon: Icons.fiber_new_outlined,
            title: 'Nuevas',
            subtitle: '${thousands(unseen.length)} sin ver',
            onTap: () => openPractice(context, ref, title: 'Preguntas nuevas', pool: unseen),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionTile(
            icon: Icons.bookmark_border,
            title: 'Guardadas',
            subtitle: count(saved.length, 'pregunta', 'preguntas'),
            onTap: () => openPractice(context, ref, title: 'Guardadas', pool: saved, count: saved.length),
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(title, style: theme.textTheme.titleSmall),
              Text(subtitle, style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.settings, required this.bank});

  final AppSettings settings;
  final QuestionBank bank;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final field = settings.field;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ponderación de tu carrera', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              settings.career == null ? 'Elige tu carrera para ver cuánto pesa cada componente.' : '${settings.career} · ${field.name}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            for (final code in AdmissionRules.areaOrder) ...[
              Row(
                children: [
                  SizedBox(width: 150, child: Text(bank.area(code).name, style: theme.textTheme.bodySmall)),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: field.weights[code]! / 50,
                      minHeight: 10,
                      color: AreaStyle.color(code),
                      backgroundColor: AreaStyle.color(code).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(width: 44, child: Text('${field.weights[code]} %', textAlign: TextAlign.end)),
                ],
              ),
              const SizedBox(height: 6),
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => showCareerPicker(context),
                icon: const Icon(Icons.school_outlined),
                label: Text(settings.career == null ? 'Elegir carrera' : 'Cambiar carrera'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastExamCard extends StatelessWidget {
  const _LastExamCard({required this.session});

  final ExamSessionSummary session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: const Icon(Icons.insights),
        title: Text('Último simulacro: ${percent(session.weightedPercent, digits: 1)}', style: theme.textTheme.titleMedium),
        subtitle: Text(
          '${count(session.correct, 'correcta', 'correctas')} · ${count(session.wrong, 'incorrecta', 'incorrectas')} · '
          '${session.blank} en blanco\n'
          '${shortDate(session.startedAt)} · ${fieldByCode(session.fieldCode).name}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
