import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../core/dialogs.dart';
import '../logic/change_email_form_provider.dart';
import '../logic/change_email_form_state.dart';

class ChangeEmailForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final formState = watch(changeEmailFormProvider);
    final showErrorMessages = formState.showErrorMessages;
    return ProviderListener<ChangeEmailFormState>(
      provider: changeEmailFormProvider,
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
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.currentEmail,
                  style: const TextStyle(fontSize: 14.0),
                ),
                trailing: Text(
                  watch(userInfoNotifierProvider).user?.email ?? '',
                  style: const TextStyle(fontSize: 17.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: AppLocalizations.of(context)!.newEmail,
                ),
                textInputAction: TextInputAction.next,
                onChanged:
                    context.read(changeEmailFormProvider.notifier).emailChanged,
                validator: (value) {
                  final bool isValid = context
                      .read(changeEmailFormProvider.notifier)
                      .validateEmail(value!);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.invalidEmail;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: AppLocalizations.of(context)!.confirmNewEmail,
                ),
                textInputAction: TextInputAction.done,
                onChanged: context
                    .read(changeEmailFormProvider.notifier)
                    .confirmEmailChanged,
                validator: (value) {
                  final newEmail =
                      context.read(changeEmailFormProvider).newEmail;
                  final bool isValid = context
                      .read(changeEmailFormProvider.notifier)
                      .validateFieldsMatch(newEmail, value);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.emailsDontMatch;
                },
                onFieldSubmitted: (_) => _saveAction(context),
              ),
              const SizedBox(height: 20.0),
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
    final saveSuccess = await context
        .read(changeEmailFormProvider.notifier)
        .saveButtonPressed(context);
    if (saveSuccess) {
      Future.delayed(Duration.zero, () {
        AutoRouter.of(context).pop();
      });
    }
  }
}
