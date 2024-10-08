import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/events/domain/entites/event_alert.dart';
import '../../../../core/dialogs.dart';

class EventAlertListTile extends StatelessWidget {
  final EventAlert eventAlert;
  final void Function(Option<EventAlert>) onSelectAlert;
  const EventAlertListTile({
    Key? key,
    required this.eventAlert,
    required this.onSelectAlert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(AppLocalizations.of(context).alert),
          Text(
            eventAlert.text,
            style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
      ),
      trailing: const Icon(Icons.navigate_next, color: Colors.grey),
      onTap: () async {
        //TODO check for notifications permissions
        final selectedAlert = await showAlertSelectionDialog(context: context);
        Future.delayed(
          Duration.zero,
          () => onSelectAlert(selectedAlert),
        );
      },
    );
  }
}
