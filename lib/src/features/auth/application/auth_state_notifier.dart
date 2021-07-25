import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/tags/application/tags_provider.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/pages/auth/register/logic/register_form_provider.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/logic/sign_in_form_provider.dart';

import 'auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AsyncValue<bool> isAuthenticated;
  final Reader read;
  // The value passed into the super constructor is the initial state
  AuthStateNotifier({required this.isAuthenticated, required this.read})
      : super(const AuthState.initial()) {
    state = isAuthenticated.when(
      data: (isAuthenticated) {
        if (isAuthenticated) {
          return const AuthState.authenticated();
        } else {
          //TODO: Reset all user data providers (Contacts, tags, interactions, events, etc)
          read(userInfoNotifierProvider).reset();
          read(contactsNotifierProvider).reset();
          read(tagsNotifierProvider).reset();
          return const AuthState.unauthenticated();
        }
      },
      loading: () => const AuthState.initial(),
      error: (_, __) => const AuthState.error(),
    );
  }
}
