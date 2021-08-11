import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../core/app_state/app_state.dart';
import '../../core/app_state/app_state_provider.dart';
import '../../core/dialogs.dart';
import '../../routes/app_router.gr.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showingDialog = false;
    return ProviderListener<AppState>(
      provider: appStateNotifierProvider,
      onChange: (context, appState) async {
        // TODO this is being called twice
        if (appState == const AppState.authenticatedReady()) {
          AutoRouter.of(context).replace(const HomeRoute());
        } else if (appState == const AppState.unauthenticatedReady()) {
          AutoRouter.of(context).replace(const SignInRoute());
        } else if (appState == const AppState.error()) {
          if (!showingDialog) {
            showingDialog = true;
            await showMessageDialog(
                context: context,
                message: AppLocalizations.of(context)!.appStateError);
            showingDialog = false;
          }
        }
      },
      child: Scaffold(
        body: Consumer(
          builder: (context, watch, child) {
            final AppState _appState = watch(appStateNotifierProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            );
          },
        ),
      ),
    );
  }
}
