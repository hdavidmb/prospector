import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_details/contact_details_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';

class ContactsGroupList extends ConsumerWidget {
  final List<String> statuses;
  const ContactsGroupList({
    required this.statuses,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final List<Widget> sections = [];

    for (final String status in statuses) {
      final List<Contact> contacts = watch(contactsNotifierProvider)
          .contacts
          .where((contact) => contact.status == status)
          .toList();
      final String statusText = context
          .read(appDefaultDataProvider)
          .getStatusText(context: context, statusID: status, isPlural: true);
      if (contacts.isNotEmpty) {
        sections.add(
          SliverStickyHeader(
            header: Container(
              // height: 30.0,
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
        : Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(children: [
              const Image(image: AssetImage('assets/images/no_prospects.png'), width: 150.0),
              const SizedBox(height: 8.0),
              Text(AppLocalizations.of(context)!.noProspectsMessage, textAlign: TextAlign.center,),
            ]),
          );
  }
}
