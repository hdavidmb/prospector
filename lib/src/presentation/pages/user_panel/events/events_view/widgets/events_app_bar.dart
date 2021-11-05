import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../routes/app_router.gr.dart';
import '../logic/events_view_providers.dart';

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
            context.read(eventsViewProvider).selectedDay = DateTime.now(),
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
            AutoRouter.of(context).push(EventAddEditRoute());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
