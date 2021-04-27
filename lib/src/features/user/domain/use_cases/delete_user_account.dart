import 'package:dartz/dartz.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_auth_profile_repository.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_info_repository.dart';

class DeleteUserAccount {
  final IUserAuthProfileRepository userAuthProfileRepository;
  final IUserInfoRepository localUserInfoRepository;
  final IUserInfoRepository remoteUserInfoRepository;

  DeleteUserAccount({
    required this.userAuthProfileRepository,
    required this.localUserInfoRepository,
    required this.remoteUserInfoRepository,
  });

  Future<Either<AuthFailure, Unit>> call() async {
        final String uid = userAuthProfileRepository.currentUserID();
    final deleteResult = await userAuthProfileRepository.deleteAccount();
    return deleteResult.fold(
      (failure) => left(failure),
      (_) async {
        final localDelete =
            await localUserInfoRepository.deleteUserDocument(uid: uid);
        final remoteDelete =
            await remoteUserInfoRepository.deleteUserDocument(uid: uid);
        if (localDelete.isLeft() || remoteDelete.isLeft()) {
          return left(const AuthFailure.serverError());
        } else {
          return right(unit);
        }
      },
    );
  }
}
