import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/connection/connection_checker.dart';
import '../../../../core/database/database_failures/database_failure.dart';
import '../../../app_default_data/application/app_default_data_providers.dart';
import '../entity/user_entity.dart';
import '../failures/user_info_failure.dart';
import '../interfaces/i_user_auth_profile_repository.dart';
import '../interfaces/i_user_info_repository.dart';

class GetOrCreateUserInfo {
  final IUserInfoRepository localUserInfoRepository;
  final IUserInfoRepository remoteUserInfoRepository;
  final IUserAuthProfileRepository userAuthProfileRepository;
  final Reader read;

  GetOrCreateUserInfo({
    required this.localUserInfoRepository,
    required this.remoteUserInfoRepository,
    required this.userAuthProfileRepository,
    required this.read,
  });

  Future<Either<UserInfoFailure, UserEntity>> call() async {
    // Get current user id from Auth Profile repository
    final String currentUserID = userAuthProfileRepository.currentUserID();
    // Check if user exists locally
    final localCheckResult =
        await localUserInfoRepository.userDocumentExists(uid: currentUserID);
    return localCheckResult.fold(
      (failure) => left(const UserInfoFailure.serverError()),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> return user
          final Either<DatabaseFailure, UserEntity> result =
              await getLocalUser(currentUserID: currentUserID);
          return result.fold(
            (_) => left(const UserInfoFailure.serverError()),
            (user) => right(user),
          );
        } else {
          // no? -> // Check if user exists on remote repository
          final bool isConnected = await checkConnection();
          if (!isConnected) return left(const UserInfoFailure.noConnection());
          final remoteCheckResult = await remoteUserInfoRepository
              .userDocumentExists(uid: currentUserID);
          return remoteCheckResult.fold(
            (_) => left(const UserInfoFailure.serverError()),
            (existsRemote) async {
              if (existsRemote) {
                //        yes? -> save locally and return user
                final Either<DatabaseFailure, UserEntity> result =
                    await saveUserLocally(currentUserID: currentUserID);
                return result.fold(
                  (_) => left(const UserInfoFailure.serverError()),
                  (user) => right(user),
                );
              } else {
                //        no? -> create local and remote user info and return user
                final Either<DatabaseFailure, UserEntity> result =
                    await createNewUser(currentUserID: currentUserID);
                return result.fold(
                  (_) => left(const UserInfoFailure.serverError()),
                  (user) => right(user),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<Either<DatabaseFailure, UserEntity>> getLocalUser(
      {required String currentUserID}) async {
    final localGetResult =
        await localUserInfoRepository.readUserDocument(uid: currentUserID);
    return localGetResult.fold(
      (failure) => left(failure),
      (user) => right(user),
    );
  }

  Future<Either<DatabaseFailure, UserEntity>> saveUserLocally(
      {required String currentUserID}) async {
    final remoteGetResult =
        await remoteUserInfoRepository.readUserDocument(uid: currentUserID);
    return remoteGetResult.fold(
      (failure) => left(failure),
      (user) async {
        await localUserInfoRepository.createUserDocument(user);
        return right(user);
      },
    );
  }

  Future<Either<DatabaseFailure, UserEntity>> createNewUser(
      {required String currentUserID}) async {
    final String freeSubID = read(appDefaultDataProvider).freeSubID;
    final String photoURL = userAuthProfileRepository.userPhotoURL();
    final email = userAuthProfileRepository.userEmail();
    final UserEntity user = UserEntity(
      uid: currentUserID,
      name: userAuthProfileRepository.userDisplayName(),
      subscription: freeSubID,
      expiryDate: DateTime.now().subtract(const Duration(days: 30)),
      created: DateTime.now(),
      modified: DateTime.now(),
      email: (email.isNotEmpty) ? email : null,
      photoURL: (photoURL.isNotEmpty) ? photoURL : null,
    );
    await localUserInfoRepository.createUserDocument(user);
    await remoteUserInfoRepository.createUserDocument(user);
    return right(user);
  }
}
