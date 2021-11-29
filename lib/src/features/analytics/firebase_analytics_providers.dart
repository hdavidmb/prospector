import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_analytics_service.dart';

final firebaseAnalyticsInstance = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics();
});

final firebaseAnalyticsObserver = Provider<FirebaseAnalyticsObserver>((ref) {
  return FirebaseAnalyticsObserver(
      analytics: ref.watch(firebaseAnalyticsInstance));
});

final firebaseAnalyticsServiceProvider =
    Provider<FirebaseAnalyticsService>((ref) {
  return FirebaseAnalyticsService(
    analytics: ref.watch(firebaseAnalyticsInstance),
    read: ref.read,
  );
});
