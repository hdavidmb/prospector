// TODO: import 'package:prospector/src/application/auth/auth_state.dart';
import 'package:prospector/src/domain/auth/i_auth_repository.dart';

class AuthNotifier /* extends StateNotifier<AuthState> */ { // TODO: implement StateNotifier
  final IAuthRepository _authRepository;

  AuthNotifier(this._authRepository);

}