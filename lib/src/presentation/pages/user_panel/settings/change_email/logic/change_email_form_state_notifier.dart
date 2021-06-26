import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/auth/domain/use_cases/relogin_user.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../../features/user/domain/failures/user_info_failure.dart';
import '../../../../../core/dialogs.dart';
import '../../../../../helpers/form_validators.dart';
import 'change_email_form_state.dart';

class ChangeEmailFormStateNotifier extends StateNotifier<ChangeEmailFormState>
    with FormValidators {
  final ReloginUser reloginUser;
  final Reader read;
  ChangeEmailFormStateNotifier({
    required this.reloginUser,
    required this.read,
  }) : super(ChangeEmailFormState.initial());

  void reset() => state = ChangeEmailFormState.initial();

  void emailChanged(String value) {
    state = state.copyWith(newEmail: value, failureOption: none());
  }

  void confirmEmailChanged(String value) {
    state = state.copyWith(confirmNewEmail: value, failureOption: none());
  }

  Future<bool> saveButtonPressed(BuildContext context) async {
    // Validate form fields
    final bool isNewEmailValid = validateEmail(state.newEmail);
    final bool isConfirmEmailValid =
        validateFieldsMatch(state.newEmail, state.confirmNewEmail);

    UserInfoFailure? failure;
    bool success = false;

    if (isNewEmailValid && isConfirmEmailValid) {
      // Change to submitting state
      state = state.copyWith(
        isSubmitting: true,
        failureOption: none(),
      );

      // Ask for password and relogin user
      final passwordResponse =
          await showReloginPasswordDialog(context: context);

      await passwordResponse.fold(
        () => null,
        (password) async {
          final userAuthProvider =
              read(userInfoNotifierProvider).getUserProvider();
          final reloginResult =
              await reloginUser(provider: userAuthProvider, password: password);

          await reloginResult.fold(
            (reloginFailure) {
              failure = reloginFailure.maybeWhen(
                  noConnection: () => const UserInfoFailure.noConnection(),
                  invalidEmailAndPasswordCombination: () =>
                      const UserInfoFailure
                          .invalidEmailAndPasswordCombination(),
                  orElse: () => const UserInfoFailure.serverError());
            },
            (_) async {
              final changeResult = await read(userInfoNotifierProvider)
                  .changeEmail(newEmail: state.newEmail);
              changeResult.fold(
                (changeFailure) => failure = changeFailure,
                (_) => success = true,
              );
            },
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
