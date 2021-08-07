import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/admob/application/ads_providers.dart';

import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../features/app_default_data/application/app_default_data_state.dart';
import '../../../features/auth/application/auth_state.dart';
import '../../../features/contacts/application/contacts_providers.dart';
import '../../../features/contacts/application/contacts_state.dart';
import '../../../features/import_contacts/application/import_contacts_providers.dart';
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
  final TagsState tagsState;
  final Reader read;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataState,
    required this.userInfoState,
    required this.contactsState,
    required this.tagsState,
    required this.read,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.error() ||
        defaultDataState == const AppDefaultDataState.error() ||
        userInfoState == const UserInfoState.error() ||
        contactsState == const ContactsState.error() ||
        tagsState == const TagsState.error()) {
      state = const AppState.error();
    } else if (defaultDataState == const AppDefaultDataState.ready()) {
      if (authState == const AuthState.authenticated()) {
        if (userInfoState == const UserInfoState.ready()) {
          if (contactsState == const ContactsState.initial()) {
            read(contactsNotifierProvider).getContacts();
          }
          if (tagsState == const TagsState.initial()) {
            read(tagsNotifierProvider).getTags();
          }

          if (read(userInfoNotifierProvider).isPremiumUser) {
            //TODO listen to user account changes
            //TODO init premium user configuration (contactsSync, Statistics)
            read(importContactsProvider).addContactsListener();
          } else {
            //TODO init free user configuration (Admob)
            read(adsProvider).loadAds();
          }

          if (contactsState == const ContactsState.ready() &&
              tagsState == const TagsState.ready()) {
            state = const AppState.authenticatedReady();
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
    //TODO reset all data notifiers (interactions, events, statistics)
    read(appDefaultDataProvider).reset();
    read(appDefaultDataProvider).getDefaultData();
    read(userInfoNotifierProvider).reset();
    read(contactsNotifierProvider).reset();
    read(tagsNotifierProvider).reset();
    state = const AppState.initial();
  }
}
