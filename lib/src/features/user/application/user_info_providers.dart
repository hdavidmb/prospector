import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_instance_provider.dart';
import '../../../core/database/instances/database_instance_provider.dart';
import '../data/local/hive_user_info_repository.dart';
import '../data/remote/firestore_user_info_repository.dart';
import '../data/user_auth_profile_repository.dart';
import '../domain/interfaces/i_user_auth_profile_repository.dart';
import '../domain/interfaces/i_user_info_repository.dart';
import '../domain/use_cases/change_user_email.dart';
import '../domain/use_cases/change_user_password.dart';
import '../domain/use_cases/delete_user_account.dart';
import '../domain/use_cases/get_or_create_user_info.dart';
import '../domain/use_cases/get_user_auth_provider.dart';
import '../domain/use_cases/update_user_document.dart';
import '../domain/use_cases/update_user_profile.dart';
import 'user_info_notifier.dart';

final remoteUserInfoRepository = Provider<IUserInfoRepository>((ref) {
  return FirestoreUserInfoRepository(
      firestoreInstance: ref.watch(firestoreInstance));
});

final localUserInfoRepository = Provider<IUserInfoRepository>((ref) {
  return HiveUserInfoRepository();
});

final userAuthProfileRepository = Provider<IUserAuthProfileRepository>((ref) {
  return UserAuthProfileRepository(
      firebaseAuthInstance: ref.watch(firebaseAuthInstance));
});

// * Use cases
final getOrCreateUserInfo = Provider<GetOrCreateUserInfo>((ref) {
  final _localUserInfoRepository = ref.watch(localUserInfoRepository);
  final _remoteUserInfoRepository = ref.watch(remoteUserInfoRepository);
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  return GetOrCreateUserInfo(
    localUserInfoRepository: _localUserInfoRepository,
    remoteUserInfoRepository: _remoteUserInfoRepository,
    userAuthProfileRepository: _userAuthProfileRepository,
    read: ref.read,
  );
});

final getUserAuthProvider = Provider<GetUserAuthProvider>((ref) {
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  return GetUserAuthProvider(
      userAuthProfileRepository: _userAuthProfileRepository);
});

final deleteUserAccount = Provider<DeleteUserAccount>((ref) {
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  final _localUserInfoRepository = ref.watch(localUserInfoRepository);
  final _remoteUserInfoRepository = ref.watch(remoteUserInfoRepository);
  return DeleteUserAccount(
    userAuthProfileRepository: _userAuthProfileRepository,
    localUserInfoRepository: _localUserInfoRepository,
    remoteUserInfoRepository: _remoteUserInfoRepository,
  );
});

final updateUserDocument = Provider<UpdateUserDocument>((ref) {
  final _localUserInfoRepository = ref.watch(localUserInfoRepository);
  final _remoteUserInfoRepository = ref.watch(remoteUserInfoRepository);
  return UpdateUserDocument(
      localUserInfoRepository: _localUserInfoRepository,
      remoteUserInfoRepository: _remoteUserInfoRepository);
});

final updateUserProfile = Provider<UpdateUserProfile>((ref) {
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  final _updateUserDocument = ref.watch(updateUserDocument);
  return UpdateUserProfile(
      userAuthProfileRepository: _userAuthProfileRepository,
      updateUserDocument: _updateUserDocument);
});

final changeUserEmail = Provider<ChangeUserEmail>((ref) {
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  final _updateUserDocument = ref.watch(updateUserDocument);
  return ChangeUserEmail(
    userAuthProfileRepository: _userAuthProfileRepository,
    updateUserDocument: _updateUserDocument,
  );
});

final changeUserPassword = Provider<ChangeUserPassword>((ref) {
  final _userAuthProfileRepository = ref.watch(userAuthProfileRepository);
  return ChangeUserPassword(
      userAuthProfileRepository: _userAuthProfileRepository);
});

// * Notifier
final userInfoNotifierProvider =
    ChangeNotifierProvider<UserInfoNotifier>((ref) {
  final _getOrCreateUserInfo = ref.watch(getOrCreateUserInfo);
  final _getUserAuthProvider = ref.watch(getUserAuthProvider);
  final _updateUserProfile = ref.watch(updateUserProfile);
  final _changeUserEmail = ref.watch(changeUserEmail);
  final _updateUserDocument = ref.watch(updateUserDocument);
  return UserInfoNotifier(
    getOrCreateUserInfo: _getOrCreateUserInfo,
    getUserAuthProvider: _getUserAuthProvider,
    updateUserProfile: _updateUserProfile,
    changeUserEmail: _changeUserEmail,
    updateUserDocument: _updateUserDocument,
    read: ref.read,
  );
});
