import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/domain/use_cases/relogin_user.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/features/user/domain/use_cases/change_user_password.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/change_password/logic/change_password_form_state.dart';

class ChangePasswordFormStateNotifier
    extends StateNotifier<ChangePasswordFormState> with FormValidators {
  final ReloginUser reloginUser;
  final ChangeUserPassword changeUserPassword;
  final Reader read;
  ChangePasswordFormStateNotifier({
    required this.reloginUser,
    required this.changeUserPassword,
    required this.read,
  }) : super(ChangePasswordFormState.initial());

  void reset() => state = ChangePasswordFormState.initial();

  void currentPasswordChanged(String value) {
    state = state.copyWith(currentPassword: value, failureOption: none());
  }

  void newPasswordChanged(String value) {
    state = state.copyWith(newPassword: value, failureOption: none());
  }

  void confirmNewPasswordChanged(String value) {
    state = state.copyWith(confirmNewPassword: value, failureOption: none());
  }

  void showHidePasswords() {
    state = state.copyWith(showPasswords: !state.showPasswords);
  }

  Future<bool> saveButtonPressed() async {
    // Validate fields
    final bool isCurrentPasswordValid =
        validateFieldIsNotEmpty(state.currentPassword);
    final bool isNewPasswordValid = validatePasswordStrength(state.newPassword);
    final bool isConfirmNewPasswordValid =
        validateFieldsMatch(state.newPassword, state.confirmNewPassword);

    UserInfoFailure? failure;
    bool success = false;

    if (isCurrentPasswordValid &&
        isNewPasswordValid &&
        isConfirmNewPasswordValid) {

      // Change to submitting state
      state = state.copyWith(
        isSubmitting: true,
        failureOption: none(),
      );

      // Relogin user
      final userAuthProvider = read(userInfoNotifierProvider).getUserProvider();
      final reloginResult = await reloginUser(
          provider: userAuthProvider, password: state.currentPassword);

      await reloginResult.fold(
        (reloginFailure) {
          failure = reloginFailure.maybeWhen(
              noConnection: () => const UserInfoFailure.noConnection(),
              invalidEmailAndPasswordCombination: () =>
                  const UserInfoFailure.invalidEmailAndPasswordCombination(),
              orElse: () => const UserInfoFailure.serverError());
        },
        (_) async {
          // Change user password
          final changeResult =
              await changeUserPassword(newPassword: state.newPassword);
          changeResult.fold(
            (changeFailure) => failure = changeFailure,
            (_) => success = true,
          );
        },
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      failureOption: optionOf(failure),
    );
    return success;
  }
}
