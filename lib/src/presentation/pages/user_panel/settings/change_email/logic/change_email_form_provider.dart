import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/auth/application/auth_providers.dart';
import 'change_email_form_state.dart';
import 'change_email_form_state_notifier.dart';

final changeEmailFormProvider =
    StateNotifierProvider<ChangeEmailFormStateNotifier, ChangeEmailFormState>(
        (ref) {
  final _reloginUser = ref.watch(reloginUser);
  return ChangeEmailFormStateNotifier(
    reloginUser: _reloginUser,
    read: ref.read,
  );
});
