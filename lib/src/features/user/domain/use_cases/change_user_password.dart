import 'package:dartz/dartz.dart';

import '../../../../core/connection/connection_checker.dart';
import '../failures/user_info_failure.dart';
import '../interfaces/i_user_auth_profile_repository.dart';

class ChangeUserPassword {
  final IUserAuthProfileRepository userAuthProfileRepository;
  ChangeUserPassword({
    required this.userAuthProfileRepository,
  });
  Future<Either<UserInfoFailure, Unit>> call(
      {required String newPassword}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const UserInfoFailure.noConnection());
    final changeResult = await userAuthProfileRepository.changePassword(
        newPassword: newPassword);
    return changeResult.fold(
      (_) => left(const UserInfoFailure.serverError()),
      (unit) => right(unit),
    );
  }
}
