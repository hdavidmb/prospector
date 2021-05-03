import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class RegisterWithEmailAndPassword {
  final IAuthRepository authRepository;

  RegisterWithEmailAndPassword({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call({required String email, required String password, required String displayName}) => authRepository.registerWithEmailAndPassword(email: email, password: password, displayName: displayName);
}