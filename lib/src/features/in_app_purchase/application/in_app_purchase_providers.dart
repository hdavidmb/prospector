import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/in_app_purchase/application/in_app_purchase_notifier.dart';
import 'package:prospector/src/features/in_app_purchase/data/in_app_purchase_repository.dart';
import 'package:prospector/src/features/in_app_purchase/domain/in_app_purchase_use_cases.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
