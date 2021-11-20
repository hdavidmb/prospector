import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_purchaser_info.dart';

import 'failures/iap_failure.dart';
import 'i_in_app_purchase_repository.dart';

class InAppPurchaseUseCases {
  final IInAppPurchaseRepository inAppPurchaseRepository;
  InAppPurchaseUseCases({
    required this.inAppPurchaseRepository,
  });

  Future<Either<IAPFailure, IAPPurchaserInfo>> logInPurchaser(
      {required String uid}) async {
    final result = await inAppPurchaseRepository.logInPurchaser(uid: uid);
    return result.fold(
      (failure) => left(failure),
      (entitlementInfo) =>
          right(IAPPurchaserInfo.fromPurchaserInfo(entitlementInfo)),
    );
  }

  Future<void> logOutPurchaser() => inAppPurchaseRepository.logOutPurchaser();

  Future<Either<IAPFailure, List<IAPPackage>>> getPackages() async {
    final result = await inAppPurchaseRepository.getPackages();
    return result.fold(
      (failure) => left(failure),
      (packagesList) => right(packagesList
          .map((listPackage) => IAPPackage.fromPackage(listPackage))
          .toList()),
    );
  }

  Future<Either<IAPFailure, IAPPurchaserInfo>> purchasePackage(
      IAPPackage iapPackage,
      {String? oldSKU}) async {
    final result = await inAppPurchaseRepository.purchasePackage(
      iapPackage.package,
      oldSKU: oldSKU,
    );
    return result.fold(
      (failure) => left(failure),
      (entitlementInfo) =>
          right(IAPPurchaserInfo.fromPurchaserInfo(entitlementInfo)),
    );
  }

  Future<Either<IAPFailure, IAPPurchaserInfo>> restorePurchase() async {
    final result = await inAppPurchaseRepository.restorePurchase();
    return result.fold(
      (failure) => left(failure),
      (entitlementInfo) =>
          right(IAPPurchaserInfo.fromPurchaserInfo(entitlementInfo)),
    );
  }
}
