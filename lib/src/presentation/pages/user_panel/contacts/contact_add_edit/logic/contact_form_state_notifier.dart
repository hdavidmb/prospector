import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';

class ContactFormStateNotifier extends StateNotifier<ContactFormState>
    with FormValidators {
  ContactFormStateNotifier() : super(ContactFormState.initial());

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
            failureOption: none(),
          );
  }

  void nameChanged(String value) =>
      state = state.copyWith(name: value, failureOption: none());

  void phoneChanged(String value) =>
      state = state.copyWith(phone: value, failureOption: none());

  void whatsappChanged(String value) =>
      state = state.copyWith(whatsapp: value, failureOption: none());

  void phonesListChanged(List<String> values) =>
      state = state.copyWith(phones: values, failureOption: none());

  void locationChanged(String value) =>
      state = state.copyWith(location: value, failureOption: none());

  void genderChanged(String value) =>
      state = state.copyWith(gender: value, failureOption: none());

  void statusChanged(String value) =>
      state = state.copyWith(status: value, failureOption: none());

  void tagsListChanged(List<String> values) => state = state.copyWith(
      tags: values, failureOption: none());

}
