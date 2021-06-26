import 'package:dartz/dartz.dart';

import '../../features/auth/domain/auth_failure.dart';

Either<AuthFailure, Unit> manageFirebaseAuthExceptions(
      {required String errorCode}) {
    switch (errorCode) {
      case 'email-already-in-use':
        return left(const AuthFailure.emailAlreadyInUse());
      case 'user-not-found':
      case 'wrong-password':
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      case 'account-exists-with-different-credential':
        return left(const AuthFailure.accountExistsWithDifferentCredential());
      case 'AuthorizationErrorCode.canceled':
        return left(const AuthFailure.cancelledByUser());
      case 'user-not-found-reset-password':
        return left(const AuthFailure.userNotFoundResetPassword());
      default:
        return left(const AuthFailure.serverError());
    }
  }