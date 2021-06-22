import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_auth_profile_repository.dart';
import 'package:prospector/src/features/user/domain/use_cases/update_user_document.dart';

class UpdateUserProfile {
  final IUserAuthProfileRepository userAuthProfileRepository;
  final UpdateUserDocument updateUserDocument;
  UpdateUserProfile({
    required this.userAuthProfileRepository,
    required this.updateUserDocument,
  });

  Future<Either<UserInfoFailure, UserEntity>> call(UserEntity user) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const UserInfoFailure.noConnection());
    final updateAuthResult = await userAuthProfileRepository.updateUserProfile(
        displayName: user.name, photoURL: user.photoURL);
    final updateDocumentResult = await updateUserDocument(user);
    if (updateAuthResult.isLeft() || updateDocumentResult.isLeft()) {
      return left(const UserInfoFailure.serverError());
    } else {
      return updateDocumentResult;
    }
  }
}
