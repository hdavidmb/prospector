import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:prospector/src/features/auth/application/auth_state_notifier.dart';
import 'package:prospector/src/features/auth/data/firebase_auth_repository.dart';
import 'package:prospector/src/features/auth/data/helpers/sign_in_with_apple_helper.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';

export 'package:prospector/src/features/auth/application/auth_state.dart';

final _authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository(
    firebaseAuthInstance: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
    facebookAuth: FacebookAuth.instance,
    signInWithApple: SignInWithAppleHelper(),
  );
});

// * Use cases
final _isAuthenticatedStreamProvider = StreamProvider<bool>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return _authRepository.isUserAuthenticated;
});

final registerWithEmailAndPassword =
    Provider<RegisterWithEmailAndPassword>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return RegisterWithEmailAndPassword(authRepository: _authRepository);
});

final signInWithEmailAndPassword = Provider<SignInWithEmailAndPassword>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return SignInWithEmailAndPassword(authRepository: _authRepository);
});

final signInWithGoogle = Provider<SignInWithGoogle>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return SignInWithGoogle(authRepository: _authRepository);
});

final signInWithFacebook = Provider<SignInWithFacebook>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return SignInWithFacebook(authRepository: _authRepository);
});

final appleSignIn = Provider<AppleSignIn>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return AppleSignIn(authRepository: _authRepository);
});

final signOut = Provider<SignOut>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return SignOut(authRepository: _authRepository);
});

final resetPassword =
    Provider<ResetPassword>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return ResetPassword(authRepository: _authRepository);
});

// * Auth State provider
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier>((ref) {
  final _isAuthenticated = ref.watch(_isAuthenticatedStreamProvider);
  return AuthStateNotifier(isAuthenticated: _isAuthenticated);
});
