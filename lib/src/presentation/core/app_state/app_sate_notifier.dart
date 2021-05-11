import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_state.dart';
import 'package:prospector/src/features/tags/application/tags_provider.dart';
import 'package:prospector/src/features/tags/application/tags_state.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/application/user_info_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state.dart';

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
    if (defaultDataState == const AppDefaultDataState.ready()) {
      if (authState == const AuthState.authenticated()) {
        if (userInfoState == const UserInfoState.ready()) {

          if (contactsState != const ContactsState.ready()) {
            read(contactsNotifierProvider).getContacts();
          }
          if (tagsState != const TagsState.ready()) {
            read(tagsNotifierProvider).getTags();
          }


          if (contactsState == const ContactsState.ready() && tagsState == const TagsState.ready()) {
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
    if (authState == const AuthState.error() ||
        defaultDataState == const AppDefaultDataState.error() ||
        userInfoState == const UserInfoState.error() || contactsState == const ContactsState.error() || tagsState == const TagsState.error()) {
      state = const AppState.error();
    }
  }

  void reset() => state = const AppState.initial();
}
