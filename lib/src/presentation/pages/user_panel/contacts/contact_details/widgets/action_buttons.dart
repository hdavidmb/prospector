import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';

class ActionButtons extends StatelessWidget {
  final String contactStatus;
  final String? gender;
  const ActionButtons({
    Key? key,
    required this.contactStatus,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    const verticalDivider = VerticalDivider(
      width: 0.0,
      thickness: 1.0,
      endIndent: 5.0,
      indent: 5.0,
    );
    return Container(
      color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              _getBackwardActionButtonText(context),
              style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black87),
            ),
          ), //TODO implement action button
          verticalDivider,
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add, size: 20.0,
                color: isDarkTheme ? Colors.white70 : Colors.black87),
            label: Text(
              'Event',
              style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black87),
            ),
          ), //TODO implement action button
          verticalDivider,
          TextButton(
            onPressed: () {},
            child: Text(
              _getForwardActionButtonText(context),
              style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black87),
            ),
          ), //TODO implement action button
        ],
      ),
    );
  }

  String _getBackwardActionButtonText(BuildContext context) {
    //TODO test
    final notInterestedID =
        context.read(appDefaultDataProvider).notInterestedID;
    return contactStatus == notInterestedID
        ? gender == 'female'
            ? AppLocalizations.of(context)!.notContactedF
            : AppLocalizations.of(context)!.notContacted
        : gender == 'female'
            ? AppLocalizations.of(context)!.notInteresteF
            : AppLocalizations.of(context)!.notInterested;
  }

  String _getForwardActionButtonText(BuildContext context) {
    //TODO test
    final invitedID = context.read(appDefaultDataProvider).invitedID;
    final followUpID = context.read(appDefaultDataProvider).followUpID;
    final clientID = context.read(appDefaultDataProvider).clientID;
    final executiveID = context.read(appDefaultDataProvider).executiveID;
    return (contactStatus == executiveID || contactStatus == clientID)
        ? gender == 'female'
            ? AppLocalizations.of(context)!.executiveF
            : AppLocalizations.of(context)!.executive
        : contactStatus == followUpID
            ? AppLocalizations.of(context)!.affiliate
            : contactStatus == invitedID
                ? AppLocalizations.of(context)!.present
                : AppLocalizations.of(context)!.invite;
  }
}
