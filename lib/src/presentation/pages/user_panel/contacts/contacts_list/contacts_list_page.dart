import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/contacts/application/contacts_providers.dart';
import 'widgets/contacts_app_bar.dart';
import 'widgets/contacts_tab_bar.dart';
import 'widgets/search_contacts_list.dart';

class ContactsListPage extends ConsumerWidget {
  const ContactsListPage();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool _isFiltered = watch(contactsNotifierProvider).isFiltered;
    final bool isSearchBarShowing =
        watch(contactsNotifierProvider).isSearchBarShowing;
    final bool isSearchTextEmpty =
        watch(contactsNotifierProvider).isSearchTextEmpty;
    return Scaffold(
        appBar: ContactsAppBar(
            isSearchBarShowing: isSearchBarShowing, isFiltered: _isFiltered),
        body: isSearchTextEmpty
            ? Stack(
                children: [
                  ContactsTabBar(),
                  if (isSearchBarShowing)
                    GestureDetector(
                      onTap: () =>
                          context.read(contactsNotifierProvider).cancelSearch(),
                      child: Container(
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    )
                ],
              )
            : SearchContactsList());
  }
}
