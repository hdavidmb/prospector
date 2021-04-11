import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/register/logic/register_form_provider.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterFormState>(
      provider: registerFormProvider.state,
      onChange: (context, state) {
        state.authFailureOption.fold(
          () {},
          (failure) => failure.maybeWhen(
              serverError: () => showSnackBar(context: context, message: AppLocalizations.of(context).serverError),
              emailAlreadyInUse: () => showSnackBar(context: context, message: AppLocalizations.of(context).emailAlreadyInUse),
              accountExistsWithDifferentCredential: () =>
                  showSnackBar(context: context, message: AppLocalizations.of(context).accountWithDifferentCredentials),
              orElse: () {}
            ),
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final RegisterFormState formState = watch(registerFormProvider.state);
          final bool showErrorMessages = formState.showErrorMessages;
          const double socialButtonsSize = 45.0;
          final bool isDarkTheme =
              Theme.of(context).brightness == Brightness.dark;

          return Form(
            autovalidateMode: showErrorMessages
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_circle),
                    hintText: AppLocalizations.of(context).name,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: context.read(registerFormProvider).nameChanged,
                  validator: (value) {
                    final bool isValid = context
                        .read(registerFormProvider)
                        .validateFieldIsNotEmpty(value);
                    return isValid ? null : AppLocalizations.of(context).enterYourName;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: AppLocalizations.of(context).email,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: context.read(registerFormProvider).emailChanged,
                  validator: (value) {
                    final bool isValid =
                        context.read(registerFormProvider).validateEmail(value);
                    return isValid ? null : AppLocalizations.of(context).invalidEmail;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppLocalizations.of(context).password,
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onChanged: context.read(registerFormProvider).passwordChanged,
                  validator: (value) {
                    final bool isNotEmpty = context
                        .read(registerFormProvider)
                        .validateFieldIsNotEmpty(value);
                    final bool isStrongEnough = context
                        .read(registerFormProvider)
                        .validatePasswordStrength(value);
                    return isNotEmpty
                        ? isStrongEnough
                            ? null
                            : AppLocalizations.of(context).weakPassword
                        : AppLocalizations.of(context).enterAPassword;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppLocalizations.of(context).confirmPassword,
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onChanged: (value) => context
                      .read(registerFormProvider)
                      .confirmPasswordChanged(value),
                  validator: (value) {
                    final RegisterFormState _registerFormState =
                        context.read(registerFormProvider.state);
                    final bool isNotEmpty = context
                        .read(registerFormProvider)
                        .validateFieldIsNotEmpty(value);
                    final bool passwordsMatch = context
                        .read(registerFormProvider)
                        .validatePasswordsMatch(
                            _registerFormState.password, value);
                    return isNotEmpty
                        ? passwordsMatch
                            ? null
                            : AppLocalizations.of(context).passwordsDontMatch
                        : AppLocalizations.of(context).enterAPassword;
                  },
                  onFieldSubmitted: (_) => context
                      .read(registerFormProvider)
                      .registerButtonPressed(),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: formState.isSubmitting
                        ? null
                        : context
                            .read(registerFormProvider)
                            .registerButtonPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context).registerButton),
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              SignInPage())); //TODO: implement proper routing
                    },
                    child: Text(AppLocalizations.of(context).signIn,
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
                                  .read(registerFormProvider)
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
                                .read(registerFormProvider)
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
                                .read(registerFormProvider)
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
