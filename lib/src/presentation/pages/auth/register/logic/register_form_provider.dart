import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/auth/application/auth_providers.dart';
import '../../../../../features/auth/domain/use_cases/register_with_email_and_password.dart';
import 'register_form_state.dart';
import 'register_form_state_notifier.dart';

export 'package:prospector/src/presentation/pages/auth/register/logic/register_form_state.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormStateNotifier, RegisterFormState>((ref) {
  final RegisterWithEmailAndPassword _registerWithEmailAndPassword =
      ref.watch(registerWithEmailAndPassword);
  final _signInWithGoogle = ref.watch(signInWithGoogle);
  final _signInWithFacebook = ref.watch(signInWithFacebook);
  final _appleSignIn = ref.watch(appleSignIn);
  return RegisterFormStateNotifier(
    registerWithEmailAndPassword: _registerWithEmailAndPassword,
    signInWithGoogle: _signInWithGoogle,
    signInWithFacebook: _signInWithFacebook,
    appleSignIn: _appleSignIn,
  );
});
