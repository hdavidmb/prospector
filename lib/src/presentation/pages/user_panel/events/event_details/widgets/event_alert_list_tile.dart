import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/events/domain/entites/event_alert.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';
import '../../../../../core/dialogs.dart';
import '../logic/event_details_providers.dart';

class EventAlertListTile extends StatelessWidget {
  const EventAlertListTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Text(AppLocalizations.of(context).alert),
          Expanded(child: Container()),
          Text(
            event.notification.text,
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
            () => context.read(eventDetailsPageProvider).alertListTilePressed(
                event: event, selectedAlert: selectedAlert));
      },
    );
  }
}
