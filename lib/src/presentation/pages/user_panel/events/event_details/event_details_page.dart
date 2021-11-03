import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/events/application/events_providers.dart';
import '../../../../theme/theme_providers.dart';
import 'widgets/event_guests_list_tile.dart';
import 'widgets/event_info.dart';

class EventDetailsPage extends ConsumerWidget {
  final String eventID;
  const EventDetailsPage({
    Key? key,
    required this.eventID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool is24hours = watch(themeNotifierProvider).is24hours;
    const Divider divider = Divider(height: 0.0, indent: 15.0);
    final Event event = watch(eventsNotifierProvider).events.firstWhere(
        (event) => eventID == event.id,
        orElse: () => Event.empty());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).eventDetails),
        actions: [
          TextButton(
            onPressed: () {
              //TODO navigate to edit event
            },
            child: Text(
              AppLocalizations.of(context).edit,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          EventInfo(event: event, is24hours: is24hours),
          divider,
          EventGuestsListTile(event: event),
          divider,
          ListTile(
            title: Row(
              children: <Widget>[
                Text(AppLocalizations.of(context).alert),
                Expanded(child: Container()),
                Text(
                  getAlertText(
                      startDate: event.startDate,
                      notification: event.notifications?[0]),
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
            trailing: const Icon(Icons.navigate_next, color: Colors.grey),
            onTap: () {
              //TODO select alert and update event notifications
              showOptionsSelectionDialog(
                  context: context, options: [5, 15, 30, 60]);
            },
          ),
          divider,
        ],
      ),
    );
  }
}
