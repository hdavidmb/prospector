import 'package:dartz/dartz.dart';

import 'auth_failure.dart';

abstract class IAuthRepository {
  Stream<bool> get isUserAuthenticated;

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });
  Future<Either<AuthFailure, Unit>> resetPassword({required String email});
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<Either<AuthFailure, Unit>> signInWithFacebook();
  Future<Either<AuthFailure, Unit>> appleSignIn();
  Future<Either<AuthFailure, Unit>> reloginUser(
      {required String provider, String? password});
  Future<void> signOut();
}
