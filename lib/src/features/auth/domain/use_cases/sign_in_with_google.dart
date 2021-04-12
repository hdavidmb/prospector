import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class SignInWithGoogle {
  final IAuthRepository authRepository;

  SignInWithGoogle({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.signInWithGoogle();
}