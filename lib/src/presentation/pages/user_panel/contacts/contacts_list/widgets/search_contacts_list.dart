import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../core/widgets/no_contatcs_screen/info_message_page.dart';
import '../../../../../routes/app_router.gr.dart';
import 'contact_tile.dart';

class SearchContactsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final searchContacts = watch(contactsNotifierProvider).searchingContacts;
    return searchContacts.isNotEmpty
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ContactTile(
              contact: searchContacts[index],
              onTap: () => AutoRouter.of(context).push(
                  ContactDetailsRoute(contactID: searchContacts[index].id)),
            ),
            separatorBuilder: (context, index) =>
                const Divider(height: 0.0, indent: 75.0),
            itemCount: searchContacts.length,
          )
        : InfoMessagePage(
            imagePath: 'assets/images/no_search_prospects.png',
            imageHeight: 140.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
            message: AppLocalizations.of(context).noSearchProspectsMessage,
          );
  }
}
