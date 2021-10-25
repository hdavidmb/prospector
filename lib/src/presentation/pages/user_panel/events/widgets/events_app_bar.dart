import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/logic/events_page_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EventsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context).events),
      leading: IconButton(
        icon: const Icon(Icons.today),
        onPressed: () =>
            context.read(eventsPageProvider).selectedDay = DateTime.now(),
      ),
      actions: [
        // TODO implement IconButton(
        //   onPressed: () {
        //     //TODO toggle between list view and calendar view
        //   },
        //   icon: const Icon(Icons.date_range), // Icons.calendar_view_day
        // ),
        IconButton(
          onPressed: () {
            //TODO navigate to event add edit page
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
