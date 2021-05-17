import 'package:dartz/dartz.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// ignore: implementation_imports
import 'package:google_maps_webservice/src/places.dart' show Prediction;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/images/domain/sources/source_image.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/core/private/private_keys.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/tags_selection_wrap/tags_selection_wrap.dart';

enum SnackbarType { failure, success, warning }

void showSnackBar({
  required BuildContext context,
  required String message,
  required SnackbarType type,
}) {
  late Color color;
  late IconData icon;
  switch (type) {
    case SnackbarType.failure:
      color = Colors.red[600]!;
      icon = Icons.info;
      break;
    case SnackbarType.success:
      color = Colors.green[600]!;
      icon = Icons.check;
      break;
    case SnackbarType.warning:
      color = Colors.amber;
      icon = Icons.warning;
      break;
  }

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
          icon: Icon(
            icon,
            color: color,
          ),
          leftBarIndicatorColor: color,
          message: Text(
            message,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      );
    },
  );
}

void showFailureSnackbar(BuildContext context, dynamic failure) {
  if (failure == const AuthFailure.serverError() ||
      failure == const DatabaseFailure.serverError() ||
      failure == const UserInfoFailure.serverError()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.serverError,
        type: SnackbarType.failure);
  } else if (failure ==
          const AuthFailure.invalidEmailAndPasswordCombination() ||
      failure == const UserInfoFailure.invalidEmailAndPasswordCombination()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.invalidEmailAndPassword,
        type: SnackbarType.failure);
  } else if (failure ==
      const AuthFailure.accountExistsWithDifferentCredential()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.accountWithDifferentCredentials,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.userNotFoundResetPassword()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.userNotFoundResetPassword,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.emailAlreadyInUse() ||
      failure == const UserInfoFailure.emailAlreadyInUse()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.emailAlreadyInUse,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.noConnection() ||
      failure == const DatabaseFailure.noConnection() ||
      failure == const UserInfoFailure.noConnection()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.noConnectionMessage,
        type: SnackbarType.failure);
  }
}

void showResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, watch, child) {
          final bool showErrorMessages =
              watch(signInFormProvider).showResetPasswordEmailError;
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.resetPassword,
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.resetPasswordDialogMessage),
                const SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.send,
                  initialValue:
                      context.read(signInFormProvider).resetPasswordEmail,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.email,
                  ),
                  autovalidateMode: showErrorMessages
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  onChanged: context
                      .read(signInFormProvider.notifier)
                      .resetPasswordEmailChanged,
                  validator: (value) {
                    final bool isValid = context
                        .read(signInFormProvider.notifier)
                        .validateEmail(value!);
                    return isValid
                        ? null
                        : AppLocalizations.of(context)!.invalidEmail;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.cancel)),
              TextButton(
                onPressed: () async {
                  final bool success = await context
                      .read(signInFormProvider.notifier)
                      .forgotPasswordButtonPressed();
                  if (success) {
                    Navigator.of(context).pop();
                    showMessageDialog(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .resetPasswordEmailSent);
                  }
                },
                child: Text(AppLocalizations.of(context)!.send),
              ),
            ],
          );
        },
      );
    },
  );
}

void showMessageDialog(
    {required BuildContext context, String? title, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.ok)),
        ],
      );
    },
  );
}

Future<bool> showDeleteConfirmDialog(
    {required BuildContext context, String? title, String? message}) async {
  final response = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: (message != null && message.isNotEmpty) ? Text(message) : null,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      );
    },
  );
  return response ?? false;
}

Future<Option<String>> showDeleteAccountConfirmDialog(
    {required BuildContext context, required bool isPassword}) async {
  final title = Text(AppLocalizations.of(context)!.areYouSureDeleteAccount);
  final content = isPassword
      ? Text(
          '${AppLocalizations.of(context)!.thisAcctionCannotBeUndone} ${AppLocalizations.of(context)!.enterYourPasswordToConfirm}',
          style: Theme.of(context).textTheme.bodyText1,
        )
      : RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:
                    '${AppLocalizations.of(context)!.thisAcctionCannotBeUndone} ${AppLocalizations.of(context)!.typeTheWord} ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                  text: AppLocalizations.of(context)!.deleteCap,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold)),
              TextSpan(
                text: ' ${AppLocalizations.of(context)!.toConfirm}\n',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.youMayHaveToRelogin,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w200, fontSize: 13.0),
              ),
            ],
          ),
        );
  return showTextFieldDialog(
    context: context,
    title: title,
    content: content,
    isPassword: isPassword,
    hintText: isPassword //TODO test
        ? AppLocalizations.of(context)!.password
        : AppLocalizations.of(context)!.typeHere,
  );
}

