import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/features/auth/application/auth_state.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<AuthState>(
      provider: authStateNotifierProvider.state,
      onChange: (context, authState) {
        authState.when(
          initial: () {},
          authenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())), //TODO implement proper navigation or routing
          unauthenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInPage())), //TODO implement proper navigation or routing
        );
      },
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Hero(tag: 'prospector_logo', child: Icon(Icons.account_circle, size: 50.0,)), //TODO place prospector logo
              SizedBox(height: 20.0),
              Text('Prospector'), //TODO: localize strings and format
              SizedBox(height: 20.0),
              CircularProgressIndicator.adaptive()
            ]),
      ),
    );
  }
}
