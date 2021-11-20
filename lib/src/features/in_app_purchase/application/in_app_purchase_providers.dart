import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../data/in_app_purchase_repository.dart';
import '../domain/in_app_purchase_use_cases.dart';
import 'in_app_purchase_notifier.dart';

final purchasesInstance = Provider<Purchases>((ref) {
  return Purchases();
});

final inAppPurchaseRepository = Provider<InAppPurchaseRepository>((ref) {
  final _purchases = ref.watch(purchasesInstance);
  return InAppPurchaseRepository(purchases: _purchases);
});

final inAppPurchaseUseCases = Provider<InAppPurchaseUseCases>((ref) {
  final _inAppPurchaseRepository = ref.watch(inAppPurchaseRepository);
  return InAppPurchaseUseCases(
      inAppPurchaseRepository: _inAppPurchaseRepository);
});

final inAppPurchaseNotifier =
    ChangeNotifierProvider<InAppPurchaseNotifier>((ref) {
  final _inAppPurchaseUseCases = ref.watch(inAppPurchaseUseCases);
  return InAppPurchaseNotifier(
      inAppPurchaseUseCases: _inAppPurchaseUseCases, read: ref.read);
});
