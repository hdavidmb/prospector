import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:prospector/src/features/user/application/user_info_state.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/features/user/domain/use_cases/get_or_create_user_info.dart';
import 'package:prospector/src/features/user/domain/use_cases/get_user_auth_provider.dart';
import 'package:prospector/src/features/user/domain/use_cases/update_user_profile.dart';

class UserInfoNotifier extends ChangeNotifier {
  final GetOrCreateUserInfo getOrCreateUserInfo;
  final GetUserAuthProvider getUserAuthProvider;
  final UpdateUserProfile updateUserProfile;
  UserInfoNotifier({
    required this.getOrCreateUserInfo,
    required this.getUserAuthProvider,
    required this.updateUserProfile,
  });

  void reset() {
    _userInfoState = const UserInfoState.initial();
  }

  UserInfoState _userInfoState = const UserInfoState.initial();
  late UserEntity _user;

  UserInfoState get userInfoState => _userInfoState;
  UserEntity get user => _user;

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
    final newUserInfo =
        _user.copyWith(name: displayName, photoURL: photoURL); 
    if (_user == newUserInfo) return right(unit);
    final updateResult = await updateUserProfile(newUserInfo);
    return updateResult.fold(
      (failure) => left(failure),
      (_) {
        _user = newUserInfo;
        notifyListeners();
        return right(unit);
      },
    );
  }

  String getUserProvider() => getUserAuthProvider();
}
