import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../routes/app_router.gr.dart';
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
        final int currentIndex = watch(homeIndexProvider).index;
        return Scaffold(
          body: const HomeBodySelector(),
          floatingActionButton: FloatingActionButton(
            elevation: 1.0,
            onPressed: () {
              AutoRouter.of(context).push(ContactAddEditRoute());
            },
            child: const Icon(Icons.person_add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => context.read(homeIndexProvider).index = index,
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
