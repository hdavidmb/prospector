import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_provider.dart';

void showSnackBar({@required BuildContext context, @required String message}) {
  showFlash(
    context: context,
    duration: const Duration(milliseconds: 4000),
    builder: (context, controller) {
      return Flash.bar(
        controller: controller,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.all(10.0),
        borderRadius: BorderRadius.circular(8.0),
        child: FlashBar(
          icon: Icon(Icons.info, color: Theme.of(context).primaryColor),
          leftBarIndicatorColor: Theme.of(context).primaryColor,
          message: Text(
            message,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      );
    },
  );
}

void showResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, watch, child) {
          final bool showErrorMessages =
              watch(signInFormProvider.state).showResetPasswordEmailError;
          return AlertDialog(
            title: Text(AppLocalizations.of(context).resetPassword,
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context).resetPasswordDialogMessage),
                const SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.send,
                  initialValue:
                      context.read(signInFormProvider.state).resetPasswordEmail,
                      autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).email,
                  ),
                  autovalidateMode: showErrorMessages
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  onChanged: context
                      .read(signInFormProvider)
                      .resetPasswordEmailChanged,
                  validator: (value) {
                    final bool isValid =
                        context.read(signInFormProvider).validateEmail(value);
                    return isValid ? null : AppLocalizations.of(context).invalidEmail;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context).cancel)),
              TextButton(
                onPressed: () async {
                  final bool success = await context
                      .read(signInFormProvider)
                      .forgotPasswordButtonPressed();
                  if (success) {
                    Navigator.of(context).pop();
                    showMessageDialog(
                        context: context,
                        message:
                            AppLocalizations.of(context).resetPasswordEmailSent);
                  }
                },
                child: Text(AppLocalizations.of(context).send),
              ),
            ],
          );
        },
      );
    },
  );
}

void showMessageDialog(
    {@required BuildContext context, String title, @required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context).ok)),
        ],
      );
    },
  );
}
