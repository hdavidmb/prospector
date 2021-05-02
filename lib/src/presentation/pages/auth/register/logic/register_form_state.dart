import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';

part 'register_form_state.freezed.dart';

@freezed
class RegisterFormState with _$RegisterFormState{
  const factory RegisterFormState({

    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<AuthFailure> authFailureOption,
  }) = _RegisterFormState;

  factory RegisterFormState.initial() => RegisterFormState(
        name: '',
        email: '',
        password: '',
        confirmPassword: '',
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOption: none(),
      );
}