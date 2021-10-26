import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/logic/events_view_providers.dart';

class DayEventsList extends ConsumerWidget {
  const DayEventsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final DateTime selectedDay = watch(eventsViewProvider).selectedDay;
    final List<Event> selectedDayEvents = watch(eventsNotifierProvider)
        .events
        .where(
          (event) => isBetweenDays(
            date: selectedDay,
            startDate: event.startDate,
            endDate: event.endDate,
          ),
        )
        .toList();
    return ListView.separated(
      itemCount: selectedDayEvents.length,
      itemBuilder: (context, index) =>
          EventListTile(event: selectedDayEvents[index]),
      separatorBuilder: (_, __) => const Divider(height: 0.0, indent: 8.0),
    );
  }
}

class EventListTile extends StatelessWidget {
  const EventListTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title),
      leading: Icon(event.type == 'event' ? Icons.event : Icons.notifications),
    );
  }
}
