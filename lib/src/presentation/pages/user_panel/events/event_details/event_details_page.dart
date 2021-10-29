import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';

import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_image.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';
import 'package:prospector/src/presentation/theme/theme_providers.dart';

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
        ],
      ),
    );
  }
}

class EventGuestsListTile extends StatelessWidget {
  const EventGuestsListTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final bool hasGuests = event.guests != null && event.guests!.isNotEmpty;
    return Padding(
      padding: hasGuests ? const EdgeInsets.only(top: 12.0) : EdgeInsets.zero,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text(AppLocalizations.of(context).guests),
            Expanded(child: Container()),
            Text(
              '${event.guests?.length ?? 0}',
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            )
          ],
        ),
        subtitle: hasGuests
            ? Wrap(
                //TODO test with multiple guests to set up spaces
                children: event.guests!.map(
                  (guest) {
                    final Contact contact = context
                        .read(contactsNotifierProvider)
                        .contacts
                        .firstWhere((listContact) => listContact.id == guest);
                    return Chip(
                      avatar:
                          ContactImage(size: 30.0, contactPhoto: contact.photo),
                      label: Text(contact.name),
                    );
                  },
                ).toList(),
              )
            : null,
        trailing: const Icon(Icons.navigate_next, color: Colors.grey),
        onTap: () {
          // TODO select guests and edit event
        },
      ),
    );
  }
}

class EventInfo extends StatelessWidget {
  const EventInfo({
    Key? key,
    required this.event,
    required this.is24hours,
  }) : super(key: key);

  final Event event;
  final bool is24hours;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 10.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          if (event.location != null && event.location!.isNotEmpty)
            Text(
              event.location!,
              style: const TextStyle(fontSize: 18.0),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              event.allDay
                  ? AppLocalizations.of(context).allDay
                  : eventDetailsFormatedDate(
                      startDate: event.startDate,
                      endDate: event.endDate,
                      is24hours: is24hours,
                    ),
              style: const TextStyle(
                  fontSize: 14.0, height: 1.4, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
