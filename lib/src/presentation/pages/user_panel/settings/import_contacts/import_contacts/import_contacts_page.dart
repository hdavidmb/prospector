import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
import 'package:prospector/src/presentation/core/no_contatcs_screen/no_contacts_screen.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/widgets/import_contacts_list_view.dart';

class ImportContactsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ImportContactsState importContactsState =
        watch(importContactsProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.importContacts),
      ),
      body: importContactsState == const ImportContactsState.ready()
          ? ImportContactsListView()
          : NoContactsScreen(
              imagePath: 'assets/images/loading_device_contacts.png',
              padding: const EdgeInsets.symmetric(vertical: 80.0),
              imageHeight: 150.0,
              message: 'Loading contacts...', //TODO localize
              action: const CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
