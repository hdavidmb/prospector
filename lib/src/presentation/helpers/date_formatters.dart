import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String getContactFormatedDate( BuildContext context, DateTime date) {
    final Duration timeDifference = DateTime.now().difference(date);
    final Locale myLocale = Localizations.localeOf(context);
    final DateFormat dateFormat = DateFormat('dd MMM yyyy', myLocale.languageCode);

    if (timeDifference <= const Duration(days: 6)) {
      return timeago.format(date, locale: myLocale.languageCode);
    } else {
      return dateFormat.format(date);
    }
  }