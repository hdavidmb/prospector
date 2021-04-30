import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';

import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';

void showAuthFailureSnackbar(BuildContext context, dynamic failure) {
  //TODO move to dialogs
  if (failure == const AuthFailure.serverError() ||
      failure == const DatabaseFailure.serverError() ||
      failure == const UserInfoFailure.serverError()) {
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
  } else if (failure == const AuthFailure.noConnection() ||
      failure == const DatabaseFailure.noConnection() ||
      failure == const UserInfoFailure.noConnection()) {
        showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.noConnectionMessage);
      }
}
