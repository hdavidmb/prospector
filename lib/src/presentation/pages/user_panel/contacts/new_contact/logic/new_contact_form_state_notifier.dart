import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/helpers/form_validators.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/logic/new_contact_form_state.dart';

class NewContactFormStateNotifier extends StateNotifier<NewContactFormState> with FormValidators {
  NewContactFormStateNotifier() : super(NewContactFormState.initial());

  void reset() => state = NewContactFormState.initial();

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

  void tagsChanged(List<String> values) =>
      state = state.copyWith(tags: values, failureOption: none()); //TODO organice as needed

}
