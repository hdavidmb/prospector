import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/core/app_state/app_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state_provider.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/sign_in/sign_in_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<AppState>(
      provider: appStateNotifierProvider,
      onChange: (context, appState) {
        // TODO this is being called twice
        Future.delayed(const Duration(milliseconds: 200), () {
          if (appState == const AppState.authenticatedReady()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                    builder: (context) =>
                        HomePage()));
          } else if (appState == const AppState.unauthenticatedReady()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                    builder: (context) =>
                        SignInPage()));
          }
        });
      },
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Hero(
              tag: 'prospector_logo',
              child: Image(
                  image: AssetImage('assets/images/prospector_logo.png'),
                  width: 150.0)),
          Text(AppLocalizations.of(context)!.prospector,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black87)),
          const SizedBox(
            width: double.infinity,
            height: 20.0,
          ),
          const CircularProgressIndicator.adaptive()
        ]),
      ),
    );
  }
}
