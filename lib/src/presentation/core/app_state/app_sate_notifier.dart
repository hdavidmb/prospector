import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/application/user_info_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final AuthState authState;
  final AppDefaultDataState defaultDataState;
  final UserInfoState userInfoState;
  final Reader read;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataState,
    required this.userInfoState,
    required this.read,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.authenticated()) {
      //TODO get user data
      if (userInfoState == const UserInfoState.ready()) {
        state = const AppState.authenticatedReady();
      } else if (userInfoState == const UserInfoState.initial()) {
        read(userInfoNotifierProvider).getOrCreateUser();
      }
    }
    if (authState == const AuthState.unauthenticated() &&
        defaultDataState == const AppDefaultDataState.ready()) {
      state = const AppState.unauthenticatedReady();
    }
    if (authState == const AuthState.error() || defaultDataState == const AppDefaultDataState.error() || userInfoState == const UserInfoState.error()) {
      state = const AppState.error();
    }
  }

  void reset() => state = const AppState.initial();

}
