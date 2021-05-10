import 'dart:io' show Platform;

class PrivateKeysExample {
  static const String _developerIdAndroid = 'ANDROID_DEVELOPER_ID';

  static String getDeveloperIdAndroid() {
    return _developerIdAndroid;
  }


  static const String _gPlacesApiKey = 'G_PLACES_API_KEY';

  static String getGooglePlacesApiKey() {
    return _gPlacesApiKey;
  }

  static const String _adMobAppIDAndroid = 'ANDROID_APP_ID';
  static const String _adMobAppIDIOS = 'IOS_APP_ID';

  static String getAdMobAppID() {
    if (Platform.isIOS) {
      return _adMobAppIDIOS;
    } else {
      return _adMobAppIDAndroid;
    }
  }

  static const String _bannerUnitIDAndroid = 'ANDROID_BANNER_ID';
  static const String _bannerUnitIDIOS = 'IOS_BANNER_ID';

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return _bannerUnitIDIOS;
    } else {
      return _bannerUnitIDAndroid;
    }
  }

  static const _rewardedUnitIDAndroid = 'ANDROID_REWARDED_ID';
  static const _rewardedUnitIDIOS = 'IOS_REWARDED_ID';

  static String getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return _rewardedUnitIDIOS;
    } else {
      return _rewardedUnitIDAndroid;
    }
  }

  static const _nativeUnitIDAndroid = 'ANDROID_NATIVE_ID';
  static const _nativeUnitIDIOS = 'IOS_NATIVE_ID';

  static String getNativeAdUnitId() {
    if (Platform.isIOS) {
      return _nativeUnitIDIOS;
    } else {
      return _nativeUnitIDAndroid;
    }
  }

  static const _iOSAppSharedSecret = 'IOS_APP_SHARED_SECRET';

  static String getiOSAppSharedSecret() {
    return _iOSAppSharedSecret;
  }

}