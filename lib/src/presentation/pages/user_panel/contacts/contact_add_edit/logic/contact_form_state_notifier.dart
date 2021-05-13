import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';
import 'package:random_string/random_string.dart';

class ContactFormStateNotifier extends StateNotifier<ContactFormState>
    with FormValidators {
  final Reader read;
  ContactFormStateNotifier({
    required this.read,
  }) : super(ContactFormState.initial());

  void reset() => state = ContactFormState.initial();

  void setEditingState({required Contact editingContact}) {
    state = ContactFormState(
      name: editingContact.name,
      phone: editingContact.phone ?? '',
      whatsapp: editingContact.whatsapp ?? '',
      phones: editingContact.phones ?? [],
      location: editingContact.location ?? '',
      gender: editingContact.gender ?? '',
      tags: editingContact.tags ?? [],
      status: editingContact.status,
      showErrorMessages: false,
      isSubmitting: false,
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
      );

      // If editing compare contact entities
      if (editingContact != null) {
        // Compare
        if (editingContact != newContactInfo) {
          // Edit
          failureOrSuccess = await read(contactsNotifierProvider)
              .updateContact(newContactInfo); // TODO test
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
      isSubmitting: true,
      showErrorMessages: true,
      failureOrSuccesOption: optionOf(failureOrSuccess),
    );
  }
}
