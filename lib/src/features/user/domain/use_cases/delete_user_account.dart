import 'package:dartz/dartz.dart';

import '../../../../core/connection/connection_checker.dart';
import '../failures/user_info_failure.dart';
import '../interfaces/i_user_auth_profile_repository.dart';
import '../interfaces/i_user_info_repository.dart';

class DeleteUserAccount {
  final IUserAuthProfileRepository userAuthProfileRepository;
  final IUserInfoRepository localUserInfoRepository;
  final IUserInfoRepository remoteUserInfoRepository;

  DeleteUserAccount({
    required this.userAuthProfileRepository,
    required this.localUserInfoRepository,
    required this.remoteUserInfoRepository,
  });

  Future<Either<UserInfoFailure, Unit>> call() async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const UserInfoFailure.noConnection());
    final String uid = userAuthProfileRepository.currentUserID();
    final deleteResult = await userAuthProfileRepository.deleteAccount();
    return deleteResult.fold(
      (failure) => left(const UserInfoFailure.serverError()),
      (_) async {
        final localDelete =
            await localUserInfoRepository.deleteUserDocument(uid: uid);
        final remoteDelete =
            await remoteUserInfoRepository.deleteUserDocument(uid: uid);
        if (localDelete.isLeft() || remoteDelete.isLeft()) {
          return left(const UserInfoFailure.serverError());
        } else {
          return right(unit);
        }
      },
    );
  }
}
