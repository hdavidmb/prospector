import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/connection/connection_checker.dart';
import '../domain/failures/iap_failure.dart';
import '../domain/i_in_app_purchase_repository.dart';

class InAppPurchaseRepository implements IInAppPurchaseRepository {
  final Purchases purchases;
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
        // Display packages for sale
        final List<Package> packages = offerings.current!.availablePackages;
        //TODO TEST
        print('************** PURCHASE PACKAGES **************');
        print(packages);
        print(packages.first.packageType);
        return right(packages);
      } else {
        return left(const IAPFailure.serverError());
      }
    } catch (e) {
      return left(const IAPFailure.serverError());
    }
  }

  @override
  Future<void> logInPurchaser({required String uid}) async {
    try {
      final LogInResult result = await Purchases.logIn(uid);
      print('************** PURCHASE LOGIN RESULT **************');
      print(result.purchaserInfo); //TODO: test
    } catch (e) {
      //TODO: handle errors
      print(e);
    }
  }

  @override
  Future<void> logOutPurchaser() async {
    try {
      await Purchases.logOut();
    } catch (e) {
      //TODO: handle errors
      print(e);
    }
  }
}
