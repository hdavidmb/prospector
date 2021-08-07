import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../features/app_default_data/application/app_default_data_state.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/contacts/application/contacts_providers.dart';
import '../../../features/contacts/application/contacts_state.dart';
import '../../../features/tags/application/tags_provider.dart';
import '../../../features/tags/application/tags_state.dart';
import '../../../features/user/application/user_info_providers.dart';
import '../../../features/user/application/user_info_state.dart';
import 'app_sate_notifier.dart';
import 'app_state.dart';

final appStateNotifierProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final AuthState _authState = ref.watch(authStateNotifierProvider);
  final AppDefaultDataState _defaultDataState =
      ref.watch(appDefaultDataProvider).defaultDataState;
  final UserInfoState _userInfoState =
      ref.watch(userInfoNotifierProvider).userInfoState;
  final ContactsState _contactsState =
      ref.watch(contactsNotifierProvider).contactsState;
  final TagsState _tagsState = ref.watch(tagsNotifierProvider).tagsState;
  return AppStateNotifier(
    authState: _authState,
    defaultDataState: _defaultDataState,
    userInfoState: _userInfoState,
    contactsState: _contactsState,
    tagsState: _tagsState,
    read: ref.read,
  );
});
