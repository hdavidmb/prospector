import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
import 'package:prospector/src/presentation/core/no_contatcs_screen/no_contacts_screen.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/logic/impor_contacts_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/widgets/import_contacts_search_bar.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/widgets/import_contacts_list_view.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/widgets/select_all_button.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/widgets/loading_page_cover.dart';

class ImportContactsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ImportContactsState importContactsState =
        watch(importContactsProvider).state;
    final bool allSelected = watch(importContactsPageProvider).allSelected;
    final bool importing = watch(importContactsPageProvider).importing;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.importContacts),
        actions: [
          TextButton(
            onPressed:
                importing ? null : context.read(importContactsPageProvider).importSelectedContacts,
            child: Text(
              AppLocalizations.of(context)!.import,
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
                    SelectAllButton(
                      allSelected: allSelected,
                    )
                  ],
                ),
                if (importing) LoadingPageCover(),
            ],
          )
          : NoContactsScreen(
              imagePath: 'assets/images/loading_device_contacts.png',
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              imageHeight: 150.0,
              message: AppLocalizations.of(context)!.loadingContacts,
              action: const CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
