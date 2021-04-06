import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';

part 'sign_in_form_state.freezed.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required String email,
    @required String password,
    @required bool showErrorMessages,
    @required bool isSubmitting,
    @required Option<AuthFailure> authFailureOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        email: '',
        password: '',
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOption: none(),
      );
}
