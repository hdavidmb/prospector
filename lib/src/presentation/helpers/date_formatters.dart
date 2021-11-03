import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

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

String getAlertText(
    //TODO test
    {required DateTime startDate,
    required DateTime? notification}) {
  String alertString = AppLocalizations.current.none;
  if (notification != null) {
    final Duration duration = startDate.difference(notification);
    if (duration.inMinutes == 0) {
      alertString = AppLocalizations.current.atEventTime;
    } else if (duration.inMinutes <= 30) {
      alertString =
          '${duration.inMinutes} ${AppLocalizations.current.minutesBefore}';
    } else if (duration.inHours == 1) {
      alertString = '1 ${AppLocalizations.current.hourBefore}';
    } else if (duration.inHours == 2) {
      alertString = '2 ${AppLocalizations.current.hoursBefore}';
    } else if (duration.inDays == 1) {
      alertString = '1 ${AppLocalizations.current.dayBefore}';
    } else if (duration.inDays == 2) {
      alertString = '2 ${AppLocalizations.current.daysBefore}';
    } else if (duration.inDays == 7) {
      alertString = '1 ${AppLocalizations.current.weekBefore}';
    }
  }
  return alertString;
}
