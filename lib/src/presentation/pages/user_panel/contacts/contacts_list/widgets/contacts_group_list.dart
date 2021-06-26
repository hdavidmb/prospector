import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../core/no_contatcs_screen/no_contacts_screen.dart';
import '../../contact_details/contact_details_page.dart';
import 'contact_tile.dart';

class ContactsGroupList extends ConsumerWidget {
  final List<String> statuses;
  const ContactsGroupList({
    required this.statuses,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final List<Widget> sections = [];
    final bool isFiltered = watch(contactsNotifierProvider).isFiltered;

    for (final String status in statuses) {
      final List<Contact> contacts = watch(contactsNotifierProvider)
          .filteredContacts
          .where((contact) => contact.status == status)
          .toList();
      final String statusText = context
          .read(appDefaultDataProvider)
          .getStatusText(context: context, statusID: status, isPlural: true);
      if (contacts.isNotEmpty) {
        sections.add(
          SliverStickyHeader(
            header: Container(
              color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '$statusText (${contacts.length})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      ContactTile(
                        contact: contacts[index],
                        redName: status ==
                            context
                                .read(appDefaultDataProvider)
                                .notInterestedID,
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => ContactDetailsPage(
                                contactID: contacts[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 0.0, indent: 75.0)
                    ],
                  );
                },
                childCount: contacts.length,
              ),
            ),
          ),
        );
      }
    }

    return sections.isNotEmpty
        ? Scrollbar(
            child: CustomScrollView(
              slivers: sections,
            ),
          )
        : NoContactsScreen(
            imagePath: isFiltered
                    ? 'assets/images/no_filtered_prospects.png'
                    : 'assets/images/no_prospects.png',
            imageHeight: 120.0,
            message: isFiltered
                  ? AppLocalizations.of(context)!.noFilteredProspectsMessage
                  : AppLocalizations.of(context)!.noProspectsMessage,
          );
  }
}
