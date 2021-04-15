import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';

abstract class IAuthRepository {

  Stream<bool> get isUserAuthenticated;

  //TODO create current user getter returning custom user entity or user id

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required String email, required String password});
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required String email, required String password, required String displayName});
  Future<Either<AuthFailure, Unit>> resetPassword({required String email});
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<Either<AuthFailure, Unit>> signInWithFacebook();
  Future<Either<AuthFailure, Unit>> appleSignIn();
  Future<void> signOut();

} 