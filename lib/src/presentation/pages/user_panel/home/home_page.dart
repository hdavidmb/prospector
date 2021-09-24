import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logic/home_index_provider.dart';
import 'widgets/home_body_selector.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bottomBarItems = [
      {
        'icon': const Icon(Icons.insert_chart),
        'label': AppLocalizations.of(context)!.statistics,
      },
      {
        'icon': const Icon(Icons.people),
        'label': AppLocalizations.of(context)!.prospects,
      },
      {
        'icon': const Icon(Icons.person_add),
        'label': AppLocalizations.of(context)!.newString,
      },
      {
        'icon': const Icon(Icons.event),
        'label': AppLocalizations.of(context)!.events,
      },
      {
        'icon': const Icon(Icons.settings),
        'label': AppLocalizations.of(context)!.settings,
      },
    ];
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
