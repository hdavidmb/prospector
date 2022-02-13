import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/fetch_state/fetch_state.dart';
import '../in_app_purchase/application/in_app_purchase_providers.dart';
import '../user/application/user_info_providers.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics analytics;
  final Reader read;
  FirebaseAnalyticsService({
    required this.analytics,
    required this.read,
  });

  FetchState _userPropertiesState = const FetchState.initial();

  Future<void> setUserProperties() async {
    if (_userPropertiesState.isInitial) {
      _userPropertiesState = const FetchState.fetching();
      try {
        final uid = read(userInfoNotifierProvider).user?.uid;
        await analytics.setUserId(uid);
        _userPropertiesState = const FetchState.ready();
      } catch (e) {
        _userPropertiesState = const FetchState.error();
      }
    }
  }

  Future<void> resetUserProperties() async {
    if (_userPropertiesState.isReady || _userPropertiesState.isError) {
      _userPropertiesState = const FetchState.fetching();
      try {
        await analytics.setUserId(null);
        _userPropertiesState = const FetchState.initial();
      } catch (e) {
        _userPropertiesState = const FetchState.error();
      }
    }
  }

  Future<void> logAddProspectManually() =>
      analytics.logEvent(name: 'add_prospect_manually');

  Future<void> logImportContactManually() =>
      analytics.logEvent(name: 'import_contact_manually');

  Future<void> logEnableSyncContacts() =>
      analytics.logEvent(name: 'enable_sync_contact');

  Future<void> logDisableSyncContacts() =>
      analytics.logEvent(name: 'disable_sync_contact');

  Future<void> logImportContactAutomatically() =>
      analytics.logEvent(name: 'import_contact_automatically');

  Future<void> logCallContact() => analytics.logEvent(name: 'call_contact');

  Future<void> logOpenWhatsapp() => analytics.logEvent(name: 'open_whatsapp');

  Future<void> logPromptMembershipPage({required String fromPage}) =>
      analytics.logEvent(
          name: 'prompt_membership_page', parameters: {'from_page': fromPage});

  Future<void> logViewMembershipPaywall() =>
      analytics.logEvent(name: 'view_membership_paywall');

  Future<void> logSelectMembershipPackage({required String packageSKU}) =>
      analytics.logEvent(
          name: 'select_membership_package',
          parameters: {'package_sku': packageSKU});

  Future<void> logTapSubscribeButton({required int selectedIndex}) async {
    final String packageSKU =
        read(inAppPurchaseNotifier).packages[selectedIndex].sku;
    analytics.logEvent(
        name: 'tap_subscribe_button', parameters: {'package_sku': packageSKU});
  }

  Future<void> logPurchaseFailed(
          {required String failureString, required String packageSKU}) =>
      analytics.logEvent(
          name: 'purchase_failed',
          parameters: {'package_sku': packageSKU, 'failure': failureString});

  Future<void> logPurchaseSuccessful({required String packageSKU}) =>
      analytics.logEvent(
          name: 'purchase_successful', parameters: {'package_sku': packageSKU});
}
