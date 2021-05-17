import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_details/contact_details_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contacts_tab_bar.dart';

class ContactsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.prospects),
      ),
      body: ContactsTabBar(),
      // Consumer(
      //   builder: (context, watch, child) {
      //     final contacts = watch(contactsNotifierProvider).contacts;
      //     return ListView.separated(
      //       itemBuilder: (context, index) => ContactTile(
      //         contact: contacts[index],
      //         onTap: () {
      //           Navigator.of(context).push(
      //             CupertinoPageRoute(
      //               builder: (context) => ContactDetailsPage(
      //                 contactID: contacts[index].id,
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //       separatorBuilder: (context, index) => const Divider(height: 0.0),
      //       itemCount: contacts.length,
      //     );
      //   },
      // ),
    );
  }
}
