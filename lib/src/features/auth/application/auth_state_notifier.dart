import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/application/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AsyncValue<bool> isAuthenticated;
  // The value passed into the super constructor is the initial state
  AuthStateNotifier({required this.isAuthenticated})
      : super(const AuthState.initial()) {
    state = isAuthenticated.when(
      data: (isAuthenticated) {
        return isAuthenticated
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated();
      },
      loading: () => const AuthState.initial(),
      error: (_, __) => const AuthState.error(),
    );
  }
}
