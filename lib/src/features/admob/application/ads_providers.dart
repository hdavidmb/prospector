import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/shared_prefs/shared_prefs_provider.dart';
import '../../user/application/user_info_providers.dart';
import 'ads_notifier.dart';

final adsProvider = ChangeNotifierProvider<AdsNotifier>((ref) {
  final _prefs = ref.watch(userSharedPrefsProvider);
  return AdsNotifier(prefs: _prefs);
});

final showAds = Provider<bool>((ref) {
  final bool isPremiumUser = ref.watch(userInfoNotifierProvider).isPremiumUser;
  final bool isRewarded = ref.watch(adsProvider).isRewarded;
  return !isPremiumUser && !isRewarded;
});
