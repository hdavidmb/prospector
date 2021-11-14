import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package_type.dart';
import 'package:purchases_flutter/package_wrapper.dart';

part 'iap_package.freezed.dart';

@freezed
class IAPPackage with _$IAPPackage {
  const factory IAPPackage({
    required IAPPackageType type,
    required double price,
    required String priceString,
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
      priceString: platformPackage.product.priceString,
      package: platformPackage,
    );
  }
}
