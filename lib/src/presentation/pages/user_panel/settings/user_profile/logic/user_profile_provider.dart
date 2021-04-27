import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:prospector/src/features/auth/domain/use_cases/sign_out.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/use_cases/delete_user_account.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_state_notifier.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileStateNotifier, UserProfileState>((ref) {
  final SignOut _signOut = ref.watch(signOut);
  final DeleteUserAccount _deleteUserAccount = ref.watch(deleteUserAccount);
  final ReloginUser _reloginUser = ref.watch(reloginUser);
  return UserProfileStateNotifier(
    signOut: _signOut,
    deleteUserAccount: _deleteUserAccount,
    reloginUser: _reloginUser,
    read: ref.read,
  );
});
