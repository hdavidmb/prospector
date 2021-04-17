import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AuthState authState;
  bool defaultDataReady;
  AppStateNotifier({
    required this.authState,
    required this.defaultDataReady,
  }) : super(const AppState.initial()) {
    if (authState == const AuthState.authenticated()) {
      //TODO get user data
      state = const AppState.authenticatedReady();
    }
    if (authState == const AuthState.unauthenticated() &&
        defaultDataReady) {
      state = const AppState.unauthenticatedReady();
    }
  }
}
