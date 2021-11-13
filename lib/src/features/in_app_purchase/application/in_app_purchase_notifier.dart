import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/package_wrapper.dart';

import '../../user/application/user_info_providers.dart';
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
  List<Package> _packages = [];

  FetchState get packagesState => _packagesState;
  FetchState get loginState => _loginState;
  List<Package> get packages => _packages;

  FetchState get payWallState {
    if (_loginState.isReady && _packagesState.isReady) {
      return const FetchState.ready();
    } else if (_loginState.isError || _packagesState.isError) {
      return const FetchState.error();
    } else {
      return const FetchState.fetching();
    }
  }

  Future<void> logInPurchaser() async {
    if (_loginState.isInitial) {
      _loginState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        // TODO: check for some return to update user info subscription
        await inAppPurchaseUseCases.logInPurchaser(uid: uid);
        _loginState = const FetchState.ready();
      }
      notifyListeners();
    }
  }

  Future<void> logOutPurchaser() async {
    _loginState = const FetchState.fetching();
    await inAppPurchaseUseCases.logOutPurchaser();
    _loginState = const FetchState.initial();
    notifyListeners();
  }

  Future<void> getPackages() async {
    if (_packagesState.isInitial) {
      _packagesState = const FetchState.fetching();
      final getResult = await inAppPurchaseUseCases.getPackages();
      getResult.fold(
        (failure) => _packagesState = const FetchState.error(),
        (packagesList) {
          _packages = packagesList;
          _packagesState = const FetchState.ready();
        },
      );
    } else {
      _packagesState = const FetchState.error();
    }
    notifyListeners();
  }
}
