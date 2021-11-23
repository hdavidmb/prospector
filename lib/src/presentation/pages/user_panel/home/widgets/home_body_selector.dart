import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/statistics_page.dart';

import '../../contacts/contacts_list/contacts_list_page.dart';
import '../../events/events_view/events_view_page.dart';
import '../../settings/settings_menu/settings_menu_page.dart';
import '../logic/home_index_provider.dart';

class HomeBodySelector extends ConsumerWidget {
  const HomeBodySelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final int index = watch(homeIndexProvider).index;
    switch (index) {
      case 0:
        return const StatisticsPage();
      case 1:
        return const ContactsListPage();
      case 2:
        return const EventsViewPage();
      case 3:
        return const SettingsMenuPage();
      default:
        return const ContactsListPage();
    }
  }
}
