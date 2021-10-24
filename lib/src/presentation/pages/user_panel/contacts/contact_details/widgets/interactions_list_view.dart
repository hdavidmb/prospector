import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';

import '../../../../../../features/interactions/application/interactions_providers.dart';
import '../../../../../../features/interactions/domain/entity/interaction_entity.dart';
import '../../../../../helpers/date_formatters.dart';

class InteractionsListView extends ConsumerWidget {
  final String contactID;
  const InteractionsListView({
    required this.contactID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Interaction> contactInteractions =
        watch(interactionsNotifierProvider)
            .interactions
            .where((interaction) =>
                interaction.contact == contactID && interaction.type != 'event')
            .toList();
    final List<Event> contactEvents = watch(eventsNotifierProvider)
        .events
        .where((event) =>
            event.guests != null && event.guests!.contains(contactID))
        .toList();
    final List<Object> combinedList =
        _combineLists(interactions: contactInteractions, events: contactEvents);
    return ListView.separated(
      itemCount: combinedList.length,
      itemBuilder: (context, index) =>
          InteractionListTile(object: combinedList[index]),
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        indent: 60.0,
      ),
    );
  }

  List<Object> _combineLists(
      {required List<Interaction> interactions, required List<Event> events}) {
    List<Object> combinedList = [];
    combinedList..addAll(interactions)..addAll(events);
    combinedList.sort((a, b) {
      final aDate = a is Interaction ? a.created : (a as Event).startDate;
      final bDate = b is Interaction ? b.created : (b as Event).startDate;
      return bDate.compareTo(aDate);
    });
    return combinedList;
  }
}

class InteractionListTile extends StatelessWidget {
  final Object object;
  const InteractionListTile({
    Key? key,
    required this.object,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String objectID;
    late IconData icon;
    late String description;
    late DateTime date;

    if (object is Interaction) {
      final interaction = object as Interaction;
      objectID = interaction.id;
      icon = interaction.type == 'user'
          ? Icons.fiber_manual_record
          : Icons.swap_horiz;
      description = interaction.description;
      date = interaction.created;
    } else {
      final event = object as Event;
      objectID = event.id;
      icon = Icons.event;
      description = event.title;
      date = event.startDate;
    }

    return Dismissible(
      key: Key(objectID),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => object is Interaction
          ? context
              .read(interactionsNotifierProvider)
              .deleteInteraction(interactionID: objectID)
          : context
              .read(eventsNotifierProvider)
              .deleteEvent(eventID: objectID), // TODO test
      child: ListTile(
        leading: Icon(icon),
        title: Text(description),
        subtitle: Text(getTimeagoFormatedDate(context, date)),
        onTap: object is Event
            ? () {
                //TODO navigate to event details
              }
            : null,
      ),
    );
  }
}
