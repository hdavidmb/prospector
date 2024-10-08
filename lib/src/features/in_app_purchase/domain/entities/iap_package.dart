import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/package_wrapper.dart';

import 'iap_package_type.dart';

export 'iap_package_type.dart';

part 'iap_package.freezed.dart';

@freezed
class IAPPackage with _$IAPPackage {
  const factory IAPPackage({
    required IAPPackageType type,
    required double price,
    required String currencyCode,
    required String sku,
    required Package package,
  }) = _IAPPackage;
  const IAPPackage._();

  factory IAPPackage.fromPackage(Package platformPackage) {
    final IAPPackageType pType = IAPPackageType.values.firstWhere(
        (type) =>
            type.toString().substring(3) ==
            platformPackage.packageType.toString(),
        orElse: () => IAPPackageType.monthly);
    return IAPPackage(
      type: pType,
      price: platformPackage.product.price,
      currencyCode: platformPackage.product.currencyCode,
      sku: platformPackage.product.identifier,
      package: platformPackage,
    );
  }
}
