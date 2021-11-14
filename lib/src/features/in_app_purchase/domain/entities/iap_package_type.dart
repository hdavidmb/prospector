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
}
