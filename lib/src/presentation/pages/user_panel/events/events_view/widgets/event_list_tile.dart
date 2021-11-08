import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:prospector/src/presentation/routes/app_router.gr.dart';

import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../core/widgets/dismissible_background.dart';
import '../../../../../helpers/date_formatters.dart';
import '../../../../../theme/theme_providers.dart';
import '../logic/events_view_providers.dart';

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
          AutoRouter.of(context).push(EventDetailsRoute(eventID: event.id));
        },
      ),
    );
  }
}
