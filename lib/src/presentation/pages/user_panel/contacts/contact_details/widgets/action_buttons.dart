import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../generated/l10n.dart';

import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../logic/contact_details_provider.dart';

class ActionButtons extends StatelessWidget {
  final Contact contact;
  final String contactStatus;
  final String? gender;
  ActionButtons({
    Key? key,
    required this.contact,
  })  : contactStatus = contact.status,
        gender = contact.gender,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final executiveID = context.read(appDefaultDataProvider).executiveID;
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    const verticalDivider = VerticalDivider(
      width: 0.0,
      thickness: 1.0,
      endIndent: 5.0,
      indent: 5.0,
    );
    return Container(
      color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
      padding: const EdgeInsets.only(top: 6.0),
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: double.infinity,
            width: screenSize.width / 3,
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () async {
                await context
                    .read(contactDetailsProvider)
                    .backwardActionButtonPressed(contact: contact);
              },
              child: Text(
                _getBackwardActionButtonText(context),
                style: TextStyle(
                    color: isDarkTheme ? Colors.white70 : Colors.black87),
              ),
            ),
          ),
          verticalDivider,
          SizedBox(
            height: double.infinity,
            width: screenSize.width / 3,
            child: TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: () {},
              icon: Icon(Icons.add,
                  size: 20.0,
                  color: isDarkTheme ? Colors.white70 : Colors.black87),
              label: Text(
                'Event',
                style: TextStyle(
                    color: isDarkTheme ? Colors.white70 : Colors.black87),
              ),
            ),
          ),
          verticalDivider,
          SizedBox(
            height: double.infinity,
            width: screenSize.width / 3,
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.transparent),
              onPressed: contact.status == executiveID
                  ? null
                  : () async {
                      await context
                          .read(contactDetailsProvider)
                          .forewardActionButtonPressed(
                              context: context, contact: contact);
                    },
              child: Text(
                _getForwardActionButtonText(context),
                style: TextStyle(
                    color: isDarkTheme ? Colors.white70 : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBackwardActionButtonText(BuildContext context) {
    final notInterestedID =
        context.read(appDefaultDataProvider).notInterestedID;
    return contactStatus == notInterestedID
        ? gender == 'female'
            ? AppLocalizations.current.notContactedF
            : AppLocalizations.current.notContacted
        : gender == 'female'
            ? AppLocalizations.current.notInteresteF
            : AppLocalizations.current.notInterested;
  }

  String _getForwardActionButtonText(BuildContext context) {
    final invitedID = context.read(appDefaultDataProvider).invitedID;
    final followUpID = context.read(appDefaultDataProvider).followUpID;
    final clientID = context.read(appDefaultDataProvider).clientID;
    final executiveID = context.read(appDefaultDataProvider).executiveID;
    return (contactStatus == executiveID || contactStatus == clientID)
        ? gender == 'female'
            ? AppLocalizations.current.executiveF
            : AppLocalizations.current.executive
        : contactStatus == followUpID
            ? AppLocalizations.current.affiliate
            : contactStatus == invitedID
                ? AppLocalizations.current.present
                : AppLocalizations.current.invite;
  }
}
