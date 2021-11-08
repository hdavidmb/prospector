import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../core/dialogs.dart';
import '../../../../helpers/date_formatters.dart';
import '../../../../theme/theme_providers.dart';
import '../../events/events_view/logic/events_view_providers.dart';

class EventsSettingsPage extends StatelessWidget {
  const EventsSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const divider = Divider(height: 0.0, indent: 8.0);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).eventsSettings),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final bool is24hours = watch(themeNotifierProvider).is24hours;
          final int startDayOfWeek = watch(eventsViewProvider).startDayOfWeek;
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ListTile(
                onTap: () async {
                  final Option<int> selection =
                      await showWeekdaySelectionDialog(context: context);
                  selection.fold(
                    () => null,
                    (selectedDay) => context
                        .read(eventsViewProvider)
                        .startDayOfWeek = selectedDay,
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).weekStartsOn),
                    Text(
                      localizedWeekday(startDayOfWeek),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              divider,
              ListTile(
                onTap: () async {
                  final Option<bool> selection =
                      await showTimeFormatDialog(context: context);
                  selection.fold(
                    () => null,
                    (is24hours) => context
                        .read(themeNotifierProvider)
                        .is24hours = is24hours,
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).timeFormat),
                    Text(
                      '${is24hours ? 24 : 12} ${AppLocalizations.current.hours}',
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              divider,
            ],
          );
        },
      ),
    );
  }
}
