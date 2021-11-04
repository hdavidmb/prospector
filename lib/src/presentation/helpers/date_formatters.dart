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

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Checks if [date] is the same day as [startDate] or [endDate] or in between.
bool isBetweenDays(
        {required DateTime date,
        required DateTime startDate,
        required DateTime endDate}) =>
    isSameDay(date, startDate) ||
    isSameDay(date, endDate) ||
    (date.isAfter(startDate) && date.isBefore(endDate));

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
    return AppLocalizations.current.allDay; //TODO test
  } else if (isSameDay(event.startDate, event.endDate)) {
    return '$formattedStartDate - $formattedEndDate';
  } else if (isSameDay(selectedDate, event.startDate)) {
    return '${AppLocalizations.current.startsAt} $formattedStartDate'; //TODO test
  } else if (isSameDay(selectedDate, event.endDate)) {
    return '${AppLocalizations.current.endsAt} $formattedEndDate'; //TODO test
  } else {
    return AppLocalizations.current.allDay; //TODO test
  }
}

String eventDetailsFormatedDate({
  required DateTime startDate,
  required DateTime endDate,
  required bool is24hours,
}) {
  late DateFormat dateFormat;

  if (isSameDay(startDate, endDate)) {
    dateFormat = is24hours
        ? DateFormat('HH:mm', Intl.getCurrentLocale())
        : DateFormat("hh:mm a", Intl.getCurrentLocale());
  } else {
    dateFormat = is24hours
        ? DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).add_Hm()
        : DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).add_jm(); //TODO test
  }

  return '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';
}
