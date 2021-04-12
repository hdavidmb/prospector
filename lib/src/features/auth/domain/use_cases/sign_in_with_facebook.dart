import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class SignInWithFacebook {
  final IAuthRepository authRepository;

  SignInWithFacebook({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.signInWithFacebook();

}