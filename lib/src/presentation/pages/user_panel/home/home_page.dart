import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import 'logic/home_index_provider.dart';
import 'widgets/home_body_selector.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> bottomBarItems = [
    {
      'icon': const Icon(Icons.insert_chart),
      'label': AppLocalizations.current.statistics,
    },
    {
      'icon': const Icon(Icons.people),
      'label': AppLocalizations.current.prospects,
    },
    {
      'icon': const Icon(Icons.person_add),
      'label': AppLocalizations.current.newString,
    },
    {
      'icon': const Icon(Icons.event),
      'label': AppLocalizations.current.events,
    },
    {
      'icon': const Icon(Icons.settings),
      'label': AppLocalizations.current.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final indexProvider = watch(homeIndexProvider);
        final int currentIndex = indexProvider.state;
        return Scaffold(
          body: const HomeBodySelector(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => context.read(homeIndexProvider).state = index,
            items: bottomBarItems
                .map(
                  (itemMap) => BottomNavigationBarItem(
                    icon: itemMap['icon'] as Icon,
                    label: itemMap['label'] as String,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
