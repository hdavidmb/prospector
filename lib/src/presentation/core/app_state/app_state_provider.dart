import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/fetch_state/fetch_state.dart';
import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/contacts/application/contacts_providers.dart';
import '../../../features/events/application/events_providers.dart';
import '../../../features/interactions/application/interactions_providers.dart';
import '../../../features/statistics/application/statistics_providers.dart';
import '../../../features/tags/application/tags_provider.dart';
import '../../../features/user/application/user_info_providers.dart';
import 'app_sate_notifier.dart';
import 'app_state.dart';

final appStateNotifierProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final AuthState _authState = ref.watch(authStateNotifierProvider);
  final FetchState _defaultDataState =
      ref.watch(appDefaultDataProvider).defaultDataState;
  final FetchState _userInfoState =
      ref.watch(userInfoNotifierProvider).userInfoState;
  final FetchState _contactsState =
      ref.watch(contactsNotifierProvider).contactsState;
  final FetchState _interactionsState =
      ref.watch(interactionsNotifierProvider).interactionsState;
  final FetchState _tagsState = ref.watch(tagsNotifierProvider).tagsState;
  final FetchState _eventsState = ref.watch(eventsNotifierProvider).eventsState;
  final FetchState _statisticsState =
      ref.watch(statisticsNotifierProvider).statisticsState;
  return AppStateNotifier(
    authState: _authState,
    defaultDataState: _defaultDataState,
    userInfoState: _userInfoState,
    contactsState: _contactsState,
    interactionsState: _interactionsState,
    tagsState: _tagsState,
    eventsState: _eventsState,
    statisticsState: _statisticsState,
    read: ref.read,
  );
});
