import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class AppleSignIn {
  final IAuthRepository authRepository;

  AppleSignIn({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.appleSignIn();

}