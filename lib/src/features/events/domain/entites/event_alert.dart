import '../../../../../generated/l10n.dart';

enum EventAlert {
  none,
  atEventTime,
  fiveMinutes,
  fifteenMinutes,
  thirtyMinutes,
  oneHour,
  twoHours,
  oneDay,
  twoDays,
  oneWeek,
}

extension EventAlertX on EventAlert {
  String get text {
    switch (this) {
      case EventAlert.none:
        return AppLocalizations.current.none;
      case EventAlert.atEventTime:
        return AppLocalizations.current.atEventTime;
      case EventAlert.fiveMinutes:
        return '5 ${AppLocalizations.current.minutesBefore}';
      case EventAlert.fifteenMinutes:
        return '15 ${AppLocalizations.current.minutesBefore}';
      case EventAlert.thirtyMinutes:
        return '30 ${AppLocalizations.current.minutesBefore}';
      case EventAlert.oneHour:
        return '1 ${AppLocalizations.current.hourBefore}';
      case EventAlert.twoHours:
        return '2 ${AppLocalizations.current.hoursBefore}';
      case EventAlert.oneDay:
        return '1 ${AppLocalizations.current.dayBefore}';
      case EventAlert.twoDays:
        return '2 ${AppLocalizations.current.daysBefore}';
      case EventAlert.oneWeek:
        return '1 ${AppLocalizations.current.weekBefore}';
      default:
        return AppLocalizations.current.none;
    }
  }

  Duration? get duration {
    switch (this) {
      case EventAlert.none:
        return null;
      case EventAlert.atEventTime:
        return Duration.zero;
      case EventAlert.fiveMinutes:
        return const Duration(minutes: 5);
      case EventAlert.fifteenMinutes:
        return const Duration(minutes: 15);
      case EventAlert.thirtyMinutes:
        return const Duration(minutes: 30);
      case EventAlert.oneHour:
        return const Duration(hours: 1);
      case EventAlert.twoHours:
        return const Duration(hours: 2);
      case EventAlert.oneDay:
        return const Duration(days: 1);
      case EventAlert.twoDays:
        return const Duration(days: 2);
      case EventAlert.oneWeek:
        return const Duration(days: 7);
      default:
        return null;
    }
  }
}
