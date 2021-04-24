import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';

import 'package:prospector/src/presentation/core/app_state/app_state.dart';
import 'package:prospector/src/presentation/core/app_state/app_state_provider.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/home/home_page.dart';
import 'package:prospector/src/presentation/pages/auth/sign_in/sign_in_page.dart';

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
                MaterialPageRoute(// TODO implement fade in transition
                    fullscreenDialog: true, builder: (context) => HomePage()));
          } else if (appState == const AppState.unauthenticatedReady()) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => SignInPage()));
          } else
          if (appState == const AppState.error()) {
            showMessageDialog(
                context: context,
                message: AppLocalizations.of(context)!.appStateError);
          }
        });
      },
      child: Scaffold(body: Consumer(builder: (context, watch, child) {
        final AppState _appState = watch(appStateNotifierProvider);
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          if (_appState != const AppState.error())
            const CircularProgressIndicator.adaptive()
          else
            ElevatedButton(
              onPressed: () {
                context.read(appStateNotifierProvider.notifier).reset();
                context.read(appDefaultDataProvider).getDefaultData();
              },
              child: Text(AppLocalizations.of(context)!.tryAgain),
            ),
        ]);
      })),
    );
  }
}
