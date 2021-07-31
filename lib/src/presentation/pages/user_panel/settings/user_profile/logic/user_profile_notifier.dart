import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/auth/domain/auth_failure.dart';
import '../../../../../../features/auth/domain/use_cases/relogin_user.dart';
import '../../../../../../features/auth/domain/use_cases/sign_out.dart';
import '../../../../../../features/images/domain/use_cases/get_image.dart';
import '../../../../../../features/storage/domain/use_cases/upload_user_avatar.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../../features/user/domain/failures/user_info_failure.dart';
import '../../../../../../features/user/domain/use_cases/delete_user_account.dart';
import '../../../../../core/dialogs.dart';
import '../../../../../helpers/form_validators.dart';
import 'user_profile_state.dart';

class UserProfileNotifier extends ChangeNotifier with FormValidators {
  final SignOut signOut;
  final ReloginUser reloginUser;
  final DeleteUserAccount deleteUserAccount;
  final UploadUserAvatar uploadUserAvatar;
  final GetImage getImage;
  final Reader read;

  UserProfileNotifier(
      {required this.signOut,
      required this.reloginUser,
      required this.deleteUserAccount,
      required this.uploadUserAvatar,
      required this.getImage,
      required this.read});

  UserProfileState _userProfileState = const UserProfileState.initial();
  String? _formName;
  File? _pickedImage;
  bool _showInputErrorMessage = false;

  UserProfileState get userProfileState => _userProfileState;
  File? get pickedImage => _pickedImage;
  bool get showInputErrorMessage => _showInputErrorMessage;

  void reset() {
    _userProfileState = const UserProfileState.initial();
    _showInputErrorMessage = false;
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
    final response = await showDeleteAccountConfirmDialog(
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
    final selectedSource = await showImageSourceDialog(context);
    final Option<File> result = await selectedSource.fold(
      () => none(),
      (source) async {
        return getImage(source: source);
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

  bool validateName() {
    _showInputErrorMessage = true;
    notifyListeners();
    return validateFieldIsNotEmpty(_formName!);
  }

  Future<bool> saveButtonPressed() async {
    if (_formName == null && _pickedImage == null) return true;
    // * Something changed

    _userProfileState = const UserProfileState.submitting();
    notifyListeners();

    if (_formName != null) {
      final bool isNameValid = validateName();
      if (!isNameValid) return false;
    }
    // * name didn't change or is valid

    String? downloadURL;
    if (_pickedImage != null) {
      bool failed = false;
      final uid = read(userInfoNotifierProvider).user.uid;
      final uploadResult =
          await uploadUserAvatar(uid: uid, image: _pickedImage!);
      uploadResult.fold(
        (failure) {
          failure.maybeWhen(noConnection: () {
            _userProfileState =
                const UserProfileState.error(UserInfoFailure.noConnection());
          }, orElse: () {
            _userProfileState =
                const UserProfileState.error(UserInfoFailure.serverError());
          });
          notifyListeners();
          failed = true;
        },
        (url) => downloadURL = url,
      );
      if (failed) return false;
    }
    // * image didn't change or successfully uploaded

    // * (nameChanged AND is valid) or (image changed AND succesfully uploaded)
    final saveResult = await read(userInfoNotifierProvider)
        .updateUserAuthProfile(displayName: _formName, photoURL: downloadURL);
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
