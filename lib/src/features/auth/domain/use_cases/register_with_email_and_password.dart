import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class RegisterWithEmailAndPassword {
  final IAuthRepository authRepository;

  RegisterWithEmailAndPassword({@required this.authRepository}): assert(authRepository != null);

  Future<Either<AuthFailure, Unit>> call({@required String email, @required String password}) => authRepository.registerWithEmailAndPassword(email: email, password: password);
}