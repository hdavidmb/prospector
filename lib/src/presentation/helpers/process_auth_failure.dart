import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';

void showAuthFailureSnackbar(BuildContext context, AuthFailure failure) {
  if (failure == const AuthFailure.serverError()) {
    showSnackBar(
        context: context, message: AppLocalizations.of(context)!.serverError);
  } else if (failure ==
      const AuthFailure.invalidEmailAndPasswordCombination()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.invalidEmailAndPassword);
  } else if (failure ==
      const AuthFailure.accountExistsWithDifferentCredential()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.accountWithDifferentCredentials);
  } else if (failure == const AuthFailure.userNotFoundResetPassword()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.userNotFoundResetPassword);
  } else if (failure == const AuthFailure.emailAlreadyInUse()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.emailAlreadyInUse);
  }
}
