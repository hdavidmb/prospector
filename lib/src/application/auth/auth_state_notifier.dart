import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import 'package:prospector/src/application/auth/auth_state.dart';
import 'package:prospector/src/domain/auth/auth_failure.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;
  final AsyncValue<bool> _isAuthenticated;
  // The value passed into the super constructor is the initial state
  AuthStateNotifier(this._authRepository, this._isAuthenticated)
      : super(const AuthState.initial()) {
    _isAuthenticated.when(
      data: (isAuthenticated) {
        state = isAuthenticated
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated();
      },
      loading: () {},
      error: (error, stack) {},
    );
  }

  Future<Either<AuthFailure, Unit>> googleSignIn() async {
    return _authRepository.googleSignIn();
  }

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({@required String email, @required String password}) {
    return _authRepository.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({@required String email, @required String password}) {
    return _authRepository.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() {
    return _authRepository.signOut();
  }
}
