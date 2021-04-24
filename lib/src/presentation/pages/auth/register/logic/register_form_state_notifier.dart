import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/auth/register/logic/register_form_state.dart';

class RegisterFormStateNotifier extends StateNotifier<RegisterFormState> with FormValidators {
  final RegisterWithEmailAndPassword registerWithEmailAndPassword;
  final SignInWithGoogle signInWithGoogle;
  final SignInWithFacebook signInWithFacebook;
  final AppleSignIn appleSignIn;

  RegisterFormStateNotifier({
    required this.registerWithEmailAndPassword,
    required this.signInWithGoogle,
    required this.signInWithFacebook,
    required this.appleSignIn,
    }) : super(RegisterFormState.initial());


  void reset() => state = RegisterFormState.initial();

  void nameChanged(String value) {
    state = state.copyWith(name: value, authFailureOption: none());
  }

  void emailChanged(String value) {
    state = state.copyWith(email: value, authFailureOption: none());
  }

  void passwordChanged(String value) {
    state = state.copyWith(password: value, authFailureOption: none());
  }

  void confirmPasswordChanged(String value) {
    state = state.copyWith(confirmPassword: value, authFailureOption: none());
  }
  
  Future<void> registerButtonPressed() async {
    final bool isNameValid = validateFieldIsNotEmpty(state.name);
    final bool isEmailValid = validateEmail(state.email);
    final bool isPasswordValid = validateFieldIsNotEmpty(state.password) && validatePasswordStrength(state.password);
    final bool isConfirmPasswordValid = validateFieldIsNotEmpty(state.confirmPassword) && validatePasswordsMatch(state.password, state.confirmPassword);

    AuthFailure? _authFailure;

    if (isNameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOption: none(),
      );
      final Either<AuthFailure, Unit> result = await registerWithEmailAndPassword(
          email: state.email, password: state.password, displayName: state.name);

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

    AuthFailure? authFailure;

    final Either<AuthFailure, Unit> result = await callBack();

    result.fold((failure) => authFailure = failure, (_) {});

    state = state.copyWith(
      isSubmitting: false,
      authFailureOption: optionOf(authFailure),
    );
  }


}