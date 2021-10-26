import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/theme/theme_providers.dart';

import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../../features/events/domain/entity/event_entity.dart';
import '../../../../../core/widgets/dismissible_background.dart';
import '../../../../../helpers/date_formatters.dart';
import '../logic/events_view_providers.dart';

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
    return Dismissible(
      key: Key(event.id),
      direction: DismissDirection.endToStart,
      background: const DismissibleBackground(),
      onDismissed: (direction) {
        context.read(eventsNotifierProvider).deleteEvent(eventID: event.id);
      },
      child: ListTile(
        title: Text(event.title),
        subtitle: Text(
          eventTileFormatedDate(
              selectedDate: context.read(eventsViewProvider).selectedDay,
              event: event,
              is24hours: context.read(themeNotifierProvider).is24hours),
        ),
        leading:
            Icon(event.type == 'event' ? Icons.event : Icons.notifications),
        onTap: () {
          // TODO navigate to event details or edit page
        },
      ),
    );
  }
}
