import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/application/auth/auth_state.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;
  // The value passed into the super constructor is the initial state
  AuthNotifier(this._authRepository) : super(const AuthState.initial()) {
    listener = _authRepository.isUserAuthenticated.listen((isAuthenticated) {
      state = isAuthenticated
          ? const AuthState.authenticated()
          : const AuthState.unauthenticated();
    });
  }

  StreamSubscription listener;
  void disposeListener() {
    listener?.cancel();
  }

  
}
