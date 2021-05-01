import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/relogin_user.dart';
import 'package:prospector/src/features/auth/domain/use_cases/sign_out.dart';
import 'package:prospector/src/features/images/data/image_picker_repository.dart';
import 'package:prospector/src/features/images/domain/use_cases/get_image.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/use_cases/delete_user_account.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state.dart';

class UserProfileNotifier extends ChangeNotifier {
  final SignOut signOut;
  final ReloginUser reloginUser;
  final DeleteUserAccount deleteUserAccount;
  final GetImage getImage;
  final Reader read;

  UserProfileNotifier(
      {required this.signOut,
      required this.reloginUser,
      required this.deleteUserAccount,
      required this.getImage,
      required this.read});

  UserProfileState _userProfileState = const UserProfileState.initial();
  String? _formName;
  File? _pickedImage;

  UserProfileState get userProfileState => _userProfileState;
  File? get pickedImage => _pickedImage;

  void reset() {
    _userProfileState = const UserProfileState.initial();
    _formName = null;
    _pickedImage = null;
  }

  // ignore: use_setters_to_change_properties
  void nameChanged(String value) => _formName = value;

  Future<void> logOutButtonPressed() async {
    await signOut();
  }

  Future<void> deleteAccountButtonPressed(
      {required BuildContext context}) async {
    _userProfileState = const UserProfileState.submitting();
    notifyListeners();
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
            (failure) {
              _userProfileState = UserProfileState.reloginError(failure);
              notifyListeners();
            },
            (r) async {
              final deleteResult = await deleteUserAccount();
              deleteResult.fold(
                (failure) {
                  _userProfileState = UserProfileState.error(failure);
                  notifyListeners();
                },
                (_) async {
                  await signOut();
                  _userProfileState = const UserProfileState.initial();
                  notifyListeners();
                },
              );
            },
          );
        });
      },
    );
  }

  Future<void> getAvatarImage(BuildContext context) async {
    //TODO ask for source with dialog
    final selectedSource = await showImageSourceDialog(context);
    final Option<File> result = await selectedSource.fold(
      () => none(),
      (source) async {
        return getImage(source: source); //TODO test
      },
    );
    result.fold(
      () => null,
      (file) {
        _pickedImage = file;
        notifyListeners();
      },
    );
  }

  Future<bool> saveButtonPressed() async {
    //TODO validate name is not empty
    if (_pickedImage != null) {
      //TODO save image on storage and get url
    }
    _userProfileState = const UserProfileState.submitting();
    notifyListeners();
    final saveResult = await read(userInfoNotifierProvider)
        .updateUserAuthProfile(displayName: _formName);
    return saveResult.fold(
      (failure) {
        _userProfileState = UserProfileState.error(failure);
        notifyListeners();
        return false;
      },
      (_) {
        _userProfileState = const UserProfileState.initial();
        notifyListeners();
        return true;
      },
    );
  }
}
