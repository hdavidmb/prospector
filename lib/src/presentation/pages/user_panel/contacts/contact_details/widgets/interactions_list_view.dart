import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
import '../../../../../../features/interactions/application/interactions_providers.dart';
import '../../../../../../features/interactions/domain/entity/interaction_entity.dart';

class InteractionsListView extends ConsumerWidget {
  final String contactID;
  const InteractionsListView({
    required this.contactID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<Interaction> interactions = watch(interactionsNotifierProvider)
        .interactions
        .where((interaction) => interaction.contact == contactID)
        .toList();
    return ListView.separated(
      itemCount: interactions.length,
      itemBuilder: (context, index) =>
          InteractionListTile(interaction: interactions[index]),
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        indent: 60.0,
      ),
    );
  }
}

class InteractionListTile extends StatelessWidget {
  final Interaction interaction;
  const InteractionListTile({
    Key? key,
    required this.interaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(interaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => context
          .read(interactionsNotifierProvider)
          .deleteInteraction(interactionID: interaction.id),
      child: ListTile(
        leading: Icon(interaction.type == 'user'
            ? Icons.fiber_manual_record
            : interaction.type == 'event'
                ? Icons.event
                : Icons.swap_horiz),
        title: Text(interaction.description),
        subtitle: Text(getTimeagoFormatedDate(context, interaction.created)),
        onTap: interaction.type == 'event'
            ? () {
                //TODO navigate to event details
              }
            : null,
      ),
    );
  }
}
