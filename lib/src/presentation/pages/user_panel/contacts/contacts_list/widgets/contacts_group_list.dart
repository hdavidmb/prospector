import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/admob/application/ads_providers.dart';
import '../../../../../../features/admob/domain/native_ad_dummy.dart';
import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../core/no_contatcs_screen/no_contacts_screen.dart';
import '../../../../../routes/app_router.gr.dart';
import 'contact_tile.dart';
import 'custom_native_ad_widget.dart';

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
    final bool shouldShowAds = watch(showAds);

    for (final String status in statuses) {
      List<Object> contacts = [];
      if (status == context.read(appDefaultDataProvider).notContactedID) {
        contacts = watch(contactsNotifierProvider).notContactedContacts;
      } else if (status ==
          context.read(appDefaultDataProvider).notInterestedID) {
        contacts = watch(contactsNotifierProvider).notInterestedContacts;
      } else if (status == context.read(appDefaultDataProvider).invitedID) {
        contacts = watch(contactsNotifierProvider).invitedContacts;
      } else if (status == context.read(appDefaultDataProvider).followUpID) {
        contacts = watch(contactsNotifierProvider).followUpContacts;
      } else if (status == context.read(appDefaultDataProvider).clientID) {
        contacts = watch(contactsNotifierProvider).clientContacts;
      } else if (status == context.read(appDefaultDataProvider).executiveID) {
        contacts = watch(contactsNotifierProvider).executiveContacts;
      }
      final int contactsCount = contacts.length;

      if (shouldShowAds) {
        contacts = context.read(adsProvider).insertAds(contacts);
      }

      final String statusText = context
          .read(appDefaultDataProvider)
          .getStatusText(statusID: status, isPlural: true);

      if (contacts.isNotEmpty) {
        sections.add(
          SliverStickyHeader(
            header: Container(
              color: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '$statusText ($contactsCount)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final contact = contacts[index];
                  if (contact is Contact) {
                    return Column(
                      children: [
                        ContactTile(
                          contact: contact,
                          redName: status ==
                              context
                                  .read(appDefaultDataProvider)
                                  .notInterestedID,
                          onTap: () => AutoRouter.of(context)
                              .push(ContactDetailsRoute(contactID: contact.id)),
                        ),
                        const Divider(height: 0.0, indent: 75.0)
                      ],
                    );
                  } else if (contact is NativeAdDummy) {
                    return CustomNativeAdWidget(status: status, index: index);
                  }
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
                ? AppLocalizations.of(context).noFilteredProspectsMessage
                : AppLocalizations.of(context).noProspectsMessage,
          );
  }
}
