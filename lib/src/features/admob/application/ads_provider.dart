import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/admob/application/ads_notifier.dart';

final adsProvider = ChangeNotifierProvider<AdsNotifier>((ref) {
  return AdsNotifier();
});
