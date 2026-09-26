import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/progress_repository.dart';
import '../../domain/option_order.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';
import '../common/question_view.dart';
import '../practice/practice_screen.dart';

/// One question of the bank with its answer (reachable at `#/pregunta/1234`).
class QuestionDetailScreen extends ConsumerWidget {
  const QuestionDetailScreen({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    final bookmarked = progress.bookmarks.contains(number);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta $number'),
        actions: [
          IconButton(
            tooltip: bookmarked ? 'Quitar de guardadas' : 'Guardar',
            icon: Icon(bookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () async {
              await (await ref.read(progressStoreProvider.future)).toggleBookmark(number);
              ref.invalidate(progressProvider);
            },
          ),
        ],
      ),
      body: AsyncView(
        value: ref.watch(bankProvider),
        builder: (bank) {
          final question = bank.byNumber(number);
          if (question == null) {
            return const Center(child: Text('Esa pregunta no existe en el banco oficial (1 a 2737).'));
          }
          final topic = bank.topic(question.topicCode);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ReadableWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('${topic.code} · ${topic.title}', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 12),
                    QuestionView(
                      question: question,
                      options: question.options,
                      areaName: bank.area(question.areaCode).name,
                      reveal: true,
                    ),
                    FeedbackPanel(
                      question: question,
                      correctDisplayLabel: displayLabel(question.options.indexWhere((o) => question.isCorrect(o.label))),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => openPractice(context, ref, title: 'Subtema ${topic.code}', pool: bank.byTopic(topic.code)),
                      icon: const Icon(Icons.play_arrow),
                      label: Text('Practicar el subtema ${topic.code}'),
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
