import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../generated/l10n.dart';
import '../logic/events_view_providers.dart';

class EventsCalendarView extends StatelessWidget {
  const EventsCalendarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Consumer(builder: (context, watch, child) {
          final provider = watch(eventsViewProvider);
          return TableCalendar(
            firstDay: DateTime(2015),
            lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
            focusedDay: provider.selectedDay,
            pageJumpingEnabled: true,
            availableGestures: AvailableGestures.horizontalSwipe,
            startingDayOfWeek: StartingDayOfWeek
                .values[6], //TODO get from prefs and set it on event settings
            locale: Intl.getCurrentLocale(), //TODO test
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: isDarkTheme ? Colors.white70 : Colors.black87),
                weekendStyle: TextStyle(
                    color: isDarkTheme ? Colors.white38 : Colors.black54)),
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ), //
              todayDecoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              selectedDecoration: BoxDecoration(
                color: isSameDay(provider.selectedDay, DateTime.now())
                    ? Theme.of(context).primaryColor
                    : Colors.black87,
                shape: BoxShape.circle,
              ),
              //TODO set markers decoration
            ),
            calendarFormat: provider.isMonthFormat
                ? CalendarFormat.month
                : CalendarFormat.week,
            availableCalendarFormats: {
              CalendarFormat.month: AppLocalizations.of(context).month,
              CalendarFormat.week: AppLocalizations.of(context).week
            },
            onFormatChanged: (format) {
              context.read(eventsViewProvider).isMonthFormat =
                  !context.read(eventsViewProvider).isMonthFormat;
            },
            selectedDayPredicate: (day) {
              return isSameDay(provider.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) =>
                context.read(eventsViewProvider).selectedDay = focusedDay,
            onPageChanged: (focusedDay) =>
                context.read(eventsViewProvider).selectedDay = focusedDay,
            // events: _events,
          );
        })
      ],
    );
  }
}
