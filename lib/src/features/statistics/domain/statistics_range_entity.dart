import 'package:prospector/generated/l10n.dart';

enum StatisticsRange {
  thisMonth,
  threeMonths,
  sixMonths,
  twelveMonths,
  thisYear,
  lifetime,
}

extension StatisticsRangeX on StatisticsRange {
  String get text {
    switch (this) {
      case StatisticsRange.thisMonth:
        return '${AppLocalizations.current.thisText} ${AppLocalizations.current.month.toLowerCase()}';
      case StatisticsRange.threeMonths:
        return '${AppLocalizations.current.last} ${AppLocalizations.current.threeMonths.toLowerCase()}';
      case StatisticsRange.sixMonths:
        return '${AppLocalizations.current.last} ${AppLocalizations.current.sixMonths.toLowerCase()}';
      case StatisticsRange.twelveMonths:
        return '${AppLocalizations.current.last} ${AppLocalizations.current.twelveMonths.toLowerCase()}';
      case StatisticsRange.thisYear:
        return '${AppLocalizations.current.thisText} ${AppLocalizations.current.year.toLowerCase()}';
      case StatisticsRange.lifetime:
        return AppLocalizations.current.lifetime;
    }
  }
}
