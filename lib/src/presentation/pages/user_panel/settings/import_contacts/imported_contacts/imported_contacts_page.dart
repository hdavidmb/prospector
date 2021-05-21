import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/presentation/core/no_contatcs_screen/no_contacts_screen.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/import_contacts_page.dart';

class ImportedContactsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Contact> importedContacts = watch(contactsNotifierProvider)
        .contacts
        .where((contact) =>
            contact.importedId != null && contact.importedId!.isNotEmpty)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.importedContacts,
          style: const TextStyle(fontSize: 18.0),
        ),
        actions: [
          TextButton(
            onPressed: () => goToImportContacts(context),
            child: Text(
              AppLocalizations.of(context)!.import,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: importedContacts.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) => ContactTile(
                contact: importedContacts[index],
                onTap: () {
                  //TODO show confirm delete contact
                },
              ), //TODO create imported contact tile - device contact tile
              separatorBuilder: (context, index) =>
                  const Divider(height: 0.0, indent: 75.0),
              itemCount: importedContacts.length,
            )
          : NoContactsScreen(
              imagePath: 'assets/images/no_imported_contacts.png',
              imageHeight: 150.0,
              message: AppLocalizations.of(context)!.noImportedContactsMessage,
              action: ElevatedButton(
                onPressed: () => goToImportContacts(context),
                child: Text(AppLocalizations.of(context)!.importContacts),
              ),
            ),
    );
  }

  void goToImportContacts(BuildContext context) {
    //TODO test getting contacts from here
    context.read(importContactsProvider).getContacts();
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ImportContactsPage()));
  }
}
