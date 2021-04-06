import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_provider.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_state.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final bool showErrorMessages =
          watch(signInFormProvider.state).showErrorMessages;
      return ProviderListener<SignInFormState>(
        provider: signInFormProvider.state,
        onChange: (context, state) {
          state.authFailureOption.fold(
              () {},
              (failure) => failure.when(
                  cancelledByUser: () => debugPrint('Snackbar: Canceled'),
                  serverError: () => debugPrint('Snackbar: Server error'),
                  emailAlreadyInUse: () {},
                  invalidEmailAndPasswordCombination: () => debugPrint('Snackbar: Invalid email and password combination')));
        },
        child: Form(
          autovalidateMode: showErrorMessages
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email', //TODO localize
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) =>
                    context.read(signInFormProvider).emailChanged(value),
                validator: (value) {
                  final bool isValid =
                      context.read(signInFormProvider).validateEmail(value);
                  return isValid ? null : 'Invalid Email'; //TODO localize
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password', //TODO localize
                ),
                textInputAction: TextInputAction.done,
                obscureText: true,
                onChanged: (value) =>
                    context.read(signInFormProvider).passwordChanged(value),
                validator: (value) {
                  final bool isValid = context
                      .read(signInFormProvider)
                      .validatePasswordInput(value);
                  return isValid ? null : 'Enter password'; //TODO localize
                },
                onFieldSubmitted: (_) =>
                    context.read(signInFormProvider).signInButtonPressed(),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      context.read(signInFormProvider).signInButtonPressed,
                  child: const Text('Sign In'), //TODO localize
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
