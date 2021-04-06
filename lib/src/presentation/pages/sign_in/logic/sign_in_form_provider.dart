import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_state_notifier.dart';

final signInFormProvider = StateNotifierProvider<SignInFormStateNotifier>((ref) {
  final _signInWithEmailAndPassword = ref.watch(signInWithEmailAndPassword);
    return SignInFormStateNotifier(signInWithEmailAndPassword: _signInWithEmailAndPassword);
});