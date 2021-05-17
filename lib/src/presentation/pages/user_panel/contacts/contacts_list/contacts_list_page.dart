import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contacts_tab_bar.dart';

class ContactsListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool _isFiltered = watch(contactsNotifierProvider).isFiltered;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.prospects),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO implement search
            },
          ),
          Ink(
            width: 43.0,
            height: 43.0,
            decoration: ShapeDecoration(
              color:
                  _isFiltered ? Colors.white : Theme.of(context).primaryColor,
              shape: const CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              color:
                  _isFiltered ? Theme.of(context).primaryColor : Colors.white,
              onPressed: () {
                showFiltersDialog(context);
              },
            ),
          ),
          const SizedBox(width:8.0),
        ],
      ),
      body: ContactsTabBar(),
    );
  }
}
