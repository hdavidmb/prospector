import 'package:dartz/dartz.dart';

import '../auth_failure.dart';
import '../i_auth_repository.dart';

class SignInWithGoogle {
  final IAuthRepository authRepository;

  SignInWithGoogle({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.signInWithGoogle();
}