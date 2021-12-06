import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../core/dialogs.dart';
import '../../../../routes/app_router.gr.dart';
import '../logic/register_form_provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterFormState>(
      provider: registerFormProvider,
      onChange: (context, state) {
        state.authFailureOption.fold(
          () {},
          (failure) => showFailureSnackbar(context, failure),
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final RegisterFormState formState = watch(registerFormProvider);
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
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_circle),
                    hintText: AppLocalizations.of(context).name,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged:
                      context.read(registerFormProvider.notifier).nameChanged,
                  validator: (value) {
                    final bool isValid = context
                        .read(registerFormProvider.notifier)
                        .validateFieldIsNotEmpty(value!);
                    return isValid
                        ? null
                        : AppLocalizations.of(context).enterYourName;
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
                  onChanged:
                      context.read(registerFormProvider.notifier).emailChanged,
                  validator: (value) {
                    final bool isValid = context
                        .read(registerFormProvider.notifier)
                        .validateEmail(value!);
                    return isValid
                        ? null
                        : AppLocalizations.of(context).invalidEmail;
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
                  onChanged: context
                      .read(registerFormProvider.notifier)
                      .passwordChanged,
                  validator: (value) {
                    final bool isNotEmpty = context
                        .read(registerFormProvider.notifier)
                        .validateFieldIsNotEmpty(value!);
                    final bool isStrongEnough = context
                        .read(registerFormProvider.notifier)
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
                      .read(registerFormProvider.notifier)
                      .confirmPasswordChanged(value),
                  validator: (value) {
                    final RegisterFormState _registerFormState =
                        context.read(registerFormProvider);
                    final bool isNotEmpty = context
                        .read(registerFormProvider.notifier)
                        .validateFieldIsNotEmpty(value!);
                    final bool passwordsMatch = context
                        .read(registerFormProvider.notifier)
                        .validateFieldsMatch(
                            _registerFormState.password, value);
                    return isNotEmpty
                        ? passwordsMatch
                            ? null
                            : AppLocalizations.of(context).passwordsDontMatch
                        : AppLocalizations.of(context).enterAPassword;
                  },
                  onFieldSubmitted: (_) => context
                      .read(registerFormProvider.notifier)
                      .registerButtonPressed(),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: formState.isSubmitting
                        ? null
                        : context
                            .read(registerFormProvider.notifier)
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
                    onPressed: () =>
                        AutoRouter.of(context).replace(const SignInRoute()),
                    child: Text(AppLocalizations.of(context).signIn,
                        style: TextStyle(
                            color:
                                isDarkTheme ? Colors.white70 : Colors.black87)),
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
                                  .read(registerFormProvider.notifier)
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
                                .read(registerFormProvider.notifier)
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
                                .read(registerFormProvider.notifier)
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