Future<Option<String>> showReloginPasswordDialog(
    {required BuildContext context}) {
  final title = Text(AppLocalizations.of(context)!.reauthenticate);
  final content = Text(AppLocalizations.of(context)!.reauthMessage);
  return showTextFieldDialog(
      context: context,
      title: title,
      content: content,
      isPassword: true,
      hintText: AppLocalizations.of(context)!.password); //TODO test
}

Future<Option<String>> showTextFieldDialog(
    {required BuildContext context,
    Widget? title,
    Widget? content,
    required String hintText, //TODO test
    bool isPassword = false}) async {
  final response = await showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController _controller = TextEditingController();
      return AlertDialog(
        title: title,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              if (content != null) content,
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controller,
                autofocus: true,
                obscureText: isPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(hintText: hintText),
                //TODO test and delete hintText: isPassword
                //     ? AppLocalizations.of(context)!.password
                //     : AppLocalizations.of(context)!.typeHere),
                onFieldSubmitted: (value) {
                  Navigator.of(context).pop(value);
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              final response = _controller.text;
              Navigator.of(context).pop(response);
            },
            child: Text(AppLocalizations.of(context)!.continueString),
          ),
        ],
      );
    },
  );

  return response != null && response != '' ? some(response as String) : none();
}

Future<Option<SourceImage>> showImageSourceDialog(BuildContext context) async {
  final SourceImage? source = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.editImage),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.selectImage),
                onTap: () {
                  Navigator.of(context).pop(const SourceImage.gallery());
                },
              ),
              const Divider(height: 0.0),
              ListTile(
                title: Text(AppLocalizations.of(context)!.takePhoto),
                onTap: () {
                  Navigator.of(context).pop(const SourceImage.camera());
                },
              ),
            ],
          ),
        ),
      );
    },
  );
  return optionOf(source);
}

Future<String?> showPlacesDialog(BuildContext context) async {
  final kGoogleApiKey = PrivateKeys.getGooglePlacesApiKey();
  final Locale myLocale = Localizations.localeOf(context);
  try {
    final Prediction? p = await PlacesAutocomplete.show(
      context: context,
      types: ['(regions)'],
      strictbounds: false,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      language: myLocale.languageCode,
      components: [],
    );
    return p?.description;
  } catch (e) {
    debugPrint(e.toString());
    return '';
  }
}

void showFiltersDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, watch, child) {
          final String genderFilter =
              watch(contactsNotifierProvider).genderFilter;
          final String locationFilter =
              watch(contactsNotifierProvider).locationFilter;
          final List<String> tagsFilter =
              watch(contactsNotifierProvider).tagsFilter;
          final String genderText = genderFilter == 'male'
              ? AppLocalizations.of(context)!.male
              : AppLocalizations.of(context)!.female;
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            title: Text(
              AppLocalizations.of(context)!.filterBy,
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 0.0),
                ListTile(
                  tileColor: genderFilter.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : null,
                  title: Text(
                    genderFilter.isNotEmpty
                        ? '${AppLocalizations.of(context)!.gender}: $genderText'
                        : AppLocalizations.of(context)!.gender,
                    style: TextStyle(
                        color: genderFilter.isNotEmpty ? Colors.white70 : null),
                  ),
                  onTap: () {
                    final newFilter = genderFilter.isEmpty
                        ? 'male'
                        : genderFilter == 'male'
                            ? 'female'
                            : '';
                    context
                        .read(contactsNotifierProvider)
                        .setFilters(gender: newFilter);
                  },
                ),
                const Divider(
                  height: 1.0,
                ),
                ListTile(
                  tileColor: locationFilter.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : null,
                  title: Text(
                    locationFilter.isNotEmpty
                        ? '${AppLocalizations.of(context)!.city}: $locationFilter'
                        : AppLocalizations.of(context)!.city,
                    style: TextStyle(
                        color:
                            locationFilter.isNotEmpty ? Colors.white70 : null),
                  ),
                  onTap: () async {
                    final newFilter = locationFilter.isNotEmpty
                        ? ''
                        : await showPlacesDialog(context);
                    if (newFilter != null) {
                      context
                          .read(contactsNotifierProvider)
                          .setFilters(location: newFilter);
                    }
                  },
                ),
                const Divider(height: 1.0),
                TagsSelectionWrap(
                  selectedTags: tagsFilter,
                  canAdd: false,
                  onTagsListChanged: (tags) => context
                      .read(contactsNotifierProvider)
                      .setFilters(tags: tags),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () =>
                      context.read(contactsNotifierProvider).clearFilters(),
                  child: Text(AppLocalizations.of(context)!.clearFilters)),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          );
        },
      );
    },
  );
}
