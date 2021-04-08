import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_provider.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_state.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final SignInFormState formState = watch(signInFormProvider.state);
      final bool showErrorMessages = formState.showErrorMessages;
      const double socialButtonsSize = 45.0;
      final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

      return ProviderListener<SignInFormState>(
        provider: signInFormProvider.state,
        onChange: (context, state) {
          state.authFailureOption.fold(
            () {},
            (failure) => failure.when(
              //TODO implement snackbars (Flushbar package)
              cancelledByUser: () => debugPrint('Snackbar: Canceled'),
              serverError: () => debugPrint('Snackbar: Server error'),
              emailAlreadyInUse: () {},
              invalidEmailAndPasswordCombination: () => debugPrint(
                  'Snackbar: Invalid email and password combination'),
              accountExistsWithDifferentCredential: () => debugPrint(
                  'Snackbar: Account exists with different credential')
            ),
          );
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
                  onPressed: formState.isSubmitting
                      ? null
                      : context.read(signInFormProvider).signInButtonPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign In'), //TODO localize
                      if (formState.isSubmitting) ...const [
                        SizedBox(width: 8.0),
                        CircularProgressIndicator.adaptive(),
                      ],
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () {},
                  child: Text('Forgot your password?',
                      style: TextStyle(color: isDarkTheme ? Colors.white70 : Colors.black87)), //TODO localize
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: () {},
                  child: Text('Register',
                      style: TextStyle(color: isDarkTheme ? Colors.white70 : Colors.black87)), //TODO localize
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 8.0),
                child: Text('- or continue with - ',
                    style: Theme.of(context).textTheme.subtitle1),
              ), //TODO localize
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (Platform.isIOS) ...[
                    SizedBox(
                      height: socialButtonsSize,
                      width: socialButtonsSize,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: formState.isSubmitting
                          ? null
                          : context.read(signInFormProvider).appleSignInButtonPressed,
                        child: const FaIcon(
                          FontAwesomeIcons.apple,
                          color: Colors.black,
                          size: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                  SizedBox(
                    height: socialButtonsSize,
                    width: socialButtonsSize,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: const EdgeInsets.all(9.0)),
                      onPressed: formState.isSubmitting
                          ? null
                          : context
                              .read(signInFormProvider)
                              .googleSignInButtonPressed,
                      child: const Image(
                          image: AssetImage('assets/icons/google_logo.png')),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: socialButtonsSize,
                    width: socialButtonsSize,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff3b5998)),
                      onPressed: formState.isSubmitting
                          ? null
                          : context.read(signInFormProvider).facebookSignInButtonPressed,
                      child: const FaIcon(FontAwesomeIcons.facebookF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
