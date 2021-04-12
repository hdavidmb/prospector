import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/domain/use_cases/register_with_email_and_password.dart';
import 'package:prospector/src/presentation/pages/register/logic/register_form_state.dart';
import 'package:prospector/src/presentation/pages/register/logic/register_form_state_notifier.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';

export 'package:prospector/src/presentation/pages/register/logic/register_form_state.dart';

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
