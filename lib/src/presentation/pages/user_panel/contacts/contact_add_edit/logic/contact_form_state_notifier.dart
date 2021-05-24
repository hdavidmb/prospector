import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/images/domain/use_cases/get_image.dart';
import 'package:prospector/src/features/storage/domain/use_cases/upload_contact_image.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';
import 'package:random_string/random_string.dart';

class ContactFormStateNotifier extends StateNotifier<ContactFormState>
    with FormValidators {
  final GetImage getImage;
  final UploadContactImage uploadContactImage;
  final Reader read;
  ContactFormStateNotifier({
    required this.getImage,
    required this.uploadContactImage,
    required this.read,
  }) : super(ContactFormState.initial());

  void reset() => state = ContactFormState.initial();

  void setEditingState({required Contact editingContact}) {
    final List<String> statePhones = [];
    final List<String> stateTags = [];
    if (editingContact.phones != null && editingContact.phones!.isNotEmpty) statePhones.addAll(editingContact.phones!);
    if (editingContact.tags != null && editingContact.tags!.isNotEmpty) stateTags.addAll(editingContact.tags!);
    state = ContactFormState(
      name: editingContact.name,
      phone: editingContact.phone ?? '',
      whatsapp: editingContact.whatsapp ?? '',
      phones: statePhones,
      location: editingContact.location ?? '',
      gender: editingContact.gender ?? '',
      tags: stateTags,
      status: editingContact.status,
      pickedImage: null,
      isSubmitting: false,
      showErrorMessages: false,
      deleted: false,
      failureOrSuccesOption: none(),
    );
  }

  void nameChanged(String value) =>
      state = state.copyWith(name: value, failureOrSuccesOption: none());

  void phoneChanged(String value) =>
      state = state.copyWith(phone: value, failureOrSuccesOption: none());

  void whatsappChanged(String value) =>
      state = state.copyWith(whatsapp: value, failureOrSuccesOption: none());

  void phonesListChanged(List<String> values) =>
      state = state.copyWith(phones: values, failureOrSuccesOption: none());

  void locationChanged(String value) =>
      state = state.copyWith(location: value, failureOrSuccesOption: none());

  void genderChanged(String value) =>
      state = state.copyWith(gender: value, failureOrSuccesOption: none());

  void statusChanged(String value) =>
      state = state.copyWith(status: value, failureOrSuccesOption: none());

  void tagsListChanged(List<String> values) =>
      state = state.copyWith(tags: values, failureOrSuccesOption: none());

  Future<void> savedButtonPressed({Contact? editingContact}) async {
    // Validate name field
    final bool isNameValid = validateFieldIsNotEmpty(state.name);

    Either<DatabaseFailure, Unit>? failureOrSuccess;

    if (isNameValid) {
      // Set submiting state
      state = state.copyWith(
        isSubmitting: true,
        failureOrSuccesOption: none(),
      );

      String? downloadURL;
      if (editingContact != null && state.pickedImage != null) {
        final uid = read(userInfoNotifierProvider).user.uid;
        final uploadResult = await uploadContactImage(
            uid: uid, contactID: editingContact.id, image: state.pickedImage);
        uploadResult.fold(
          (failure) {
            failure.maybeWhen(
              noConnection: () {
                failureOrSuccess = left(const DatabaseFailure.noConnection());
              },
              orElse: () {
                failureOrSuccess = left(const DatabaseFailure.serverError());
              },
            );
          },
          (url) => downloadURL = url,
        );
      }

      // Arrange contactEntity from state values
      final newContactInfo = Contact(
        id: editingContact?.id ?? randomAlphaNumeric(20),
        name: state.name,
        status: state.status == ''
            ? read(appDefaultDataProvider).notContactedID
            : state.status,
        created: editingContact?.created ?? DateTime.now(),
        modified: editingContact?.modified ?? DateTime.now(),
        phone: state.phone != '' ? state.phone : null,
        whatsapp: state.whatsapp != '' ? state.whatsapp : null,
        phones: state.phones.isNotEmpty ? state.phones : null,
        location: state.location != '' ? state.location : null,
        gender: state.gender != '' ? state.gender : null,
        tags: state.tags.isNotEmpty ? state.tags : null,
        photo: downloadURL ?? editingContact?.photo,
      );

      // If editing compare contact entities
      if (editingContact != null) {
        // Compare
        if (editingContact != newContactInfo) {
          // Edit
          failureOrSuccess = await read(contactsNotifierProvider)
              .updateContact(newContactInfo);
        } else {
          failureOrSuccess = right(unit);
        }
      } else {
        // Create contact
        failureOrSuccess =
            await read(contactsNotifierProvider).createContact(newContactInfo);
      }
    }
    // Set final state (failure or success)
    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      failureOrSuccesOption: optionOf(failureOrSuccess),
    );
  }

  Future<void> getContactImage(BuildContext context) async {
    final selectedSource = await showImageSourceDialog(context);
    final Option<File> result = await selectedSource.fold(
      () => none(),
      (source) async {
        return getImage(source: source);
      },
    );
    result.fold(
      () => null,
      (file) {
        state = state.copyWith(pickedImage: file);
      },
    );
  }

  Future<void> deleteContact(
      {required BuildContext context, required String contactID}) async {
    // Set submiting state
    state = state.copyWith(
      isSubmitting: true,
      failureOrSuccesOption: none(),
    );
    Either<DatabaseFailure, Unit>? failureOrSuccess;
    final confirm = await showDeleteConfirmDialog(
      context: context,
      title: AppLocalizations.of(context)!.areYouSureDeleteProspect,
      message: AppLocalizations.of(context)!.thisAcctionCannotBeUndone,
    );
    if (confirm) {
      failureOrSuccess = await read(contactsNotifierProvider)
          .deleteContact(contactID: contactID);
    }
    final deleted = failureOrSuccess?.isRight() ?? false;
    // Set final state (failure or success)
    state = state.copyWith(
      isSubmitting: false,
      deleted: deleted,
      failureOrSuccesOption: optionOf(failureOrSuccess),
    );
  }
}
