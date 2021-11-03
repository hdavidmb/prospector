import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/guests_selection/widgets/guests_input.dart';

class GuestsSelectionPage extends StatelessWidget {
  final Event? event;
  const GuestsSelectionPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> selectedGuests = [];
    if (event?.guests != null) {
      selectedGuests.addAll(event!.guests!);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).selectGuests),
          actions: [
            TextButton(
              onPressed: () {
                AutoRouter.of(context).pop(selectedGuests);
              },
              child: Text(
                AppLocalizations.of(context).save,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GuestsInput(
            selectedGuests: selectedGuests,
            autoFocus: true,
            onSelect: (String guest) => selectedGuests.add(guest),
            onDelete: (String guest) => selectedGuests.remove(guest),
          ),
        ),
      ),
    );
  }
}
