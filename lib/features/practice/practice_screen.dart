import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exam_builder.dart';
import '../../domain/models.dart';
import '../../domain/option_order.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../common/question_view.dart';

/// Opens a practice session built from [pool], prioritising wrong and unseen
/// questions. Shows a message when the pool is empty.
Future<void> openPractice(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  required List<Question> pool,
  int count = 10,
}) async {
  if (pool.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay preguntas para practicar aquí todavía.')));
    return;
  }
  final progress = await ref.read(progressProvider.future);
  final questions = ExamBuilder().practiceSet(pool, count, seen: progress.seen, lastWrong: progress.lastWrong);
  if (!context.mounted) return;
  await Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (_) => PracticeScreen(title: title, questions: questions),
  ));
}

class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.title, required this.questions});

  final String title;
  final List<Question> questions;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  final Map<int, String> _answers = {};
  final Map<int, List<AnswerOption>> _order = {};
  int _index = 0;
  bool _finished = false;

  Question get _current => widget.questions[_index];

  List<AnswerOption> _optionsOf(Question q, bool shuffle) =>
      _order.putIfAbsent(q.number, () => presentedOptions(q, shuffle: shuffle));

  Future<void> _answer(String label) async {
    setState(() => _answers[_current.number] = label);
    final repository = await ref.read(progressStoreProvider.future);
    await repository.recordPracticeAnswer(_current, label);
    ref.invalidate(progressProvider);
  }

  void _next() {
    if (_index < widget.questions.length - 1) {
      setState(() => _index++);
    } else {
      setState(() => _finished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bank = ref.watch(bankProvider);
    final shuffle = ref.watch(settingsProvider).value?.shuffleOptions ?? true;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (!_finished)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(child: Text('${_index + 1} / ${widget.questions.length}')),
            ),
        ],
        bottom: _finished
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: LinearProgressIndicator(value: (_index + 1) / widget.questions.length),
              ),
      ),
      body: AsyncView(
        value: bank,
        builder: (bank) => _finished ? _summary(context) : _question(context, bank, shuffle),
      ),
    );
  }

  Widget _question(BuildContext context, QuestionBank bank, bool shuffle) {
    final question = _current;
    final options = _optionsOf(question, shuffle);
    final chosen = _answers[question.number];
    final correctIndex = options.indexWhere((o) => question.isCorrect(o.label));
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        ReadableWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuestionView(
                question: question,
                options: options,
                areaName: bank.area(question.areaCode).name,
                selected: chosen,
                reveal: chosen != null,
                onSelect: _answer,
              ),
              if (chosen != null) ...[
                const SizedBox(height: 8),
                FeedbackPanel(question: question, chosen: chosen, correctDisplayLabel: displayLabel(correctIndex)),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _next,
                  icon: Icon(_index < widget.questions.length - 1 ? Icons.arrow_forward : Icons.flag),
                  label: Text(_index < widget.questions.length - 1 ? 'Siguiente' : 'Ver resultado'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _summary(BuildContext context) {
    final theme = Theme.of(context);
    final correct = widget.questions.where((q) => _answers[q.number] != null && q.isCorrect(_answers[q.number]!)).length;
    final wrong = widget.questions.where((q) => _answers[q.number] != null && !q.isCorrect(_answers[q.number]!)).toList();
    return ReadableWidth(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(Icons.emoji_events_outlined, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text('$correct de ${widget.questions.length} correctas',
              textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            wrong.isEmpty
                ? 'Excelente. Sigue con otro subtema o haz un simulacro completo.'
                : 'Las preguntas falladas aparecerán primero en tu próximo repaso.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          if (wrong.isNotEmpty)
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
                builder: (_) => PracticeScreen(title: 'Repaso de errores', questions: wrong),
              )),
              icon: const Icon(Icons.replay),
              label: Text('Repasar las ${wrong.length} falladas'),
            ),
          const SizedBox(height: 8),
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Volver')),
        ],
      ),
    );
  }
}
