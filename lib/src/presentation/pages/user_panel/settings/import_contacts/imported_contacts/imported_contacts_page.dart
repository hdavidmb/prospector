import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/presentation/core/no_contatcs_screen/no_contacts_screen.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_image.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/import_contacts_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/widgets/imported_contact_tile.dart';

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
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final Contact contact = importedContacts[index];
                final ImportedContact importedContact =
                    ImportedContact.fromContact(contact);
                return Dismissible(
                  key: Key(contact.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    deleteContact(context, contact.id);
                  },
                  child: ImportedContactTile(
                    contact: importedContact,
                    leading:
                        ContactImage(size: 60.0, contactPhoto: contact.photo),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        deleteContact(context, contact.id);
                      },
                    ),
                  ),
                );
              },
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
    context.read(importContactsProvider).getContacts();
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => ImportContactsPage()));
  }

  void deleteContact(BuildContext context, String contactID) {
    context
        .read(contactFormProvider.notifier)
        .deleteContact(context: context, contactID: contactID);
  }
}
