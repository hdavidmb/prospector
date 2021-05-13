import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state_notifier.dart';

final contactFormProvider =
    StateNotifierProvider<ContactFormStateNotifier, ContactFormState>(
        (ref) {
  return ContactFormStateNotifier(
    read: ref.read,
  );
});
