import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/in_app_purchase/application/in_app_purchase_providers.dart';
import '../../../../../features/user/application/user_info_providers.dart';

class MembershipNotifier extends ChangeNotifier {
  final Reader read;
  MembershipNotifier({
    required this.read,
  }) {
    final String? userSKU =
        read(userInfoNotifierProvider).user?.subscriptionSKU;
    final bool isPremium = read(userInfoNotifierProvider).isPremiumUser;
    final String packageSKU = read(inAppPurchaseNotifier).packages[1].sku;
    if (isPremium && userSKU == packageSKU) _selectedIndex = 2;
  }

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int getPackageSavings(
      {required double price,
      required int months,
      required double basePrice,
      required int baseMonths}) {
    final double fullPrice = basePrice / baseMonths * months;
    final double savings = (fullPrice - price) / fullPrice * 100;
    return savings.round();
  }
}
