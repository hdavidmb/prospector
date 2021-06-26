import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../features/user/domain/failures/user_info_failure.dart';

part 'change_email_form_state.freezed.dart';

@freezed
class ChangeEmailFormState with _$ChangeEmailFormState {
  const factory ChangeEmailFormState({
    required String newEmail,
    required String confirmNewEmail,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<UserInfoFailure> failureOption,
  }) = _ChangeEmailFormState;

  factory ChangeEmailFormState.initial() => ChangeEmailFormState(
        newEmail: '',
        confirmNewEmail: '',
        showErrorMessages: false,
        isSubmitting: false,
        failureOption: none(),
      );
}
