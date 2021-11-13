import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/package_wrapper.dart';

import 'failures/iap_failure.dart';

abstract class IInAppPurchaseRepository {
  Future<void> logInPurchaser({required String uid});
  Future<void> logOutPurchaser();

  Future<Either<IAPFailure, List<Package>>> getPackages();
}
