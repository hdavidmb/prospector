import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/package_wrapper.dart';

import 'failures/iap_failure.dart';
import 'i_in_app_purchase_repository.dart';

class InAppPurchaseUseCases {
  final IInAppPurchaseRepository inAppPurchaseRepository;
  InAppPurchaseUseCases({
    required this.inAppPurchaseRepository,
  });

  Future<void> logInPurchaser({required String uid}) =>
      inAppPurchaseRepository.logInPurchaser(uid: uid);

  Future<void> logOutPurchaser() => inAppPurchaseRepository.logOutPurchaser();

  Future<Either<IAPFailure, List<Package>>> getPackages() =>
      inAppPurchaseRepository.getPackages();
}
