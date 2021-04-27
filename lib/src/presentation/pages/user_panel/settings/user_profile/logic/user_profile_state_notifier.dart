import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      required this.deleteUserAccount,
      required this.reloginUser,
      required this.read})
      : super(const UserProfileState.initial());

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
        Either<AuthFailure, Unit> reloginResult;
        if (_isPassword) {
          reloginResult = await reloginUser(provider: userAuthProvider, password: _response);
        } else if (_response == AppLocalizations.of(context)!.deleteCap) {
          reloginResult = await reloginUser(provider: userAuthProvider);
        } else {
          reloginResult = left(const AuthFailure.invalidEmailAndPasswordCombination());
        }
        reloginResult.fold(
          (failure) => state = UserProfileState.errorAuth(failure),
          (r) async {
            final deleteResult = await deleteUserAccount();
            deleteResult.fold(
              (failure) => state = UserProfileState.errorAuth(failure),
              (r) => state = const UserProfileState.initial(),
            );
          },
        );
      },
    );
  }

  // TODO save
}
