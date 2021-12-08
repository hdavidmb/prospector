import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/fetch_state/fetch_state.dart';
import '../../../features/admob/application/ads_providers.dart';
import '../../../features/analytics/firebase_analytics_providers.dart';
import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../features/auth/application/auth_state.dart';
import '../../../features/contacts/application/contacts_providers.dart';
import '../../../features/events/application/events_providers.dart';
import '../../../features/import_contacts/application/import_contacts_providers.dart';
import '../../../features/in_app_purchase/application/in_app_purchase_providers.dart';
import '../../../features/interactions/application/interactions_providers.dart';
import '../../../features/local_notifications/application/local_notifications_providers.dart';
import '../../../features/statistics/application/statistics_providers.dart';
import '../../../features/tags/application/tags_provider.dart';
import '../../../features/user/application/user_info_providers.dart';
import 'app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final AuthState authState;
  final FetchState defaultDataState;
  final FetchState userInfoState;
  final FetchState contactsState;
  final FetchState interactionsState;
  final FetchState eventsState;
  final FetchState tagsState;
  final FetchState statisticsState;
  final Reader read;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataState,
    required this.userInfoState,
    required this.contactsState,
    required this.interactionsState,
    required this.eventsState,
    required this.tagsState,
    required this.statisticsState,
    required this.read,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.error() ||
        defaultDataState.isError ||
        userInfoState.isError ||
        contactsState.isError ||
        interactionsState.isError ||
        eventsState.isError ||
        tagsState.isError ||
        statisticsState.isError) {
      state = const AppState.error();
    } else if (defaultDataState.isReady) {
      if (authState == const AuthState.authenticated()) {
        read(localNotificationsProvider).initializeLocalNotifications();
        read(inAppPurchaseNotifier).getPackages();
        // TODO check if this post authentication logic can be handled from authStateNotifier
        if (userInfoState.isReady) {
          read(inAppPurchaseNotifier).logInPurchaser();
          read(firebaseAnalyticsServiceProvider).setUserProperties();
          if (contactsState.isInitial) {
            read(contactsNotifierProvider).getContacts();
          }
          if (interactionsState.isInitial) {
            read(interactionsNotifierProvider).getInteractions();
          }
          if (tagsState.isInitial) {
            read(tagsNotifierProvider).getTags();
          }
          if (eventsState.isInitial) {
            read(eventsNotifierProvider).getEvents();
          }

          final bool isPremiumUser =
              read(userInfoNotifierProvider).isPremiumUser;
          if (isPremiumUser) {
            //TODO init premium user configuration (contactsSync, Statistics)
            read(statisticsNotifierProvider).getStatistics();
            read(importContactsProvider).addContactsListener();
          } else {
            read(adsProvider).loadAds();
          }

          final bool statisticsReady =
              (isPremiumUser && statisticsState.isReady) || !isPremiumUser;

          if (contactsState.isReady &&
              interactionsState.isReady &&
              tagsState.isReady &&
              eventsState.isReady &&
              statisticsReady) {
            state = const AppState.authenticatedReady();
            read(localNotificationsProvider)
                .handleAppLaunchedFromNotification();
          }
        } else if (userInfoState.isInitial) {
          Future.delayed(const Duration(milliseconds: 300),
              () => read(userInfoNotifierProvider).getOrCreateUser());
        }
      } else if (authState == const AuthState.unauthenticated()) {
        state = const AppState.unauthenticatedReady();
      }
    }
  }

  void reset() {
    // * Reset all data notifiers (interactions, events, statistics)
    read(appDefaultDataProvider).reset();
    read(appDefaultDataProvider)
        .getDefaultData(); //TODO: check if needed (Already called in splashscreen)
    read(userInfoNotifierProvider).reset();
    read(contactsNotifierProvider).reset();
    read(tagsNotifierProvider).reset();
    read(interactionsNotifierProvider).reset();
    read(eventsNotifierProvider).reset();
    read(statisticsNotifierProvider).reset();
    read(inAppPurchaseNotifier).reset();
    read(inAppPurchaseNotifier).logOutPurchaser();
    read(firebaseAnalyticsServiceProvider).resetUserProperties();
    state = const AppState.initial();
  }
}
