import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/local_notifications/application/local_notifications_providers.dart';

import '../../../features/admob/application/ads_providers.dart';
import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../features/app_default_data/application/app_default_data_state.dart';
import '../../../features/auth/application/auth_state.dart';
import '../../../features/contacts/application/contacts_providers.dart';
import '../../../features/contacts/application/contacts_state.dart';
import '../../../features/events/application/events_providers.dart';
import '../../../features/events/application/events_state.dart';
import '../../../features/import_contacts/application/import_contacts_providers.dart';
import '../../../features/interactions/application/interactions_providers.dart';
import '../../../features/interactions/application/interactions_state.dart';
import '../../../features/tags/application/tags_provider.dart';
import '../../../features/tags/application/tags_state.dart';
import '../../../features/user/application/user_info_providers.dart';
import '../../../features/user/application/user_info_state.dart';
import 'app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final AuthState authState;
  final AppDefaultDataState defaultDataState;
  final UserInfoState userInfoState;
  final ContactsState contactsState;
  final InteractionsState interactionsState;
  final EventsState eventsState;
  final TagsState tagsState;
  final Reader read;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataState,
    required this.userInfoState,
    required this.contactsState,
    required this.interactionsState,
    required this.eventsState,
    required this.tagsState,
    required this.read,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.error() ||
        defaultDataState == const AppDefaultDataState.error() ||
        userInfoState == const UserInfoState.error() ||
        contactsState == const ContactsState.error() ||
        interactionsState == const InteractionsState.error() ||
        eventsState == const EventsState.error() ||
        tagsState == const TagsState.error()) {
      state = const AppState.error();
    } else if (defaultDataState == const AppDefaultDataState.ready()) {
      if (authState == const AuthState.authenticated()) {
        if (userInfoState == const UserInfoState.ready()) {
          if (contactsState == const ContactsState.initial()) {
            read(contactsNotifierProvider).getContacts();
          }
          if (interactionsState == const InteractionsState.initial()) {
            read(interactionsNotifierProvider).getInteractions();
          }
          if (tagsState == const TagsState.initial()) {
            read(tagsNotifierProvider).getTags();
          }
          if (eventsState == const EventsState.initial()) {
            read(eventsNotifierProvider).getEvents();
          }

          if (read(userInfoNotifierProvider).isPremiumUser) {
            //TODO init premium user configuration (contactsSync, Statistics)
            read(importContactsProvider).addContactsListener();
          } else {
            read(adsProvider).loadAds();
          }

          if (contactsState == const ContactsState.ready() &&
              interactionsState == const InteractionsState.ready() &&
              tagsState == const TagsState.ready() &&
              eventsState == const EventsState.ready()) {
            state = const AppState.authenticatedReady();

            read(localNotificationsProvider).initializeLocalNotifications();
          }
        } else if (userInfoState == const UserInfoState.initial()) {
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
    //TODO read(statisticsNotifierProvider).reset();
    state = const AppState.initial();
  }
}
