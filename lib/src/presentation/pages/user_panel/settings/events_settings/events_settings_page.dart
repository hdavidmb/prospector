import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/logic/events_view_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/theme/theme_providers.dart';

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
                  final Option selection =
                      await showWeekdaySelectionDialog(context: context);
                  selection.fold(
                    () => null,
                    (selectedDay) => context
                        .read(eventsViewProvider)
                        .startDayOfWeek = selectedDay as int,
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
                  final Option selection =
                      await showTimeFormatDialog(context: context);
                  selection.fold(
                    () => null,
                    (is24hours) => context
                        .read(themeNotifierProvider)
                        .is24hours = is24hours as bool,
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
