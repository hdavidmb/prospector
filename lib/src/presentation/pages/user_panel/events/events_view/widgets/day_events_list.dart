import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../../features/events/domain/entity/event_entity.dart';
import '../../../../../helpers/date_formatters.dart';
import '../logic/events_view_providers.dart';
import 'event_list_tile.dart';

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
