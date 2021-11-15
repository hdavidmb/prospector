import 'package:prospector/generated/l10n.dart';

enum IAPPackageType {
  monthly,
  threeMonth,
  sixMonth,
  annual,
}

extension IAPPackageTypeX on IAPPackageType {
  int get months {
    switch (this) {
      case IAPPackageType.monthly:
        return 1;
      case IAPPackageType.threeMonth:
        return 3;
      case IAPPackageType.sixMonth:
        return 6;
      case IAPPackageType.annual:
        return 12;
    }
  }

  String get text {
    switch (this) {
      case IAPPackageType.monthly:
        return AppLocalizations.current.oneMonth;
      case IAPPackageType.threeMonth:
        return AppLocalizations.current.threeMonths;
      case IAPPackageType.sixMonth:
        return AppLocalizations.current.sixMonths;
      case IAPPackageType.annual:
        return AppLocalizations.current.oneYear;
    }
  }
}
