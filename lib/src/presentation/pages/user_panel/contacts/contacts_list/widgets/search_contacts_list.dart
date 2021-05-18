import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_details/contact_details_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';

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
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
              child: Column(
                children: [
                  const Image(
                      image: AssetImage(
                          'assets/images/no_search_prospects.png'),
                      height: 140.0),
                  const SizedBox(height: 8.0),
                  Text(
                    AppLocalizations.of(context)!.noSearchProspectsMessage,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }
}
