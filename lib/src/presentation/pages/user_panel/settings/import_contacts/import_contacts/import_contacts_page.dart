import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/import_contacts/application/import_contacts_providers.dart';
import '../../../../../../features/import_contacts/application/import_contacts_state.dart';
import '../../../../../core/widgets/loading_page_cover.dart';
import '../../../../../core/widgets/no_contatcs_screen/no_contacts_screen.dart';
import 'logic/impor_contacts_page_providers.dart';
import 'widgets/import_contacts_list_view.dart';
import 'widgets/import_contacts_search_bar.dart';
import 'widgets/select_all_button.dart';

class ImportContactsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ImportContactsState importContactsState =
        watch(importContactsProvider).state;
    final bool allSelected = watch(importContactsPageProvider).allSelected;
    final bool importing = watch(importContactsPageProvider).importing;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).importContacts),
        actions: [
          TextButton(
            onPressed: importing
                ? null
                : () async {
                    await context
                        .read(importContactsPageProvider)
                        .importSelectedContacts();
                    Future.delayed(Duration.zero, () {
                      AutoRouter.of(context).pop();
                    });
                  },
            child: Text(
              AppLocalizations.of(context).import,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: importContactsState == const ImportContactsState.ready()
          ? Stack(
              children: [
                Column(
                  children: [
                    ImportContactsSearchBar(),
                    Expanded(child: ImportContactsListView()),
                  ],
                ),
                if (importing) LoadingPageCover(),
              ],
            )
          : NoContactsScreen(
              imagePath: 'assets/images/loading_device_contacts.png',
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              imageHeight: 150.0,
              message: AppLocalizations.of(context).loadingContacts,
              action: const CircularProgressIndicator.adaptive(),
            ),
      bottomNavigationBar: SelectAllButton(
        allSelected: allSelected,
      ),
    );
  }
}
