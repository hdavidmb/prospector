import '../i_auth_repository.dart';

class SignOut {
  final IAuthRepository authRepository;

  SignOut({
    required this.authRepository,
  });

  Future<void> call() async {
    await authRepository.signOut();
  }
}
