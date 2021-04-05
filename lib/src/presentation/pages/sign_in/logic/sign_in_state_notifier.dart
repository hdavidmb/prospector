import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_state.dart';

class SignInStateNotifier extends StateNotifier<SignInState> {
  SignInStateNotifier() : super(const SignInState.initial());

  

}