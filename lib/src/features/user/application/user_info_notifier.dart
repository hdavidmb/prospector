import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_default_data/application/app_default_data_providers.dart';
import '../domain/entity/user_entity.dart';
import '../domain/failures/user_info_failure.dart';
import '../domain/use_cases/change_user_email.dart';
import '../domain/use_cases/get_or_create_user_info.dart';
import '../domain/use_cases/get_user_auth_provider.dart';
import '../domain/use_cases/update_user_document.dart';
import '../domain/use_cases/update_user_profile.dart';
import 'user_info_state.dart';

class UserInfoNotifier extends ChangeNotifier {
  final GetOrCreateUserInfo getOrCreateUserInfo;
  final GetUserAuthProvider getUserAuthProvider;
  final UpdateUserProfile updateUserProfile;
  final ChangeUserEmail changeUserEmail;
  final UpdateUserDocument updateUserDocument;
  final Reader read;
  UserInfoNotifier({
    required this.getOrCreateUserInfo,
    required this.getUserAuthProvider,
    required this.updateUserProfile,
    required this.changeUserEmail,
    required this.updateUserDocument,
    required this.read,
  });

  UserInfoState _userInfoState = const UserInfoState.initial();
  late UserEntity
      _user; //TODO user should be nullable and be resetted at logout

  UserInfoState get userInfoState => _userInfoState;
  UserEntity get user => _user;

  bool get isPremiumUser {
    final String premiumSubID = read(appDefaultDataProvider).premiumSubID;
    return _user.subscription == premiumSubID;
  }

  String getUserProvider() => getUserAuthProvider();

  void reset() {
    _userInfoState = const UserInfoState.initial();
  }

  Future<void> getOrCreateUser() async {
    if (_userInfoState != const UserInfoState.fetching()) {
      _userInfoState = const UserInfoState.fetching();
      final result = await getOrCreateUserInfo();
      result.fold(
        (failure) => _userInfoState = const UserInfoState.error(),
        (user) {
          _user = user;
          _userInfoState = const UserInfoState.ready();
        },
      );
      notifyListeners();
    }
  }

  Future<Either<UserInfoFailure, Unit>> updateUserAuthProfile(
      {String? displayName, String? photoURL}) async {
    UserEntity newUserInfo = _user.copyWith();
    if (displayName != null) {
      newUserInfo = newUserInfo.copyWith(name: displayName);
    }
    if (photoURL != null) {
      newUserInfo = newUserInfo.copyWith(photoURL: photoURL);
    }
    return _performUpdate(
        newUserInfo: newUserInfo, callBack: updateUserProfile);
  }

  Future<Either<UserInfoFailure, Unit>> changeEmail(
      {required String newEmail}) async {
    final newUserInfo = _user.copyWith(email: newEmail);
    return _performUpdate(newUserInfo: newUserInfo, callBack: changeUserEmail);
  }

  Future<Either<UserInfoFailure, Unit>> updateUserInfo(
          UserEntity newUserInfo) async =>
      _performUpdate(newUserInfo: newUserInfo, callBack: updateUserDocument);

  Future<Either<UserInfoFailure, Unit>> _performUpdate(
      {required UserEntity newUserInfo,
      required Future<Either<UserInfoFailure, UserEntity>> Function(
              UserEntity callBackUser)
          callBack}) async {
    if (_user == newUserInfo) return right(unit);
    final result = await callBack(newUserInfo);
    return result.fold(
      (failure) => left(failure),
      (newUser) {
        _user = newUser; //TODO test checking modified field
        notifyListeners();
        return right(unit);
      },
    );
  }
}
