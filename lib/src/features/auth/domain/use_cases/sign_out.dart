import 'package:meta/meta.dart';

import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class SignOut {
  final IAuthRepository authRepository;

  SignOut({@required this.authRepository}) : assert(authRepository != null);

  Future<void> call() => authRepository.signOut();

}