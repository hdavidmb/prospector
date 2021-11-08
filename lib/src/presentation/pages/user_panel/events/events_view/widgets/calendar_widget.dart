import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart' hide isSameDay;

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../helpers/date_formatters.dart';
import '../../events_constants.dart';
import '../logic/events_view_providers.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final viewProvider = watch(eventsViewProvider);
    final eventsProvider = watch(eventsNotifierProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: TableCalendar(
        firstDay: kFirstDate,
        lastDay: kLastDate,
        focusedDay: viewProvider.selectedDay,
        pageJumpingEnabled: true,
        availableGestures: AvailableGestures.horizontalSwipe,
        startingDayOfWeek:
            StartingDayOfWeek.values[viewProvider.startDayOfWeek],
        locale: Intl.getCurrentLocale(),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle:
                TextStyle(color: isDarkTheme ? Colors.white70 : Colors.black87),
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
            color: isSameDay(viewProvider.selectedDay, DateTime.now())
                ? Theme.of(context).primaryColor
                : isDarkTheme
                    ? Colors.white
                    : Colors.black87,
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        calendarFormat: viewProvider.isMonthFormat
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
          return isSameDay(viewProvider.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) =>
            context.read(eventsViewProvider).selectedDay = focusedDay,
        onPageChanged: (focusedDay) =>
            context.read(eventsViewProvider).selectedDay = focusedDay,
        eventLoader: (day) => eventsProvider.events
            .where((event) => isBetweenDays(
                date: day, startDate: event.startDate, endDate: event.endDate))
            .toList(),
      ),
    );
  }
}
