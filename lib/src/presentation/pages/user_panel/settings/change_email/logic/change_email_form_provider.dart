import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/change_email/logic/change_email_form_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/change_email/logic/change_email_form_state_notifier.dart';

final changeEmailFormProvider =
    StateNotifierProvider<ChangeEmailFormStateNotifier, ChangeEmailFormState>(
        (ref) {
  final _reloginUser = ref.watch(reloginUser);
  return ChangeEmailFormStateNotifier(
    reloginUser: _reloginUser,
    read: ref.read,
  );
});
