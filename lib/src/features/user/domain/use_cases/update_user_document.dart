import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_info_repository.dart';

class UpdateUserDocument {
  final IUserInfoRepository localUserInfoRepository;
  final IUserInfoRepository remoteUserInfoRepository;
  UpdateUserDocument({
    required this.localUserInfoRepository,
    required this.remoteUserInfoRepository,
  });

  Future<Either<UserInfoFailure, UserEntity>> call(UserEntity user) async {
    final newUserInfo = user.copyWith(modified: DateTime.now());
    final localUpdate = await localUserInfoRepository.updateUserDocument(newUserInfo);
    final remoteUpdate =
        await remoteUserInfoRepository.updateUserDocument(newUserInfo);
    if (localUpdate.isLeft() || remoteUpdate.isLeft()) {
      return left(const UserInfoFailure.serverError());
    } else {
      return right(newUserInfo); //TODO test
    }
  }
}
