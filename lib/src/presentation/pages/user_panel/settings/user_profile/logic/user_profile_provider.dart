import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../features/auth/application/auth_providers.dart';
import '../../../../../../features/auth/domain/use_cases/auth_use_cases.dart';
import '../../../../../../features/images/application/image_picker_providers.dart';
import '../../../../../../features/images/domain/use_cases/get_image.dart';
import '../../../../../../features/storage/application/storage_providers.dart';
import '../../../../../../features/storage/domain/use_cases/upload_user_avatar.dart';
import '../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../../features/user/domain/use_cases/delete_user_account.dart';
import 'user_profile_notifier.dart';

final userProfileProvider = ChangeNotifierProvider<UserProfileNotifier>((ref) {
  final SignOut _signOut = ref.watch(signOut);
  final DeleteUserAccount _deleteUserAccount = ref.watch(deleteUserAccount);
  final UploadUserAvatar _uploadUserAvatar = ref.watch(uploadUserAvatar);
  final ReloginUser _reloginUser = ref.watch(reloginUser);
  final GetImage _getImage = ref.watch(getImage);
  return UserProfileNotifier(
    signOut: _signOut,
    deleteUserAccount: _deleteUserAccount,
    uploadUserAvatar: _uploadUserAvatar,
    reloginUser: _reloginUser,
    getImage: _getImage,
    read: ref.read,
  );
});
