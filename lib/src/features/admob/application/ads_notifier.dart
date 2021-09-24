import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../core/private/private_keys.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../domain/native_ad_dummy.dart';
import 'ad_state.dart';

class AdsNotifier extends ChangeNotifier {
  final UserSharedPreferences prefs;
  AdsNotifier({required this.prefs}) {
    _rewardEndDate = prefs.rewardEndDate;
    _setTimerOnInit();

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

  final int rewardMinutes = 1; //TODO: change to 20
  DateTime _rewardEndDate = DateTime.now().subtract(const Duration(days: 10));

  bool get isRewarded => DateTime.now().isBefore(_rewardEndDate);

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
          debugPrint('Rewarded ad loaded');
          rewardedAd = ad;
          rewardedVideoState = const AdState.loaded();
          rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              debugPrint('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              loadRewardedAd(fromDismissed: true);
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              emitAdErrorState();
            },
          );
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Reward ad failed to load. Code: ${error.code}');
          emitAdErrorState();
        },
      ),
    );
  }

  void _setTimerOnInit() {
    if (isRewarded) {
      final Duration diff = _rewardEndDate.difference(DateTime.now());
      _setRewardEndTimer(diff);
    }
  }

  void _setRewardEndTimer(Duration duration) =>
      Timer(duration + const Duration(seconds: 1), () => notifyListeners());

  void showRewaradedVideo() {
    if (rewardedVideoState.isLoaded && rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
          debugPrint('User got rewarded');
          _rewardEndDate = DateTime.now().add(Duration(minutes: rewardMinutes));
          prefs.rewardEndDate = _rewardEndDate;
          notifyListeners();
          _setRewardEndTimer(Duration(minutes: rewardMinutes));
        },
      );
    }
  }

  Map<String, Map<String, Map<String, dynamic>>> nativeAdsMap = {};

  NativeAd getNativeAd({required String status, required int index}) {
    final String indexString = index.toString();
    debugPrint(
        '------ Get Native called. Status: $status. Index: $index -------');
    final adStateMap = nativeAdsMap[status]?[indexString];

    if (adStateMap == null) {
      if (nativeAdsMap[status] == null) nativeAdsMap[status] = {};
      if (nativeAdsMap[status]![indexString] == null) {
        nativeAdsMap[status]?[indexString] = {};
      }

      nativeAdsMap[status]![indexString]!['state'] = const AdState.initial();

      final nativeAd = NativeAd(
        adUnitId: Platform.isIOS
            ? 'ca-app-pub-3940256099942544/3986624511'
            : 'ca-app-pub-3940256099942544/2247696110', //TODO: PrivateKeys.getNativeAdUnitId();
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint(
                'Native Ad loaded successfully. Status: $status. Index: $index');
            nativeAdsMap[status]?[indexString]?['state'] =
                const AdState.loaded();
            notifyListeners();
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            nativeAdsMap[status]?[indexString]?['state'] =
                const AdState.error();
            ad.dispose();

            debugPrint(
                'Native Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      );
      nativeAdsMap[status]![indexString]!['ad'] = nativeAd;
      nativeAdsMap[status]![indexString]!['ad'].load();
      return nativeAdsMap[status]![indexString]!['ad'] as NativeAd;
    } else {
      return adStateMap['ad'] as NativeAd;
    }
  }

  List<Object> insertAds(List<Object> contacts) {
    final List<Object> _contactsWAds = [];
    if (contacts.isNotEmpty) {
      _contactsWAds.addAll(contacts);
      final int numOfAds = ((_contactsWAds.length + 4) / 9).floor();
      if (numOfAds == 0) {
        _contactsWAds.add(const NativeAdDummy());
      } else {
        for (var i = 1; i <= numOfAds; i++) {
          final index = i * 10 - 6;
          _contactsWAds.insert(index, const NativeAdDummy());
        }
      }
    }
    return _contactsWAds;
  }
}
