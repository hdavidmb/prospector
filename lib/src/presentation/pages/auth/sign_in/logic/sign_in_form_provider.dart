import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_state.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_state_notifier.dart';

export 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_state.dart';

final signInFormProvider =
    StateNotifierProvider<SignInFormStateNotifier, SignInFormState>((ref) {
  final _signInWithEmailAndPassword = ref.watch(signInWithEmailAndPassword);
  final _signInWithGoogle = ref.watch(signInWithGoogle);
  final _signInWithFacebook = ref.watch(signInWithFacebook);
  final _appleSignIn = ref.watch(appleSignIn);
  final _resetPassword = ref.watch(resetPassword);
  return SignInFormStateNotifier(
    signInWithEmailAndPassword: _signInWithEmailAndPassword,
    signInWithGoogle: _signInWithGoogle,
    signInWithFacebook: _signInWithFacebook,
    appleSignIn: _appleSignIn,
    resetPassword: _resetPassword,
  );
});
