import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/register/register_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_provider.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SignInFormState>(
      provider: signInFormProvider.state,
      onChange: (context, state) {
        state.authFailureOption.fold(
          () {},
          (failure) => failure.maybeWhen(
              serverError: () => showSnackBar(context: context, message: AppLocalizations.of(context).serverError),
              invalidEmailAndPasswordCombination: () =>
                  showSnackBar(context: context, message: AppLocalizations.of(context).invalidEmailAndPassword),
              accountExistsWithDifferentCredential: () =>
                  showSnackBar(context: context, message: AppLocalizations.of(context).accountWithDifferentCredentials),
              userNotFoundResetPassword: () => showSnackBar(context: context, message: AppLocalizations.of(context).userNotFoundResetPassword),
              orElse: () {},
            ),
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final SignInFormState formState = watch(signInFormProvider.state);
          final bool showErrorMessages = formState.showErrorMessages;
          const double socialButtonsSize = 45.0;
          final bool isDarkTheme =
              Theme.of(context).brightness == Brightness.dark;

          return Form(
            autovalidateMode: showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: AppLocalizations.of(context).email,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: context.read(signInFormProvider).emailChanged,
                  validator: (value) {
                    final bool isValid =
                        context.read(signInFormProvider).validateEmail(value);
                    return isValid ? null : AppLocalizations.of(context).invalidEmail;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppLocalizations.of(context).password,
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onChanged: context.read(signInFormProvider).passwordChanged,
                  validator: (value) {
                    final bool isValid = context
                        .read(signInFormProvider)
                        .validateFieldIsNotEmpty(value);
                    return isValid ? null : AppLocalizations.of(context).enterAPassword;
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
                        Text(AppLocalizations.of(context).signIn),
                        if (formState.isSubmitting) ... const [
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
                    onPressed: formState.isSubmitting
                        ? null
                        : () {
                            // Init reset password email with current email value
                            final String currentEmail =
                                context.read(signInFormProvider.state).email;
                            context
                                .read(signInFormProvider)
                                .resetPasswordEmailChanged(currentEmail);
                            showResetPasswordDialog(context);
                          },
                    child: Text(AppLocalizations.of(context).forgotPassword,
                        style: TextStyle(
                            color: isDarkTheme
                                ? Colors.white70
                                : Colors.black87)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage())); //TODO: implement proper routing
                    },
                    child: Text(AppLocalizations.of(context).register,
                        style: TextStyle(
                            color: isDarkTheme
                                ? Colors.white70
                                : Colors.black87)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 8.0),
                  child: Text(AppLocalizations.of(context).orContinueWith,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
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
                              : context
                                  .read(signInFormProvider)
                                  .appleSignInButtonPressed,
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
                            : context
                                .read(signInFormProvider)
                                .facebookSignInButtonPressed,
                        child: const FaIcon(FontAwesomeIcons.facebookF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
