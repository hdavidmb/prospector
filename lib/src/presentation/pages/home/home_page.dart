import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/pages/register/logic/register_form_provider.dart';
import 'package:prospector/src/presentation/pages/sign_in/logic/sign_in_form_provider.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO * Temporary
    final user = context.read(userInfoNotifierProvider).user;
    // * This provider listener must always be at the top of the home widget tree
    return ProviderListener<AuthState>( 
        provider: authStateNotifierProvider,
        onChange: (context, authState) {
          if (authState == const AuthState.unauthenticated()) {
            context.read(signInFormProvider.notifier).reset();
            context.read(registerFormProvider.notifier).reset();
            context.read(userInfoNotifierProvider).reset();
              Navigator.pushReplacement(
              context, MaterialPageRoute( //TODO implement fade in transition
                builder: (context) => SignInPage()));
          }
        },
          child: Scaffold(
        appBar: AppBar(
          title: const Text('Home')
        ),
        body: Center(
          child: Column(
            children: [
              Text(user.name),
              Text(user.email ?? ''),
              Text(user.subscription),
              Text(user.photoURL ?? ''),
              ElevatedButton(onPressed: context.read(signOut).call, child: const Text('Sign out')),
            ],
          )
          
      )
      ),
    );
  }
}