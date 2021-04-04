import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prospector/src/application/auth/auth_state_notifier.dart';
import 'package:prospector/src/data/auth/firebase_auth_repository.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';


final _firebaseAuthRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn());
});

final _isAuthenticatedStreamProvider = StreamProvider<bool>((ref) {
  final _authRepository = ref.watch(_firebaseAuthRepositoryProvider);
    return _authRepository.isUserAuthenticated;
});

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier>((ref) {
  final _authRepository = ref.watch(_firebaseAuthRepositoryProvider);
  final _isAuthenticated = ref.watch(_isAuthenticatedStreamProvider);
  return AuthStateNotifier(_authRepository, _isAuthenticated);
});


