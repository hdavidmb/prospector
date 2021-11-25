import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../generated/l10n.dart';
import '../../features/events/domain/entites/event_entity.dart';

String getTimeagoFormatedDate(BuildContext context, DateTime date) {
  final Duration timeDifference = DateTime.now().difference(date);
  final Locale myLocale = Localizations.localeOf(context);
  final DateFormat dateFormat =
      DateFormat('dd MMM yyyy', myLocale.languageCode);

  if (timeDifference <= const Duration(days: 6)) {
    return timeago.format(date, locale: myLocale.languageCode);
  } else {
    return dateFormat.format(date);
  }
}

String localizedWeekday(int day) {
  final DateFormat dateFormatter =
      DateFormat(DateFormat.WEEKDAY, Intl.getCurrentLocale());
  return dateFormatter.format(DateTime(2020, 8, 10 + day));
}

//TODO: try implementing this functions as DateTime extension methods
String localizedMonthDay(DateTime date) {
  final DateFormat dateFormat = DateFormat.MMMMd(Intl.getCurrentLocale());
  return dateFormat.format(date);
}

String localizedMonthYear(DateTime date) {
  final DateFormat dateFormat = DateFormat.yMMMM(Intl.getCurrentLocale());
  return dateFormat.format(date);
}

int differenceInMonths(DateTime a, DateTime b) =>
    a.year * 12 + a.month - b.year * 12 - b.month;

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool isSameMonth(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month;

bool isBeforeDay(DateTime a, DateTime b) =>
    a.year <= b.year && a.month <= b.month && a.day <= b.day;

bool isAfterDay(DateTime a, DateTime b) =>
    a.year >= b.year && a.month >= b.month && a.day >= b.day;

/// Checks if [date] is the same day as [startDate] or [endDate] or in between.
bool isBetweenDays(
    {required DateTime date,
    required DateTime startDate,
    required DateTime endDate}) {
  final isAfter = isAfterDay(date, startDate);
  final isBefore = isBeforeDay(date, endDate);
  return isSameDay(date, startDate) ||
      isSameDay(date, endDate) ||
      (isAfter && isBefore);
}

String eventTileFormatedDate({
  required DateTime selectedDate,
  required Event event,
  required bool is24hours,
}) {
  final DateFormat dateFormat = is24hours
      ? DateFormat('HH:mm', Intl.getCurrentLocale())
      : DateFormat("hh:mm a", Intl.getCurrentLocale());
  final String formattedStartDate = dateFormat.format(event.startDate);
  final String formattedEndDate = dateFormat.format(event.endDate);
  if (event.type == 'reminder') {
    return formattedStartDate;
  } else if (event.allDay) {
    return AppLocalizations.current.allDay;
  } else if (isSameDay(event.startDate, event.endDate)) {
    return '$formattedStartDate - $formattedEndDate';
  } else if (isSameDay(selectedDate, event.startDate)) {
    return '${AppLocalizations.current.startsAt} $formattedStartDate';
  } else if (isSameDay(selectedDate, event.endDate)) {
    return '${AppLocalizations.current.endsAt} $formattedEndDate';
  } else {
    return AppLocalizations.current.allDay;
  }
}

String dateCellFormattedDate({required DateTime date}) {
  final DateFormat dateFormat = DateFormat.yMd(Intl.getCurrentLocale());
  return dateFormat.format(date);
}

String formattedTime({required bool is24hours, required DateTime date}) {
  final DateFormat dateFormat = is24hours
      ? DateFormat('H:mm', Intl.getCurrentLocale())
      : DateFormat("h:mm a", Intl.getCurrentLocale());
  return dateFormat.format(date);
}

String eventDetailsFormatedDate({
  required DateTime startDate,
  required DateTime endDate,
  required bool is24hours,
}) {
  if (isSameDay(startDate, endDate)) {
    final dateFormat = DateFormat.yMMMMd(Intl.getCurrentLocale());
    return '${dateFormat.format(startDate)}\n${formattedTime(is24hours: is24hours, date: startDate)} - ${formattedTime(is24hours: is24hours, date: endDate)}';
  } else {
    final DateFormat dateFormat = is24hours
        ? DateFormat.yMMMMd(Intl.getCurrentLocale()).add_Hm()
        : DateFormat.yMMMMd(Intl.getCurrentLocale()).add_jm();
    return '${dateFormat.format(startDate)} -\n${dateFormat.format(endDate)}';
  }
}

String eventNotificationFormattedDate(
    {required DateTime date, required bool is24hours}) {
  final DateFormat dateFormat = is24hours
      ? DateFormat.yMMMMd(Intl.getCurrentLocale()).add_Hm()
      : DateFormat.yMMMMd(Intl.getCurrentLocale()).add_jm();
  return dateFormat.format(date);
}
