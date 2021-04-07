import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_state.dart';
import 'package:meta/meta.dart';

class SignInFormStateNotifier extends StateNotifier<SignInFormState>
    with FormValidators {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignInWithGoogle signInWithGoogle;
  final SignInWithFacebook signInWithFacebook;
  SignInFormStateNotifier({
    @required this.signInWithGoogle,
    @required this.signInWithEmailAndPassword,
    @required this.signInWithFacebook,
  }) : assert(signInWithGoogle != null, signInWithEmailAndPassword != null),
        super(SignInFormState.initial());

  void reset() => state = SignInFormState.initial();

  void emailChanged(String email) {
    state = state.copyWith(email: email, authFailureOption: none());
  }

  void passwordChanged(String password) {
    state = state.copyWith(password: password, authFailureOption: none());
  }

  Future<void> signInButtonPressed() async {
    final bool isEmailValid = validateEmail(state.email);
    final bool isPasswordValid = validatePasswordInput(state.password);

    AuthFailure authFailure;

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOption: none(),
      );
      final Either<AuthFailure, Unit> result = await signInWithEmailAndPassword(
          email: state.email, password: state.password);

      result.fold(
        (AuthFailure failure) => authFailure = failure,
        (_) {},
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOption: optionOf(authFailure),
    );
  }

  Future<void> googleSignInButtonPressed() async {
    state = state.copyWith(
      isSubmitting: true,
      authFailureOption: none(),
    );

    AuthFailure authFailure;
    final Either<AuthFailure, Unit> result = await signInWithGoogle();

    result.fold((failure) => authFailure = failure, (_) {});

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOption: optionOf(authFailure),
    );
  }

  Future<void> facebookSignInButtonPressed() async {
    state = state.copyWith(
      isSubmitting: true,
      authFailureOption: none(),
    );

    AuthFailure authFailure;
    final Either<AuthFailure, Unit> result = await signInWithFacebook();

    result.fold((failure) => authFailure = failure, (_) {});

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOption: optionOf(authFailure),
    );
  }
}
