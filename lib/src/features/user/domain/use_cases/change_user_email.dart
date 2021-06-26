import 'package:dartz/dartz.dart';

import '../../../../core/connection/connection_checker.dart';
import '../entity/user_entity.dart';
import '../failures/user_info_failure.dart';
import '../interfaces/i_user_auth_profile_repository.dart';
import 'update_user_document.dart';

class ChangeUserEmail {
  final IUserAuthProfileRepository userAuthProfileRepository;
  final UpdateUserDocument updateUserDocument;
  ChangeUserEmail({
    required this.userAuthProfileRepository,
    required this.updateUserDocument,
  });

  Future<Either<UserInfoFailure, UserEntity>> call(UserEntity user) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const UserInfoFailure.noConnection());
    final changeResult =
        await userAuthProfileRepository.changeUserEmail(newEmail: user.email!);
    return changeResult.fold(
      (failure) {
        return left(
          failure.maybeWhen(
            noConnection: () => const UserInfoFailure.noConnection(),
            emailAlreadyInUse: () => const UserInfoFailure.emailAlreadyInUse(),
            orElse: () => const UserInfoFailure.serverError(),
          ),
        );
      },
      (_) => updateUserDocument(user),
    );
  }
}
