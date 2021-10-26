import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

/// Checks if [date] is the same day as [startDate] or [endDate] or in between.
bool isBetweenDays(
    {required DateTime date,
    required DateTime startDate,
    required DateTime endDate}) {
  return (date.year == startDate.year &&
          date.month == startDate.month &&
          date.day == startDate.day) ||
      (date.year == endDate.year &&
          date.month == endDate.month &&
          date.day == endDate.day) ||
      (date.isAfter(startDate) && date.isBefore(endDate));
}
