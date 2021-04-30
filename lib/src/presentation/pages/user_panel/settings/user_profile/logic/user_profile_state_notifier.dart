import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/relogin_user.dart';
import 'package:prospector/src/features/auth/domain/use_cases/sign_out.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/use_cases/delete_user_account.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state.dart';

class UserProfileStateNotifier extends StateNotifier<UserProfileState> {
  final SignOut signOut;
  final ReloginUser reloginUser;
  final DeleteUserAccount deleteUserAccount;
  final Reader read;

  UserProfileStateNotifier(
      {required this.signOut,
      required this.reloginUser,
      required this.deleteUserAccount,
      required this.read})
      : super(const UserProfileState.initial());

  String? _formName;

  // ignore: use_setters_to_change_properties
  void nameChanged(String value) => _formName = value;

  Future<void> logOutButtonPressed() async {
    await signOut();
  }

  Future<void> deleteAccountButtonPressed(
      {required BuildContext context}) async {
    state = const UserProfileState.submitting();
    final userAuthProvider = read(userInfoNotifierProvider).getUserProvider();
    final bool _isPassword = userAuthProvider == 'password';
    final response = await showDeleteConfirmDialog(
        context: context, isPassword: _isPassword);
    response.fold(
      () {},
      (_response) async {
        await Future.delayed(const Duration(milliseconds: 200), () async {
          Either<AuthFailure, Unit> reloginResult;
          if (_isPassword) {
            reloginResult = await reloginUser(
                provider: userAuthProvider, password: _response);
          } else if (_response == AppLocalizations.of(context)!.deleteCap) {
            reloginResult = await reloginUser(provider: userAuthProvider);
          } else {
            reloginResult =
                left(const AuthFailure.invalidEmailAndPasswordCombination());
          }
          reloginResult.fold(
            (failure) => state = UserProfileState.reloginError(failure),
            (r) async {
              final deleteResult = await deleteUserAccount();
              deleteResult.fold(
                (failure) => state = UserProfileState.error(failure),
                (_) async {
                  await signOut();
                  state = const UserProfileState.initial();
                },
              );
            },
          );
        });
      },
    );
  }

  Future<bool> saveButtonPressed() async {
    state = const UserProfileState.submitting();
    final saveResult = await read(userInfoNotifierProvider)
        .updateUserAuthProfile(displayName: _formName);
    return saveResult.fold(
      (failure) {
        state = UserProfileState.error(failure);
        return false;
      },
      (_) {
        state = const UserProfileState.initial();
        return true;
      },
    );
  }
}
