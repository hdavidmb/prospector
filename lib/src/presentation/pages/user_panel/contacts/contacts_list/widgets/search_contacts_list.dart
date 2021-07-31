import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../core/no_contatcs_screen/no_contacts_screen.dart';
import '../../contact_details/contact_details_page.dart';
import 'contact_tile.dart';

class SearchContactsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final searchContacts = watch(contactsNotifierProvider).searchingContacts;
    return searchContacts.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) => ContactTile(
              contact: searchContacts[index],
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => ContactDetailsPage(
                      contactID: searchContacts[index].id,
                    ),
                  ),
                );
              },
            ),
            separatorBuilder: (context, index) =>
                const Divider(height: 0.0, indent: 75.0),
            itemCount: searchContacts.length,
          )
        : NoContactsScreen(
            imagePath: 'assets/images/no_search_prospects.png',
            imageHeight: 140.0,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
            message: AppLocalizations.of(context)!.noSearchProspectsMessage,
          );
  }
}
