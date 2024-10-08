import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../features/auth/domain/auth_failure.dart';

part 'sign_in_form_state.freezed.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    required String email,
    required String password,
    required String resetPasswordEmail,
    required bool showErrorMessages,
    required bool showResetPasswordEmailError,
    required bool isSubmitting,
    required Option<AuthFailure> authFailureOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        email: '',
        password: '',
        resetPasswordEmail: '',
        showErrorMessages: false,
        showResetPasswordEmailError: false,
        isSubmitting: false,
        authFailureOption: none(),
      );
}
