import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<AuthState>(
      provider: authStateNotifierProvider.state,
      onChange: (context, authState) {
        Future.delayed(const Duration(milliseconds: 1000), () {

        authState.when(
          initial: () {},
          authenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())), //TODO implement proper navigation or routing
          unauthenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInPage())), //TODO implement proper navigation or routing
        );
        });
      },
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: 'prospector_logo', child: const Image(image: AssetImage('assets/images/prospector_logo.png'), width: 200.0), createRectTween: (start, end) {return Tween<Rect>(begin: start, end: end);},), //TODO place prospector logo
              // const SizedBox(height: 20.0),
              Text('Prospector', style: Theme.of(context).textTheme.headline3), //TODO: localize strings and format
              const SizedBox(height: 20.0, width: double.infinity),
              const CircularProgressIndicator.adaptive()
            ]),
      ),
    );
  }
}
