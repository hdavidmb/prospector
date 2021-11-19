import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../features/admob/application/ad_state.dart';
import '../../../../../../features/admob/application/ads_providers.dart';

class SettingsAdmobBanner extends ConsumerWidget {
  const SettingsAdmobBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool shouldShowAds = watch(showAds);
    final AdState bannerState = watch(adsProvider).settingsBannerState;
    return shouldShowAds && bannerState.isLoaded
        ? Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            width: 320.0,
            height: 80.0,
            child: AdWidget(ad: context.read(adsProvider).settingsBanner),
          )
        : const SizedBox();
  }
}
