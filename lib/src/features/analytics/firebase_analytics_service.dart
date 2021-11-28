import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics analytics;
  FirebaseAnalyticsService({
    required this.analytics,
  });

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

  Future<void> logTapSubscribeButton() =>
      analytics.logEvent(name: 'tap_subscribe_button');
}
