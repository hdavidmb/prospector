import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_auth_profile_repository.dart';

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
