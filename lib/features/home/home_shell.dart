import 'package:flutter/material.dart';

import '../bank/bank_tab.dart';
import '../practice/practice_tab.dart';
import '../progress/progress_tab.dart';
import 'dashboard_tab.dart';

const _tabs = [
  (icon: Icons.home_outlined, selected: Icons.home, label: 'Inicio'),
  (icon: Icons.school_outlined, selected: Icons.school, label: 'Practicar'),
  (icon: Icons.search, selected: Icons.manage_search, label: 'Banco'),
  (icon: Icons.insights_outlined, selected: Icons.insights, label: 'Progreso'),
];

/// Main navigation: bottom bar on phones, side rail on wide screens.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int _tab = widget.initialTab;

  Widget get _body => switch (_tab) {
        0 => const DashboardTab(),
        1 => const PracticeTab(),
        2 => const BankTab(),
        _ => const ProgressTab(),
      };

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 840;
    return Scaffold(
      appBar: AppBar(
        title: const Text('P.E.U.C.'),
        actions: [
          IconButton(
            tooltip: 'Acerca de y fuentes',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed('/acerca'),
          ),
        ],
      ),
      body: wide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _tab,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (i) => setState(() => _tab = i),
                  destinations: [
                    for (final t in _tabs)
                      NavigationRailDestination(icon: Icon(t.icon), selectedIcon: Icon(t.selected), label: Text(t.label)),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: _body),
              ],
            )
          : _body,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _tab,
              onDestinationSelected: (i) => setState(() => _tab = i),
              destinations: [
                for (final t in _tabs)
                  NavigationDestination(icon: Icon(t.icon), selectedIcon: Icon(t.selected), label: t.label),
              ],
            ),
    );
  }
}
