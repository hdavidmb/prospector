import 'package:flutter/material.dart';

import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/guests_selection/widgets/guests_input.dart';

class GuestsSelectionPage extends StatelessWidget {
  final Event? event;
  const GuestsSelectionPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> selectedGuests = event?.guests ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Select guests'), // TODO localize
        actions: [
          TextButton(
            onPressed: () {
              //TODO update event guests
            },
            child: Text(
              AppLocalizations.of(context).save,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: GuestsInput(
        selectedGuests: selectedGuests,
        onSelect: (String guest) => selectedGuests.add(guest),
        onDelete: (String guest) => selectedGuests.remove(guest),
      ),
    );
  }
}
