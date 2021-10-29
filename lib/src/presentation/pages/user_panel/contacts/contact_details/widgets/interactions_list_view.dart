import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/core/widgets/dismissible_background.dart';
import 'package:prospector/src/presentation/routes/app_router.gr.dart';

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
      physics: const BouncingScrollPhysics(),
      itemCount: combinedList.length,
      itemBuilder: (context, index) => InteractionListTile(
        object: combinedList[index],
        contactID: contactID,
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        indent: 60.0,
      ),
    );
  }

  List<Object> _combineLists(
      {required List<Interaction> interactions, required List<Event> events}) {
    final List<Object> combinedList = [];
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
  final String contactID;
  final Object object;
  const InteractionListTile({
    Key? key,
    required this.contactID,
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
      background: const DismissibleBackground(),
      onDismissed: (direction) {
        if (object is Interaction) {
          context
              .read(interactionsNotifierProvider)
              .deleteInteraction(interactionID: objectID);
        } else {
          // TODO remove contact from event
          context.read(eventsNotifierProvider).removeContactFromEvent(
              contactID: contactID, event: object as Event);
        }
      }, // TODO test
      child: ListTile(
        leading: Icon(icon),
        title: Text(description),
        subtitle: Text(getTimeagoFormatedDate(context, date)),
        onTap: object is Event
            ? () {
                AutoRouter.of(context)
                    .push(EventDetailsRoute(eventID: objectID));
              }
            : null,
      ),
    );
  }
}
