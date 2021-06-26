import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../features/user/domain/failures/user_info_failure.dart';

part 'change_password_form_state.freezed.dart';

@freezed
class ChangePasswordFormState with _$ChangePasswordFormState {
  const factory ChangePasswordFormState({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
    required bool showPasswords,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<UserInfoFailure> failureOption,
  }) = _ChangePasswordFormState;

  factory ChangePasswordFormState.initial() => ChangePasswordFormState(
        currentPassword: '',
        newPassword: '',
        confirmNewPassword: '',
        showPasswords: false,
        showErrorMessages: false,
        isSubmitting: false,
        failureOption: none(),
      );
}
