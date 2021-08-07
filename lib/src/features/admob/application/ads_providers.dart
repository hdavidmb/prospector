import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/application/user_info_providers.dart';
import 'ads_notifier.dart';

final adsProvider = ChangeNotifierProvider<AdsNotifier>((ref) {
  return AdsNotifier();
});

final showAds = Provider<bool>((ref) {
  final bool isPremiumUser = ref.watch(userInfoNotifierProvider).isPremiumUser;
  return !isPremiumUser; //TODO: complete with isRewarded from ads notifier
});
