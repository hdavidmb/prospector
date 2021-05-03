import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/user/application/user_info_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_sate_notifier.dart';
import 'package:prospector/src/presentation/core/app_state/app_state.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

final appStateNotifierProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final AuthState _authState = ref.watch(authStateNotifierProvider);
  final AppDefaultDataState _defaultDataState =
      ref.watch(appDefaultDataProvider).defaultDataState;
  final UserInfoState _userInfoState =
      ref.watch(userInfoNotifierProvider).userInfoState;
  return AppStateNotifier(
    authState: _authState,
    defaultDataState: _defaultDataState,
    userInfoState: _userInfoState,
    read: ref.read,
  );
});
