import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:google_maps_webservice/src/places.dart' show Prediction;
import 'package:permission_handler/permission_handler.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/core/private/private_keys.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/events/domain/entites/event_alert.dart';
import 'package:prospector/src/features/images/domain/sources/source_image.dart';
import 'package:prospector/src/features/user/domain/failures/user_info_failure.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
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
          indicatorColor: color,
          content: Text(
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
        message: AppLocalizations.current.serverError,
        type: SnackbarType.failure);
  } else if (failure ==
          const AuthFailure.invalidEmailAndPasswordCombination() ||
      failure == const UserInfoFailure.invalidEmailAndPasswordCombination()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.current.invalidEmailAndPassword,
        type: SnackbarType.failure);
  } else if (failure ==
      const AuthFailure.accountExistsWithDifferentCredential()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.current.accountWithDifferentCredentials,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.userNotFoundResetPassword()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.current.userNotFoundResetPassword,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.emailAlreadyInUse() ||
      failure == const UserInfoFailure.emailAlreadyInUse()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.current.emailAlreadyInUse,
        type: SnackbarType.failure);
  } else if (failure == const AuthFailure.noConnection() ||
      failure == const DatabaseFailure.noConnection() ||
      failure == const UserInfoFailure.noConnection()) {
    showSnackBar(
        context: context,
        message: AppLocalizations.current.noConnectionMessage,
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
              AppLocalizations.current.resetPassword,
              style: Theme.of(context).textTheme.headline6,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.current.resetPasswordDialogMessage),
                const SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.send,
                  initialValue:
                      context.read(signInFormProvider).resetPasswordEmail,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.current.email,
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
                        : AppLocalizations.current.invalidEmail;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => AutoRouter.of(context).pop(),
                  child: Text(AppLocalizations.current.cancel)),
              TextButton(
                onPressed: () async {
                  final bool success = await context
                      .read(signInFormProvider.notifier)
                      .forgotPasswordButtonPressed();
                  if (success) {
                    await Future.delayed(Duration.zero, () async {
                      await showMessageDialog(
                          context: context,
                          message:
                              AppLocalizations.current.resetPasswordEmailSent);
                    });
                    Future.delayed(Duration.zero, () {
                      AutoRouter.of(context).pop();
                    });
                  }
                },
                child: Text(AppLocalizations.current.send),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> showMessageDialog(
    {required BuildContext context,
    String? title,
    required String message}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => AutoRouter.of(context).pop(),
              child: Text(AppLocalizations.current.ok)),
        ],
      );
    },
  );
}

Future<bool> showConfirmDialog(
    {required BuildContext context,
    String? title,
    String? message,
    String? confirmText}) async {
  final response = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: (message != null && message.isNotEmpty) ? Text(message) : null,
        actions: [
          TextButton(
            onPressed: () => AutoRouter.of(context).pop(false),
            child: Text(AppLocalizations.current.cancel),
          ),
          TextButton(
            onPressed: () => AutoRouter.of(context).pop(true),
            child: Text(confirmText ?? AppLocalizations.current.delete),
          ),
        ],
      );
    },
  );
  return response ?? false;
}

Future<Option<String>> showDeleteAccountConfirmDialog(
    {required BuildContext context, required bool isPassword}) async {
  final title = Text(AppLocalizations.current.areYouSureDeleteAccount);
  final content = isPassword
      ? Text(
          '${AppLocalizations.current.thisAcctionCannotBeUndone} ${AppLocalizations.current.enterYourPasswordToConfirm}',
          style: Theme.of(context).textTheme.bodyText1,
        )
      : RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:
                    '${AppLocalizations.current.thisAcctionCannotBeUndone} ${AppLocalizations.current.typeTheWord} ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                  text: AppLocalizations.current.deleteCap,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold)),
              TextSpan(
                text: ' ${AppLocalizations.current.toConfirm}\n',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: AppLocalizations.current.youMayHaveToRelogin,
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
    hintText: isPassword
        ? AppLocalizations.current.password
        : AppLocalizations.current.typeHere,
  );
}

void showPremiumDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations.current.premiumFeature),
        content: Text(AppLocalizations.current.premiumFeatureMessage),
        actions: [
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: Text(AppLocalizations.current.close),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              AutoRouter.of(context).pop();
              //TODO navigate to membership
            },
            child: Text(
              AppLocalizations.current.moreInfo,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ],
      );
    },
  );
}

void showPermissionsDialog(
    {required BuildContext context, String? title, String? message}) {
  showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null && title.isNotEmpty) ? Text(title) : null,
        content: (message != null && message.isNotEmpty)
            ? Text('$message\n${AppLocalizations.current.allowAccess}')
            : null,
        actions: [
          TextButton(
            onPressed: () => AutoRouter.of(context).pop(false),
            child: Text(AppLocalizations.current.close),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              AutoRouter.of(context).pop();
              openAppSettings();
            },
            child: Text(
              AppLocalizations.current.goToSettings,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ],
      );
    },
  );
}

Future<Option<String>> showReloginPasswordDialog(
    {required BuildContext context}) {
  final title = Text(AppLocalizations.current.reauthenticate);
  final content = Text(AppLocalizations.current.reauthMessage);
  return showTextFieldDialog(
      context: context,
      title: title,
      content: content,
      isPassword: true,
      hintText: AppLocalizations.current.password);
}

