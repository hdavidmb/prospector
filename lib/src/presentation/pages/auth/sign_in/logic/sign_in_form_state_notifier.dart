import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:prospector/src/features/auth/domain/use_cases/reset_password.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_state.dart';

class SignInFormStateNotifier extends StateNotifier<SignInFormState>
    with FormValidators {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignInWithGoogle signInWithGoogle;
  final SignInWithFacebook signInWithFacebook;
  final AppleSignIn appleSignIn;
  final ResetPassword resetPassword;
  SignInFormStateNotifier({
    required this.signInWithEmailAndPassword,
    required this.signInWithGoogle,
    required this.signInWithFacebook,
    required this.appleSignIn,
    required this.resetPassword,
  })  : super(SignInFormState.initial());

  void reset() => state = SignInFormState.initial();

  void emailChanged(String value) {
    state = state.copyWith(email: value, authFailureOption: none());
  }

  void passwordChanged(String value) {
    state = state.copyWith(password: value, authFailureOption: none());
  }

  void resetPasswordEmailChanged(String value) {
    state =
        state.copyWith(resetPasswordEmail: value, authFailureOption: none());
  }

  Future<void> signInButtonPressed() async {
    final bool isEmailValid = validateEmail(state.email);
    final bool isPasswordValid = validateFieldIsNotEmpty(state.password);

    AuthFailure? _authFailure;

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOption: none(),
      );
      final Either<AuthFailure, Unit> result = await signInWithEmailAndPassword(
          email: state.email, password: state.password);

      result.fold(
        (AuthFailure failure) => _authFailure = failure,
        (_) {},
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOption: optionOf(_authFailure),
    );
  }

  Future<void> googleSignInButtonPressed() async {
    await _socialSignIn(signInWithGoogle);
  }

  Future<void> facebookSignInButtonPressed() async {
    await _socialSignIn(signInWithFacebook);
  }

  Future<void> appleSignInButtonPressed() async {
    await _socialSignIn(appleSignIn);
  }

  Future<void> _socialSignIn(
      Future<Either<AuthFailure, Unit>> Function() callBack) async {
    state = state.copyWith(
      isSubmitting: true,
      authFailureOption: none(),
    );

    AuthFailure? _authFailure;

    final Either<AuthFailure, Unit> result = await callBack();

    result.fold((failure) => _authFailure = failure, (_) {});

    state = state.copyWith(
      isSubmitting: false,
      authFailureOption: optionOf(_authFailure),
    );
  }

  Future<bool> forgotPasswordButtonPressed() async {
    AuthFailure? _authFailure;
    bool _success = false;

    final bool isResetPasswordEmailValid =
        validateEmail(state.resetPasswordEmail);

    if (isResetPasswordEmailValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOption: none(),
      );

      final Either<AuthFailure, Unit> result =
          await resetPassword(email: state.resetPasswordEmail);
      result.fold((failure) => _authFailure = failure, (_) {
        _success = true;
      });
    }

    state = state.copyWith(
      isSubmitting: false,
      showResetPasswordEmailError: !_success,
      authFailureOption: optionOf(_authFailure),
    );

    return _success;
  }
}
