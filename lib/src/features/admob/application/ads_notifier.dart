import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_state.dart';

class AdsNotifier extends ChangeNotifier {
  AdsNotifier() {
    contactsBanner = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/2934735716', //TODO: PrivateKeys.getBannerAdUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => contactsBannerState = const AdState.loaded(),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          contactsBannerState = const AdState.error();
        },
      ), //TODO: implement listener,
    );
  }
  AdState contactsBannerState = const AdState.initial();

  late BannerAd contactsBanner;

  void loadAds() {
    //TODO: use some ad loading state to prevent it from loading multiple times
    contactsBanner.load();
    contactsBannerState = const AdState.loading();
  }
}
