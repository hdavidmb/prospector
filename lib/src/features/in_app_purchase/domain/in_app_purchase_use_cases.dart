import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/in_app_purchase/domain/entities/iap_package.dart';

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

  Future<Either<IAPFailure, List<IAPPackage>>> getPackages() async {
    final result = await inAppPurchaseRepository.getPackages();
    return result.fold(
      (failure) => left(failure),
      (packagesList) => right(packagesList
          .map((listPackage) => IAPPackage.fromPackage(listPackage))
          .toList()),
    );
  }
}
