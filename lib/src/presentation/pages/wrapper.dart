import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';
import 'package:prospector/src/presentation/pages/splash/splash_screen_page.dart';

class Wrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AuthState _authState = watch(authStateNotifierProvider.state);
    return _authState.when(
      initial: () => SplashScreenPage(),
      authenticated: () => HomePage(),
      unauthenticated: () => SignInPage(),
    );
  }
}
