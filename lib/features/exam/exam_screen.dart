import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../domain/admission_rules.dart';
import '../../domain/exam_builder.dart';
import '../../domain/models.dart';
import '../../domain/option_order.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../common/question_view.dart';
import 'exam_result_screen.dart';

/// Timed simulation with the official structure: 60 questions (12 per
/// component), 70 minutes, no feedback until the end.
class ExamScreen extends ConsumerStatefulWidget {
  const ExamScreen({super.key});

  @override
  ConsumerState<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends ConsumerState<ExamScreen> {
  List<Question>? _questions;
  final Map<int, List<AnswerOption>> _order = {};
  final Map<int, String> _answers = {};
  int _index = 0;
  late DateTime _startedAt;
  Timer? _timer;
  Duration _remaining = AdmissionRules.examDuration;
  bool _finishing = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start(QuestionBank bank, bool shuffle) {
    final questions = ExamBuilder().simulation(bank);
    for (final q in questions) {
      _order[q.number] = presentedOptions(q, shuffle: shuffle);
    }
    _questions = questions;
    _startedAt = DateTime.now();
    // The remaining time is derived from the clock, so it stays right even if
    // the app goes to the background.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final left = AdmissionRules.examDuration - DateTime.now().difference(_startedAt);
      if (left <= Duration.zero) {
        _finish(timeUp: true);
      } else if (mounted) {
        setState(() => _remaining = left);
      }
    });
  }

  Future<void> _finish({bool timeUp = false}) async {
    if (_finishing) return;
    _finishing = true;
    _timer?.cancel();
    final questions = _questions!;
    final elapsed = DateTime.now().difference(_startedAt);
    final settings = await ref.read(settingsProvider.future);
    final repository = await ref.read(progressStoreProvider.future);
    await repository.saveExam(
      questions: questions,
      answers: _answers,
      startedAt: _startedAt,
      elapsed: elapsed > AdmissionRules.examDuration ? AdmissionRules.examDuration : elapsed,
      field: settings.field,
    );
    ref.invalidate(progressProvider);
    if (!mounted) return;
    if (timeUp) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Se acabó el tiempo: el simulacro se calificó automáticamente.')));
    }
    await Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      builder: (_) => ExamResultScreen(questions: questions, answers: Map.of(_answers), order: _order, elapsed: elapsed),
    ));
  }

  Future<void> _confirmFinish() async {
    final blank = _questions!.length - _answers.length;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Finalizar el simulacro?'),
        content: Text(blank == 0
            ? 'Respondiste todas las preguntas.'
            : 'Tienes $blank preguntas en blanco (valen 0 puntos; una respuesta incorrecta resta 1/3).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Seguir')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Finalizar')),
        ],
      ),
    );
    if (ok == true) await _finish();
  }

  Future<void> _confirmExit() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Salir del simulacro?'),
        content: const Text('Perderás las respuestas de este intento.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Quedarme')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Salir')),
        ],
      ),
    );
    if (leave == true && mounted) {
      _timer?.cancel();
      Navigator.of(context).pop();
    }
  }

  void _showMap() {
    final questions = _questions!;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_answers.length} de ${questions.length} respondidas', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final (i, q) in questions.indexed)
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: FilledButton.tonal(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: _answers.containsKey(q.number) ? scheme.primary : null,
                          foregroundColor: _answers.containsKey(q.number) ? scheme.onPrimary : null,
                          side: i == _index ? BorderSide(color: scheme.tertiary, width: 2) : null,
                        ),
                        onPressed: () {
                          setState(() => _index = i);
                          Navigator.pop(context);
                        },
                        child: Text('${i + 1}'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bank = ref.watch(bankProvider);
    final settings = ref.watch(settingsProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simulacro'),
          actions: [
            if (_questions != null) _TimerChip(remaining: _remaining),
            TextButton(onPressed: _questions == null ? null : _confirmFinish, child: const Text('Finalizar')),
          ],
        ),
        body: AsyncView(
          value: bank,
          builder: (bank) {
            if (_questions == null) {
              if (!settings.hasValue) return const Center(child: CircularProgressIndicator());
              _start(bank, settings.value!.shuffleOptions);
            }
            return _body(context, bank);
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, QuestionBank bank) {
    final questions = _questions!;
    final question = questions[_index];
    final areaIndex = questions.where((q) => q.areaCode == question.areaCode).toList().indexOf(question) + 1;
    final areaTotal = questions.where((q) => q.areaCode == question.areaCode).length;
    return Column(
      children: [
        LinearProgressIndicator(value: (_index + 1) / questions.length),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              ReadableWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pregunta ${_index + 1} de ${questions.length} · ${bank.area(question.areaCode).name} $areaIndex/$areaTotal',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    QuestionView(
                      question: question,
                      options: _order[question.number]!,
                      areaName: bank.area(question.areaCode).name,
                      selected: _answers[question.number],
                      onSelect: (label) => setState(() => _answers[question.number] = label),
                    ),
                    if (_answers.containsKey(question.number))
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => setState(() => _answers.remove(question.number)),
                          icon: const Icon(Icons.backspace_outlined),
                          label: const Text('Dejar en blanco'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: ReadableWidth(
              child: Row(
                children: [
                  IconButton.outlined(
                    tooltip: 'Anterior',
                    onPressed: _index == 0 ? null : () => setState(() => _index--),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _showMap,
                      icon: const Icon(Icons.grid_view),
                      label: Text('${_answers.length}/${questions.length}'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _index == questions.length - 1
                      ? FilledButton(onPressed: _confirmFinish, child: const Text('Finalizar'))
                      : IconButton.filled(
                          tooltip: 'Siguiente',
                          onPressed: () => setState(() => _index++),
                          icon: const Icon(Icons.arrow_forward),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerChip extends StatelessWidget {
  const _TimerChip({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final low = remaining < const Duration(minutes: 5);
    return Chip(
      avatar: Icon(Icons.timer_outlined, size: 18, color: low ? scheme.error : null),
      label: Text(clock(remaining), style: TextStyle(color: low ? scheme.error : null, fontFeatures: const [])),
      visualDensity: VisualDensity.compact,
    );
  }
}
