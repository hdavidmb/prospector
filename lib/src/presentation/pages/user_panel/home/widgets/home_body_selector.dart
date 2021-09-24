import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../contacts/contact_add_edit/contact_add_edit_page.dart';
import '../../contacts/contacts_list/contacts_list_page.dart';
import '../logic/home_index_provider.dart';
import '../../settings/settings_menu/settings_menu_page.dart';

class HomeBodySelector extends ConsumerWidget {
  const HomeBodySelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final int index = watch(homeIndexProvider).state;
    switch (index) {
      case 0:
        return Container(); //TODO implement statistics page
      case 1:
        return const ContactsListPage();
      case 2:
        return const ContactAddEditPage();
      case 3:
        return Container(); //TODO implement events page
      case 4:
        return SettingsMenuPage();
      default:
        return const ContactsListPage();
    }
  }
}
