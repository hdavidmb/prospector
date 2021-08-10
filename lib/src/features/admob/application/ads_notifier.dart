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
              //TODO: check where to reload the rewarded video ad
              onAdShowedFullScreenContent: (RewardedAd ad) =>
                  print('$ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
              onAdImpression: (RewardedAd ad) =>
                  print('$ad impression occurred.'),
            );
            notifyListeners();
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedVideoState = const AdState.error();
            notifyListeners();
          },
        ),
      );
      notify = true;
    }
    // if (notify) notifyListeners();
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
}
