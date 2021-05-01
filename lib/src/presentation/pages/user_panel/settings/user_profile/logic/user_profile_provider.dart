import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:prospector/src/features/auth/domain/use_cases/sign_out.dart';
import 'package:prospector/src/features/images/application/image_picker_providers.dart';
import 'package:prospector/src/features/images/domain/use_cases/get_image.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/features/user/domain/use_cases/delete_user_account.dart';
import 'package:prospector/src/presentation/pages/user_panel/settings/user_profile/logic/user_profile_notifier.dart';

final userProfileProvider =
    ChangeNotifierProvider<UserProfileNotifier>((ref) {
  final SignOut _signOut = ref.watch(signOut);
  final DeleteUserAccount _deleteUserAccount = ref.watch(deleteUserAccount);
  final ReloginUser _reloginUser = ref.watch(reloginUser);
  final GetImage _getImage = ref.watch(getImage);
  return UserProfileNotifier(
    signOut: _signOut,
    deleteUserAccount: _deleteUserAccount,
    reloginUser: _reloginUser,
    getImage: _getImage,
    read: ref.read, 
  );
});
