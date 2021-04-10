import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';


class ResetPassword {
  final IAuthRepository authRepository;

  ResetPassword({@required this.authRepository}) : assert(authRepository != null);

  Future<Either<AuthFailure, Unit>> call({@required String email}) => authRepository.resetPassword(email: email);
}