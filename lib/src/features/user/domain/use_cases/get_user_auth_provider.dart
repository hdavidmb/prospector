import '../interfaces/i_user_auth_profile_repository.dart';

class GetUserAuthProvider {
  final IUserAuthProfileRepository userAuthProfileRepository;

  GetUserAuthProvider({required this.userAuthProfileRepository});

  String call() => userAuthProfileRepository.userProvider();
}
