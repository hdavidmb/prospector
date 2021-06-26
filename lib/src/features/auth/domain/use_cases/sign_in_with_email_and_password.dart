import 'package:dartz/dartz.dart';

import '../auth_failure.dart';
import '../i_auth_repository.dart';

class SignInWithEmailAndPassword {
  final IAuthRepository authRepository;

  SignInWithEmailAndPassword({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call({required String email, required String password}) => authRepository.signInWithEmailAndPassword(email: email, password: password);
}