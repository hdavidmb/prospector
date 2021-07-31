import 'package:dartz/dartz.dart';

import '../auth_failure.dart';
import '../i_auth_repository.dart';

class SignInWithFacebook {
  final IAuthRepository authRepository;

  SignInWithFacebook({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call() => authRepository.signInWithFacebook();

}