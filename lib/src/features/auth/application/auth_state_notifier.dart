import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../analytics/firebase_analytics_providers.dart';

import '../../contacts/application/contacts_providers.dart';
import '../../events/application/events_providers.dart';
import '../../in_app_purchase/application/in_app_purchase_providers.dart';
import '../../interactions/application/interactions_providers.dart';
import '../../local_notifications/application/local_notifications_providers.dart';
import '../../statistics/application/statistics_providers.dart';
import '../../tags/application/tags_provider.dart';
import '../../user/application/user_info_providers.dart';
import 'auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AsyncValue<bool> isAuthenticated;
  final Reader read;
  // The value passed into the super constructor is the initial state
  AuthStateNotifier({required this.isAuthenticated, required this.read})
      : super(const AuthState.initial()) {
    state = isAuthenticated.when(
      data: (isAuthenticated) {
        if (isAuthenticated) {
          return const AuthState.authenticated();
        } else {
          // * Reset all user data providers (Contacts, tags, interactions, events, etc)
          read(userInfoNotifierProvider).reset();
          read(contactsNotifierProvider).reset();
          read(tagsNotifierProvider).reset();
          read(interactionsNotifierProvider).reset();
          read(eventsNotifierProvider).reset();
          read(statisticsNotifierProvider).reset();
          read(localNotificationsProvider).cancelAllNotifications();
          read(inAppPurchaseNotifier).reset();
          read(inAppPurchaseNotifier).logOutPurchaser();
          read(firebaseAnalyticsServiceProvider).resetUserProperties();
          return const AuthState.unauthenticated();
        }
      },
      loading: () => const AuthState.initial(),
      error: (_, __) => const AuthState.error(),
    );
  }
}
