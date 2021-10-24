import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, watch, child) {
        final List<Event> eventsList = watch(eventsNotifierProvider).events;
        return Column(
          children: [
            Text(eventsList.length.toString()),
            Expanded(
              child: ListView.builder(
                itemCount: eventsList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(eventsList[index].title),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
