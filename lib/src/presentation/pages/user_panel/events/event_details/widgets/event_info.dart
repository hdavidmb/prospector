import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';
import '../../../../../helpers/date_formatters.dart';

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
