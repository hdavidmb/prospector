import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<AuthState>(
      provider: authStateNotifierProvider,
      onChange: (context, authState) {
        authState.when(
          initial: () {},
          authenticated: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }, //TODO implement proper navigation or routing
          unauthenticated: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          }, //TODO implement proper navigation or routing
        );
      },
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Hero(
              tag: 'prospector_logo',
              child: Image(
                  image: AssetImage('assets/images/prospector_logo.png'),
                  width: 200.0)),
          Text(AppLocalizations.of(context)!.prospector,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black87)),
          const CircularProgressIndicator.adaptive()
        ]),
      ),
    );
  }
}
