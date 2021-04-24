import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/domain/i_auth_repository.dart';

class SignOut {
  final IAuthRepository authRepository;
  final Reader read;

  SignOut({
    required this.authRepository,
    required this.read,
  });

  Future<void> call() async {
    await authRepository.signOut();
  }
}
