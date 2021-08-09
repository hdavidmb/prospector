import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_state.dart';

class AdsNotifier extends ChangeNotifier {
  AdsNotifier() {
    const String _adUnitId =
        'ca-app-pub-3940256099942544/2934735716'; //TODO: PrivateKeys.getBannerAdUnitId();
    contactsBanner = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          contactsBannerState = const AdState.loaded();
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          contactsBannerState = const AdState.error();
          notifyListeners();
        },
      ),
    );

    settingsBanner = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          settingsBannerState = const AdState.loaded();
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          settingsBannerState = const AdState.error();
          notifyListeners();
        },
      ),
    );
  }

  AdState contactsBannerState = const AdState.initial();
  AdState settingsBannerState = const AdState.initial();
  AdState rewardedVideoState = const AdState.initial();

  late BannerAd contactsBanner;
  late BannerAd settingsBanner;

  void loadAds() {
    bool notify = false;
    if (contactsBannerState.isInitial) {
      contactsBannerState = const AdState.loading();
      contactsBanner.load();
      notify = true;
    }
    if (settingsBannerState.isInitial) {
      settingsBannerState = const AdState.loading();
      settingsBanner.load();
      notify = true;
    }
    if (rewardedVideoState.isInitial) {
      rewardedVideoState = const AdState.loading();
      Future.delayed(Duration(seconds: 5), () {
        rewardedVideoState = const AdState.loaded();
        notifyListeners();
      });
      notify = true;
      //TODO implement properlly
    }
    if (notify) notifyListeners();
  }
}
