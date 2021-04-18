import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';

import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  final AuthState authState;
  final AppDefaultDataState defaultDataState;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataState,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.authenticated()) {
      //TODO get user data
      state = const AppState.authenticatedReady();
    }
    if (authState == const AuthState.unauthenticated() &&
        defaultDataState == const AppDefaultDataState.ready()) {
      state = const AppState.unauthenticatedReady();
    }
    if (authState == const AuthState.error() || defaultDataState == const AppDefaultDataState.error()) {
      state = const AppState.error();
    }
  }

  void reset() => state = const AppState.initial();

}
