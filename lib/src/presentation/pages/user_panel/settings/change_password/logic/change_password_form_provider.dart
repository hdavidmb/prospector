import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/auth/application/auth_providers.dart';
import '../../../../../../features/auth/domain/use_cases/relogin_user.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../../features/user/domain/use_cases/change_user_password.dart';
import 'change_password_form_state.dart';
import 'change_password_form_state_notifier.dart';

final changePasswordFormProvider = StateNotifierProvider<
    ChangePasswordFormStateNotifier, ChangePasswordFormState>((ref) {
  final ReloginUser _reloginUser = ref.watch(reloginUser);
  final ChangeUserPassword _changeUserPassword = ref.watch(changeUserPassword);
  return ChangePasswordFormStateNotifier(
    reloginUser: _reloginUser,
    changeUserPassword: _changeUserPassword,
    read: ref.read,
  );
});
