import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:prospector/src/domain/auth/auth_failure.dart';

abstract class IAuthRepository {

  Stream<bool> get isUserAuthenticated;

  //TODO create current user getter returning custom user entity or user id

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({@required String email, @required String password});
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({@required String email, @required String password});
  Future<Either<AuthFailure, Unit>> googleSignIn();
  Future<void> signOut();

} 