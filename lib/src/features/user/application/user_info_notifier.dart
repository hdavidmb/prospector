import 'package:flutter/material.dart';

import 'package:prospector/src/features/user/application/user_info_state.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/features/user/domain/use_cases/get_or_create_user_info.dart';

class UserInfoNotifier extends ChangeNotifier {
  final GetOrCreateUserInfo getOrCreateUserInfo;
  UserInfoNotifier({
    required this.getOrCreateUserInfo,
  });

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

  void reset() {
    _userInfoState = const UserInfoState.initial();
  }
}
