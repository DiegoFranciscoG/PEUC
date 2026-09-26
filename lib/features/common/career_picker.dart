import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/admission_rules.dart';
import '../../domain/search.dart';
import '../../state/providers.dart';

/// Lets the student pick a career; its field decides the exam weights.
Future<void> showCareerPicker(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => const FractionallySizedBox(heightFactor: 0.85, child: _CareerList()),
    );

class _CareerList extends ConsumerStatefulWidget {
  const _CareerList();

  @override
  ConsumerState<_CareerList> createState() => _CareerListState();
}

class _CareerListState extends ConsumerState<_CareerList> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(settingsProvider).value?.career;
    final query = normalizeForSearch(_query);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            autofocus: false,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Busca tu carrera'),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (final field in knowledgeFields) ...[
                if (field.careers.any((c) => normalizeForSearch(c).contains(query)))
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(field.name, style: Theme.of(context).textTheme.titleSmall),
                  ),
                for (final career in field.careers)
                  if (normalizeForSearch(career).contains(query))
                    ListTile(
                      title: Text(career),
                      trailing: career == selected ? const Icon(Icons.check) : null,
                      onTap: () async {
                        await ref.read(settingsProvider.notifier).setCareer(career);
                        if (context.mounted) Navigator.of(context).pop();
                      },
                    ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
