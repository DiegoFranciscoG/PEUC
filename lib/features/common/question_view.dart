import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/models.dart';
import '../../domain/option_order.dart';
import 'content_blocks.dart';

enum OptionState { idle, selected, correct, wrong, dimmed }

/// Stem and options of a question. With [reveal] the correct option is shown.
class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    required this.question,
    required this.options,
    required this.areaName,
    this.selected,
    this.reveal = false,
    this.onSelect,
  });

  final Question question;

  /// Options in the order they are shown (may be shuffled).
  final List<AnswerOption> options;
  final String areaName;

  /// Official label of the chosen option.
  final String? selected;
  final bool reveal;
  final ValueChanged<String>? onSelect;

  OptionState _stateOf(AnswerOption option) {
    if (!reveal) return option.label == selected ? OptionState.selected : OptionState.idle;
    if (question.isCorrect(option.label)) return OptionState.correct;
    if (option.label == selected) return OptionState.wrong;
    return OptionState.dimmed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Tag(icon: AreaStyle.icon(question.areaCode), text: areaName, color: AreaStyle.color(question.areaCode)),
            _Tag(icon: Icons.tag, text: 'Pregunta ${question.number}', color: theme.colorScheme.outline),
            _Tag(icon: Icons.bookmark_border, text: 'Subtema ${question.topicCode}', color: theme.colorScheme.outline),
          ],
        ),
        const SizedBox(height: 16),
        ContentBlocksView(question.stem, style: theme.textTheme.titleMedium?.copyWith(height: 1.4)),
        const SizedBox(height: 20),
        for (final (i, option) in options.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OptionTile(
              label: displayLabel(i),
              option: option,
              state: _stateOf(option),
              onTap: onSelect == null || reveal ? null : () => onSelect!(option.label),
            ),
          ),
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({super.key, required this.label, required this.option, required this.state, this.onTap});

  final String label;
  final AnswerOption option;
  final OptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (Color border, Color background, IconData? icon) = switch (state) {
      OptionState.idle => (scheme.outlineVariant, scheme.surface, null),
      OptionState.selected => (scheme.primary, scheme.primaryContainer, Icons.radio_button_checked),
      OptionState.correct => (scheme.success, scheme.successContainer, Icons.check_circle),
      OptionState.wrong => (scheme.error, scheme.errorContainer, Icons.cancel),
      OptionState.dimmed => (scheme.outlineVariant, scheme.surface, null),
    };
    return Semantics(
      button: onTap != null,
      selected: state == OptionState.selected,
      label: 'Opción $label',
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: border, width: state == OptionState.idle || state == OptionState.dimmed ? 1 : 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Opacity(
              opacity: state == OptionState.dimmed ? 0.6 : 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: border.withValues(alpha: 0.15),
                    child: Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurface)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: ContentBlocksView(option.blocks, maxImageHeight: 220)),
                  if (icon != null) ...[const SizedBox(width: 8), Icon(icon, color: border)],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Result of an answer, the justification and any verification note.
class FeedbackPanel extends StatelessWidget {
  const FeedbackPanel({super.key, required this.question, required this.correctDisplayLabel, this.chosen});

  final Question question;
  final String correctDisplayLabel;

  /// Official label chosen by the student; null when only reviewing.
  final String? chosen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final right = chosen != null && question.isCorrect(chosen!);
    final title = chosen == null
        ? 'Respuesta: $correctDisplayLabel)'
        : right
            ? '¡Correcto!'
            : 'Incorrecto · la respuesta es $correctDisplayLabel)';
    final color = chosen == null ? scheme.primary : (right ? scheme.success : scheme.error);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(chosen == null ? Icons.lightbulb_outline : (right ? Icons.check_circle : Icons.cancel), color: color),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: theme.textTheme.titleMedium?.copyWith(color: color))),
            ]),
            const SizedBox(height: 10),
            Text('Por qué', style: theme.textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(question.justification, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4)),
            if (question.note != null) ...[
              const SizedBox(height: 12),
              ObservationNote(question: question),
            ],
            const SizedBox(height: 12),
            Text(
              'Banco oficial UCuenca 2026 · pregunta ${question.number} · página ${question.page} del PDF',
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class ObservationNote extends StatelessWidget {
  const ObservationNote({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = switch (question.flag) {
      'corregida' => 'Respuesta corregida en la verificación',
      'sin_opcion_correcta' => 'Ítem del banco oficial con error',
      'ambigua' => 'Ítem ambiguo',
      _ => 'Nota de verificación',
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: scheme.onTertiaryContainer, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: '$title. ', style: const TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: question.note),
              ]),
              style: TextStyle(color: scheme.onTertiaryContainer, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(child: Text(text, style: Theme.of(context).textTheme.labelMedium)),
      ]),
    );
  }
}
