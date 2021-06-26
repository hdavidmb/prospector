import 'package:dartz/dartz.dart';

import '../auth_failure.dart';
import '../i_auth_repository.dart';


class ResetPassword {
  final IAuthRepository authRepository;

  ResetPassword({required this.authRepository});

  Future<Either<AuthFailure, Unit>> call({required String email}) => authRepository.resetPassword(email: email);
}