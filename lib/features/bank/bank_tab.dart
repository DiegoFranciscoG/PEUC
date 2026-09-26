import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/theme.dart';
import '../../data/progress_repository.dart';
import '../../domain/admission_rules.dart';
import '../../domain/models.dart';
import '../../domain/search.dart';
import '../../state/providers.dart';
import '../common/async_view.dart';

/// Search the 2 737 official questions by number or text.
class BankTab extends ConsumerStatefulWidget {
  const BankTab({super.key});

  @override
  ConsumerState<BankTab> createState() => _BankTabState();
}

class _BankTabState extends ConsumerState<BankTab> {
  final _controller = TextEditingController();
  String? _area;
  bool _onlyObservations = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider).value ?? ProgressSnapshot.empty;
    return AsyncView<SearchIndex>(
      value: ref.watch(searchIndexProvider),
      builder: (index) {
        var results = index.search(_controller.text, areaCode: _area);
        if (_onlyObservations) results = results.where((q) => q.hasObservation).toList();
        return Column(
          children: [
            ReadableWidth(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Número (p. ej. 1234) o palabras del enunciado',
                        suffixIcon: _controller.text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Borrar',
                                icon: const Icon(Icons.clear),
                                onPressed: () => setState(_controller.clear),
                              ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(label: const Text('Todas'), selected: _area == null, onSelected: (_) => setState(() => _area = null)),
                          for (final code in AdmissionRules.areaOrder)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ChoiceChip(
                                avatar: Icon(AreaStyle.icon(code), size: 18),
                                label: Text(index.bank.area(code).name),
                                selected: _area == code,
                                onSelected: (_) => setState(() => _area = code),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: FilterChip(
                              label: const Text('Con observación'),
                              selected: _onlyObservations,
                              onSelected: (value) => setState(() => _onlyObservations = value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${thousands(results.length)} ${results.length == 1 ? 'pregunta' : 'preguntas'}', style: Theme.of(context).textTheme.labelMedium),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, i) => ReadableWidth(
                  child: QuestionTile(
                    question: results[i],
                    areaName: index.bank.area(results[i].areaCode).name,
                    bookmarked: progress.bookmarks.contains(results[i].number),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class QuestionTile extends StatelessWidget {
  const QuestionTile({super.key, required this.question, required this.areaName, this.bookmarked = false});

  final Question question;
  final String areaName;
  final bool bookmarked;

  @override
  Widget build(BuildContext context) {
    final preview = question.plainStem.isEmpty ? 'Pregunta con imagen' : question.plainStem;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AreaStyle.color(question.areaCode).withValues(alpha: 0.15),
        child: Icon(AreaStyle.icon(question.areaCode), color: AreaStyle.color(question.areaCode), size: 20),
      ),
      title: Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text('#${question.number} · $areaName · ${question.topicCode}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (question.hasImages) const Icon(Icons.image_outlined, size: 18),
          if (question.hasObservation) Icon(Icons.info_outline, size: 18, color: Theme.of(context).colorScheme.tertiary),
          if (bookmarked) const Icon(Icons.bookmark, size: 18),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed('/pregunta/${question.number}'),
    );
  }
}
