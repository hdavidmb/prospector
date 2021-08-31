import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prospector/src/core/private/private_keys.dart';
import 'ad_state.dart';

class AdsNotifier extends ChangeNotifier {
  AdsNotifier() {
    final String _adUnitId = Platform.isIOS
        ? 'ca-app-pub-3940256099942544/2934735716'
        : 'ca-app-pub-3940256099942544/6300978111'; //TODO: PrivateKeys.getBannerAdUnitId();
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
  RewardedAd? rewardedAd;
  final int rewardMinutes = 20;

  void loadAds() {
    if (contactsBannerState.isInitial) {
      contactsBannerState = const AdState.loading();
      contactsBanner.load();
    }
    if (settingsBannerState.isInitial) {
      settingsBannerState = const AdState.loading();
      settingsBanner.load();
    }
    if (rewardedVideoState.isInitial) {
      loadRewardedAd();
    }
  }

  void showRewaradedVideo() {
    if (rewardedVideoState.isLoaded && rewardedAd != null) {
      rewardedAd!.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
        // TODO: Reward the user for watching an ad.
        print('user got rewarded');
      });
    }
  }

  void emitAdErrorState() {
    rewardedVideoState = const AdState.error();
    notifyListeners();
  }

  void loadRewardedAd({bool fromDismissed = false}) {
    rewardedVideoState = const AdState.loading();
    if (fromDismissed) notifyListeners();
    RewardedAd.load(
      adUnitId: Platform.isIOS
          ? 'ca-app-pub-3940256099942544/1712485313'
          : 'ca-app-pub-3940256099942544/5224354917', //TODO: PrivateKeys.getRewardedAdUnitId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          rewardedVideoState = const AdState.loaded();
          rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              loadRewardedAd(fromDismissed: true);
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              emitAdErrorState();
            },
          );
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) => emitAdErrorState(),
      ),
    );
  }
}
