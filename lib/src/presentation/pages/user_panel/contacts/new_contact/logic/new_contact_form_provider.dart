import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/logic/new_contact_form_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/logic/new_contact_form_state_notifier.dart';

final newContactFormProvider =
    StateNotifierProvider<NewContactFormStateNotifier, NewContactFormState>(
        (ref) {
  return NewContactFormStateNotifier();
});
