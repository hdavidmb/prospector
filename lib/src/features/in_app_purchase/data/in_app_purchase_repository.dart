import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/connection/connection_checker.dart';
import '../domain/failures/iap_failure.dart';
import '../domain/i_in_app_purchase_repository.dart';

class InAppPurchaseRepository implements IInAppPurchaseRepository {
  final Purchases
      purchases; // TODO: create helper to be able to call static members with an instance of the helper
  InAppPurchaseRepository({
    required this.purchases,
  });

  @override
  Future<Either<IAPFailure, List<Package>>> getPackages() async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const IAPFailure.noConnection());
    try {
      final Offerings offerings = await Purchases.getOfferings();
      if (offerings.current?.availablePackages.isNotEmpty == true) {
        final List<Package> packages = offerings.current!.availablePackages;
        return right(packages);
      } else {
        return left(const IAPFailure.serverError());
      }
    } catch (e) {
      return left(const IAPFailure.serverError());
    }
  }

  @override
  Future<Either<IAPFailure, EntitlementInfo?>> logInPurchaser(
      {required String uid}) async {
    try {
      final LogInResult result = await Purchases.logIn(uid);
      return right(result.purchaserInfo.entitlements.all['premium']);
    } catch (e) {
      return left(const IAPFailure.serverError());
    }
  }

  @override
  Future<void> logOutPurchaser() async {
    final isAnonymus = await Purchases.isAnonymous;
    if (!isAnonymus) {
      try {
        await Purchases.logOut();
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<Either<IAPFailure, EntitlementInfo?>> purchasePackage(Package package,
      {String? oldSKU}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const IAPFailure.noConnection());
    try {
      final UpgradeInfo? upgradeInfo =
          oldSKU != null ? UpgradeInfo(oldSKU) : null;
      final PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(package, upgradeInfo: upgradeInfo);

      return right(purchaserInfo.entitlements.all['premium']);
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        return left(const IAPFailure.serverError());
      } else {
        return left(const IAPFailure.cancelledByUser());
      }
    }
  }

  @override
  Future<Either<IAPFailure, EntitlementInfo?>> restorePurchase() async {
    try {
      final PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      return right(restoredInfo.entitlements.all['premium']);
    } on PlatformException catch (_) {
      return left(const IAPFailure.serverError());
    }
  }
}
