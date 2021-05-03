import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class ReloginUser {
  final IAuthRepository authRepository;
  ReloginUser({
    required this.authRepository,
  });

  Future<Either<AuthFailure, Unit>> call(
          {required String provider, String? password}) =>
      authRepository.reloginUser(provider: provider, password: password);
}
