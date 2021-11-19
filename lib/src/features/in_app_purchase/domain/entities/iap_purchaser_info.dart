import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/entitlement_info_wrapper.dart';

part 'iap_purchaser_info.freezed.dart';

@freezed
class IAPPurchaserInfo with _$IAPPurchaserInfo {
  const factory IAPPurchaserInfo({
    String? packageSKU,
    required bool isActive,
    required DateTime expiryDate,
  }) = _IAPPurchaserInfo;

  const IAPPurchaserInfo._();

  factory IAPPurchaserInfo.fromPurchaserInfo(EntitlementInfo? entitlementInfo) {
    return IAPPurchaserInfo(
      packageSKU: entitlementInfo?.productIdentifier,
      isActive: entitlementInfo?.isActive == true,
      expiryDate: DateTime.tryParse(entitlementInfo?.expirationDate ?? '') ??
          DateTime.now().subtract(const Duration(days: 5)),
    );
  }
}
