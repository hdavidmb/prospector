import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/analytics/firebase_analytics_providers.dart';

import '../../../presentation/pages/user_panel/membership/logic/membership_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entities/iap_package.dart';
import '../domain/entities/iap_purchaser_info.dart';
import '../domain/failures/iap_failure.dart';
import '../domain/in_app_purchase_use_cases.dart';
import 'fetch_state.dart';

class InAppPurchaseNotifier extends ChangeNotifier {
  final InAppPurchaseUseCases inAppPurchaseUseCases;
  final Reader read;
  InAppPurchaseNotifier({
    required this.inAppPurchaseUseCases,
    required this.read,
  });

  FetchState _packagesState = const FetchState.initial();
  FetchState _loginState = const FetchState.initial();
  FetchState _purchaseState = const FetchState.initial();
  FetchState _restoreState = const FetchState.initial();
  Option<IAPFailure> _purchaseFailure = none();
  bool _hasPurchasedBefore = false;
  bool _packageRestored = false;
  List<IAPPackage> _packages = [];

  FetchState get packagesState => _packagesState;
  FetchState get loginState => _loginState;
  FetchState get purchaseState => _purchaseState;
  FetchState get restoreState => _restoreState;
  Option<IAPFailure> get purchaseFailure => _purchaseFailure;
  bool get hasPurchasedBefore => _hasPurchasedBefore;
  bool get packageRestored => _packageRestored;
  List<IAPPackage> get packages => _packages;

  void reset() {
    _packagesState = const FetchState.initial();
    _loginState = const FetchState.initial();
    _purchaseState = const FetchState.initial();
    _restoreState = const FetchState.initial();
    _hasPurchasedBefore = false;
    _purchaseFailure = none();
  }

  FetchState get iapState {
    if (_loginState.isReady && _packagesState.isReady) {
      return const FetchState.ready();
    } else if (_loginState.isError || _packagesState.isError) {
      return const FetchState.error();
    } else if (_loginState.isFetching || _packagesState.isFetching) {
      return const FetchState.fetching();
    } else {
      return const FetchState.initial();
    }
  }

  Future<void> logInPurchaser() async {
    if (_loginState.isInitial || _loginState.isError) {
      _loginState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final result = await inAppPurchaseUseCases.logInPurchaser(uid: uid);
        result.fold(
          (failure) => _loginState = const FetchState.error(),
          (iapPurchaserInfo) {
            _loginState = const FetchState.ready();
            _hasPurchasedBefore = iapPurchaserInfo.packageSKU != null;
            _compareAndUpdateUserSubscription(
                iapPurchaserInfo: iapPurchaserInfo);
          },
        );
      }
      notifyListeners();
    }
  }

  Future<void> logOutPurchaser() async {
    _loginState = const FetchState.fetching();
    await inAppPurchaseUseCases.logOutPurchaser();
    _loginState = const FetchState.initial();
    _hasPurchasedBefore = false;
    notifyListeners();
  }

  Future<void> getPackages() async {
    if (_packagesState.isInitial || _packagesState.isError) {
      _packagesState = const FetchState.fetching();
      final getResult = await inAppPurchaseUseCases.getPackages();
      getResult.fold(
        (failure) => _packagesState = const FetchState.error(),
        (packagesList) {
          _packages = packagesList;
          _packagesState = const FetchState.ready();
        },
      );
      notifyListeners();
    }
  }

  Future<void> purchasePackage({required int selectedIndex}) async {
    if (!_purchaseState.isFetching) {
      _purchaseState = const FetchState.fetching();
      notifyListeners();
      final bool isPremium = read(userInfoNotifierProvider).isPremiumUser;
      final String? oldSKU = isPremium
          ? read(userInfoNotifierProvider).user?.subscriptionSKU
          : null;
      final result = await inAppPurchaseUseCases
          .purchasePackage(_packages[selectedIndex], oldSKU: oldSKU);
      result.fold(
        (failure) {
          read(firebaseAnalyticsServiceProvider).logPurchaseFailed(
              failureString: failure.toString(),
              packageSKU: _packages[selectedIndex].sku);
          _purchaseFailure = some(failure);
          _purchaseState = const FetchState.error();
        },
        (iapPurchaserInfo) {
          _purchaseFailure = none();
          _purchaseState = const FetchState.ready();

          read(firebaseAnalyticsServiceProvider)
              .logPurchaseSuccessful(packageSKU: _packages[selectedIndex].sku);
          read(membershipNotifierProvider).selectedIndex =
              selectedIndex == _packages.length - 1 ? 1 : selectedIndex + 1;
          read(userInfoNotifierProvider).updateUserSubscription(
            isPremium: iapPurchaserInfo.isActive,
            subscriptionSKU: iapPurchaserInfo.packageSKU,
            expiryDate: iapPurchaserInfo.expiryDate,
          );
        },
      );
      notifyListeners();
    }
  }

  Future<void> restorePurchase() async {
    if (!_restoreState.isFetching) {
      _restoreState = const FetchState.fetching();
      notifyListeners();
      final result = await inAppPurchaseUseCases.restorePurchase();
      result.fold(
        (failure) {
          _purchaseFailure = some(failure);
          _restoreState = const FetchState.error();
        },
        (iapPurchaserInfo) {
          _purchaseFailure = none();
          _restoreState = const FetchState.ready();
          _packageRestored = _compareAndUpdateUserSubscription(
              iapPurchaserInfo: iapPurchaserInfo);
        },
      );
      notifyListeners();
    }
  }

  bool _compareAndUpdateUserSubscription(
      {required IAPPurchaserInfo iapPurchaserInfo}) {
    final bool isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (!isPremium && !iapPurchaserInfo.isActive) return false;
    if (isPremium && iapPurchaserInfo.isActive) {
      final userInfo = read(userInfoNotifierProvider).user;
      if (userInfo?.expiryDate.isAfter(DateTime.now()) ?? false) return false;
    }
    read(userInfoNotifierProvider).updateUserSubscription(
      isPremium: iapPurchaserInfo.isActive,
      subscriptionSKU: iapPurchaserInfo.packageSKU,
      expiryDate: iapPurchaserInfo.expiryDate,
    );
    return true;
  }
}
