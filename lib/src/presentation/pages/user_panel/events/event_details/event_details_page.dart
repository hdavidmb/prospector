import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';

class EventDetailsPage extends ConsumerWidget {
  final String eventID;
  const EventDetailsPage({
    Key? key,
    required this.eventID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Event event = watch(eventsNotifierProvider).events.firstWhere(
        (event) => eventID == event.id,
        orElse: () => Event.empty());
    return Scaffold(body: Center(child: Text('EventDetails: ${event.title}')));
  }
}
