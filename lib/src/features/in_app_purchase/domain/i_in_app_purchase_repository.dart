import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'failures/iap_failure.dart';

abstract class IInAppPurchaseRepository {
  Future<Either<IAPFailure, EntitlementInfo?>> logInPurchaser(
      {required String uid});
  Future<void> logOutPurchaser();

  Future<Either<IAPFailure, List<Package>>> getPackages();
  Future<Either<IAPFailure, EntitlementInfo?>> purchasePackage(Package package,
      {String? oldSKU});

  Future<Either<IAPFailure, EntitlementInfo?>> restorePurchase();
}
