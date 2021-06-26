import 'package:dartz/dartz.dart';

import '../auth_failure.dart';
import '../i_auth_repository.dart';

class AppleSignIn {
  final IAuthRepository authRepository;

  AppleSignIn({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.appleSignIn();

}