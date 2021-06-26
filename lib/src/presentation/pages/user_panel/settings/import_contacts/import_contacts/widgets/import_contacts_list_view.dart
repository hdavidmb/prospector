import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/presentation/core/no_contatcs_screen/no_contacts_screen.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/import_contacts/logic/impor_contacts_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/import_contacts/widgets/imported_contact_tile.dart';

class ImportContactsListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<ImportedContact> deviceContacts =
        watch(importContactsPageProvider).showingList;
    return deviceContacts.isNotEmpty
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: deviceContacts.length,
            itemBuilder: (context, index) => ImportedContactTile(
              contact: deviceContacts[index],
              trailing: deviceContacts[index].selected
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : const Icon(Icons.radio_button_off),
              onTap: () {
                context
                    .read(importContactsPageProvider)
                    .selectContact(contact: deviceContacts[index]);
              },
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 0.0,
              indent: 10.0,
            ),
          )
        : NoContactsScreen(
            imagePath: 'assets/images/no_prospects.png',
            imageHeight: 120.0,
            message: AppLocalizations.of(context)!.noDeviceContactsMessage,
          );
  }
}