Future<Option<String>> showTextFieldDialog(
    {required BuildContext context,
    Widget? title,
    Widget? content,
    required String hintText,
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
            physics: const BouncingScrollPhysics(),
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
                onFieldSubmitted: (value) {
                  AutoRouter.of(context).pop(value);
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: Text(AppLocalizations.current.cancel),
          ),
          TextButton(
            onPressed: () {
              final response = _controller.text;
              AutoRouter.of(context).pop(response);
            },
            child: Text(AppLocalizations.current.continueString),
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
        title: Text(AppLocalizations.current.editImage),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(AppLocalizations.current.selectImage),
                onTap: () {
                  AutoRouter.of(context).pop(const SourceImage.gallery());
                },
              ),
              const Divider(height: 0.0),
              ListTile(
                title: Text(AppLocalizations.current.takePhoto),
                onTap: () {
                  AutoRouter.of(context).pop(const SourceImage.camera());
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

Future<Option<String>> showAffiliationDialog(
    {required BuildContext context, String? gender}) async {
  final String? newStatusID = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.current.affiliateAs),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(gender == 'female'
                    ? AppLocalizations.current.clientF
                    : AppLocalizations.current.client),
                onTap: () {
                  AutoRouter.of(context)
                      .pop(context.read(appDefaultDataProvider).clientID);
                },
              ),
              const Divider(height: 0.0),
              ListTile(
                title: Text(gender == 'female'
                    ? AppLocalizations.current.executiveF
                    : AppLocalizations.current.executive),
                onTap: () {
                  AutoRouter.of(context)
                      .pop(context.read(appDefaultDataProvider).executiveID);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
  return optionOf(newStatusID);
}

Future<Option<Object>> showWeekdaySelectionDialog(
        {required BuildContext context}) =>
    showOptionsSelectionDialog(
        context: context,
        title: AppLocalizations.current.weekStartsOn,
        options: [0, 1, 2, 3, 4, 5, 6],
        optionTitleBuilder: (option) => localizedWeekday(option as int));

Future<Option<Object>> showTimeFormatDialog({required BuildContext context}) =>
    showOptionsSelectionDialog(
        context: context,
        title: AppLocalizations.current.timeFormat,
        options: [false, true],
        optionTitleBuilder: (option) =>
            '${(option as bool) ? 24 : 12} ${AppLocalizations.current.hours}');

Future<Option<Object>> showAlertSelectionDialog(
        {required BuildContext context}) =>
    showOptionsSelectionDialog(
        context: context,
        options: EventAlert.values,
        optionTitleBuilder: (option) => (option as EventAlert).text);

//TODO use for affiliate and image source dialog
Future<Option<Object>> showOptionsSelectionDialog(
    {required BuildContext context,
    required List<Object> options,
    String Function(Object)? optionTitleBuilder,
    bool dismissible = true,
    String? title}) async {
  final Object? selectedOption = await showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: options
                .map(
                  (option) => ListTile(
                    title: Text(optionTitleBuilder != null
                        ? optionTitleBuilder(option)
                        : option.toString()),
                    onTap: () {
                      AutoRouter.of(context).pop(option);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
  return optionOf(selectedOption);
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
              ? AppLocalizations.current.male
              : AppLocalizations.current.female;
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            title: Text(
              AppLocalizations.current.filterBy,
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
                        ? '${AppLocalizations.current.gender}: $genderText'
                        : AppLocalizations.current.gender,
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
                        ? '${AppLocalizations.current.city}: $locationFilter'
                        : AppLocalizations.current.city,
                    style: TextStyle(
                        color:
                            locationFilter.isNotEmpty ? Colors.white70 : null),
                  ),
                  onTap: () async {
                    final newFilter = locationFilter.isNotEmpty
                        ? ''
                        : await showPlacesDialog(context);
                    if (newFilter != null) {
                      Future.delayed(Duration.zero, () {
                        context
                            .read(contactsNotifierProvider)
                            .setFilters(location: newFilter);
                      });
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
                  child: Text(AppLocalizations.current.clearFilters)),
              TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(AppLocalizations.current.ok),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<Map<String, String>?> showCountryCodeDialog(
    {required BuildContext context}) async {
  return showDialog(
    context: context,
    builder: (context) {
      String selectedCountryCode = 'US';
      String selectedDialCode = '+1';
      return AlertDialog(
        title: Text(AppLocalizations.current.countryCode),
        contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        content: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.current.selectYourCountryCode),
            const SizedBox(height: 8.0),
            Center(
              child: CountryCodePicker(
                onChanged: (countryCode) {
                  selectedCountryCode = countryCode.code ?? selectedCountryCode;
                  selectedDialCode = countryCode.dialCode ?? selectedDialCode;
                },
                initialSelection: selectedCountryCode,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(AppLocalizations.current.defaultCountryCodeMessage,
                style: const TextStyle(fontSize: 14.0)),
            const SizedBox(height: 8.0),
            Text(AppLocalizations.current.modifyCountryCodeMessage,
                style: const TextStyle(fontSize: 14.0)),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            child: Text(AppLocalizations.current.cancel),
          ),
          TextButton(
            onPressed: () {
              final Map<String, String> countryCode = {
                'code': selectedCountryCode,
                'dial_code': selectedDialCode
              };
              AutoRouter.of(context).pop(countryCode);
            },
            child: Text(AppLocalizations.current.ok),
          )
        ],
      );
    },
  );
}
