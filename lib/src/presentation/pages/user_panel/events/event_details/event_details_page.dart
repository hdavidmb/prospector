import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';

import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
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
    final Event event = watch(eventsNotifierProvider).events.firstWhere(
        (event) => eventID == event.id,
        orElse: () => Event.empty());
    return Scaffold(
      appBar: AppBar(
        title: Text('Event details'), // TODO localize
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.title,
                    style: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold),
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
                ]),
          )
        ]),
      ),
    );
  }
}
