import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/dialogs.dart';
import '../logic/change_password_form_provider.dart';
import '../logic/change_password_form_state.dart';

class ChangePasswordForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ChangePasswordFormState formState = watch(changePasswordFormProvider);
    final bool showErrorMessages = formState.showErrorMessages;
    final bool showPasswords = formState.showPasswords;
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return ProviderListener<ChangePasswordFormState>(
      provider: changePasswordFormProvider,
      onChange: (context, state) {
        state.failureOption.fold(
          () {},
          (failure) => showFailureSnackbar(context, failure),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          autovalidateMode: showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!.currentPassword,
                ),
                textInputAction: TextInputAction.next,
                obscureText: !showPasswords,
                onChanged: context
                    .read(changePasswordFormProvider.notifier)
                    .currentPasswordChanged,
                validator: (value) {
                  final bool isValid = context
                      .read(changePasswordFormProvider.notifier)
                      .validateFieldIsNotEmpty(value!);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.enterAPassword;
                },
              ),
              const SizedBox(height: 20.0),
              const Divider(height: 0.0),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!.newPassword,
                ),
                textInputAction: TextInputAction.next,
                obscureText: !showPasswords,
                onChanged: context
                    .read(changePasswordFormProvider.notifier)
                    .newPasswordChanged,
                validator: (value) {
                  final bool isValid = context
                      .read(changePasswordFormProvider.notifier)
                      .validatePasswordStrength(value!);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.weakPassword;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: AppLocalizations.of(context)!.confirmNewPassword,
                ),
                textInputAction: TextInputAction.done,
                obscureText: !showPasswords,
                onChanged: context
                    .read(changePasswordFormProvider.notifier)
                    .confirmNewPasswordChanged,
                onFieldSubmitted:
                    formState.isSubmitting ? null : (_) => _saveAction(context),
                validator: (value) {
                  final bool isValid = context
                      .read(changePasswordFormProvider.notifier)
                      .validateFieldsMatch(formState.newPassword, value);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.passwordsDontMatch;
                },
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  onPressed: context
                      .read(changePasswordFormProvider.notifier)
                      .showHidePasswords,
                  child: Text(
                    showPasswords
                        ? AppLocalizations.of(context)!.hidePasswords
                        : AppLocalizations.of(context)!.showPasswords,
                    style: TextStyle(
                        color: isDarkTheme ? Colors.white70 : Colors.black87),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed:
                    formState.isSubmitting ? null : () => _saveAction(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.save),
                    if (formState.isSubmitting) ...const [
                      SizedBox(width: 8.0),
                      CircularProgressIndicator.adaptive(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAction(BuildContext context) async {
    final bool saveSuccess = await context
        .read(changePasswordFormProvider.notifier)
        .saveButtonPressed();
    if (saveSuccess) Navigator.of(context).pop();
  }
}
