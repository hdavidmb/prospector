import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/auth/auth_instance_provider.dart';
import 'package:prospector/src/core/database/instances/database_instance_provider.dart';
import 'package:prospector/src/features/user/application/user_info_notifier.dart';
import 'package:prospector/src/features/user/data/local/hive_user_info_repository.dart';
import 'package:prospector/src/features/user/data/remote/firestore_user_info_repository.dart';
import 'package:prospector/src/features/user/data/user_auth_profile_repository.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_auth_profile_repository.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_info_repository.dart';
import 'package:prospector/src/features/user/domain/use_cases/get_or_create_user_info.dart';
import 'package:prospector/src/features/user/domain/use_cases/get_user_auth_provider.dart';

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
    return GetUserAuthProvider(userAuthProfileRepository: _userAuthProfileRepository);
}); 

// * Notifier
final userInfoNotifierProvider = ChangeNotifierProvider<UserInfoNotifier>((ref) {
  final _getOrCreateUserInfo = ref.watch(getOrCreateUserInfo);
  final _getUserAuthProvider = ref.watch(getUserAuthProvider);
    return UserInfoNotifier(getOrCreateUserInfo: _getOrCreateUserInfo, getUserAuthProvider: _getUserAuthProvider);
});
