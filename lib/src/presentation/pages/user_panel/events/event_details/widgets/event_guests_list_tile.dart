import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/event_details/logic/event_details_providers.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../../features/events/domain/entity/event_entity.dart';
import '../../../../../routes/app_router.gr.dart';
import '../../../contacts/contact_add_edit/widgets/contact_image.dart';

class EventGuestsListTile extends StatelessWidget {
  const EventGuestsListTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final bool hasGuests = event.guests != null && event.guests!.isNotEmpty;
    return ListTile(
      // trailing: const Icon(Icons.navigate_next, color: Colors.grey),
      title: Padding(
        padding: hasGuests
            ? const EdgeInsets.only(
                top: 15.0,
                bottom: 8.0,
              )
            : EdgeInsets.zero,
        child: Row(
          children: <Widget>[
            Text(AppLocalizations.of(context).guests),
            Expanded(child: Container()),
            Text(
              '${event.guests?.length ?? 0}',
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(width: 12.0),
            const Icon(Icons.navigate_next, color: Colors.grey),
          ],
        ),
      ),
      subtitle: hasGuests
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: 4.0,
                runSpacing: 8.0,
                children: event.guests!.map(
                  (guest) {
                    final Contact contact = context
                        .read(contactsNotifierProvider)
                        .contacts
                        .firstWhere((listContact) => listContact.id == guest);
                    return Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      avatar:
                          ContactImage(size: 20.0, contactPhoto: contact.photo),
                      label: Text(
                        contact.name,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    );
                  },
                ).toList(),
              ),
            )
          : null,
      onTap: () async {
        final List<String>? selectedGuests = await AutoRouter.of(context)
            .push(GuestsSelectionRoute(event: event)) as List<String>?;
        Future.delayed(
          Duration.zero,
          () => context
              .read(eventDetailsPageProvider)
              .guestsTilePressed(event: event, selectedGuests: selectedGuests),
        );
      },
    );
  }
}
