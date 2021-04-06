import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/auth/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_state.dart';
import 'package:meta/meta.dart';

class SignInFormStateNotifier extends StateNotifier<SignInFormState>
    with FormValidators {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  SignInFormStateNotifier({@required this.signInWithEmailAndPassword})
      : super(SignInFormState.initial());

  void reset() => state = SignInFormState.initial();

  void emailChanged(String email) {
    state = state.copyWith( //TODO test if "state =" is nedded
      email: email,
      authFailureOption: none()
    );
  }

  void passwordChanged(String password) {
    state = state.copyWith( //TODO test if "state =" is nedded
      password: password,
      authFailureOption: none()
    );
  }

  Future<void> signInButtonPressed() async {
    //TODO validate email and password
    final bool isEmailValid = validateEmail(state.email);
    final bool isPasswordValid = validatePasswordInput(state.password);

    AuthFailure authFailure;

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith( //TODO test if "state =" is nedded
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

    state = state.copyWith( //TODO test if "state =" is nedded
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOption: optionOf(authFailure),
    );
  }
}
