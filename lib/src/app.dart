import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../generated/l10n.dart';
import 'features/analytics/firebase_analytics_providers.dart';
import 'features/app_default_data/application/app_default_data_providers.dart';
import 'presentation/core/app_state/app_state.dart';
import 'presentation/core/app_state/app_state_provider.dart';
import 'presentation/core/dialogs.dart';
import 'presentation/pages/auth/register/logic/register_form_provider.dart';
import 'presentation/pages/auth/sign_in/logic/sign_in_form_provider.dart';
import 'presentation/routes/app_router.gr.dart';
import 'presentation/routes/app_router_provider.dart';
import 'presentation/theme/theme_providers.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppState oldState = const AppState.initial();

  @override
  void initState() {
    super.initState();
    context.read(appDefaultDataProvider).getDefaultData();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read(appRouterProvider);
    bool showingDialog = false;
    return ProviderListener<AppState>(
      provider: appStateNotifierProvider,
      onChange: (context, state) {
        state.maybeMap(
          authenticatedReady: (_) {
            if (oldState != const AppState.authenticatedReady()) {
              oldState = const AppState.authenticatedReady();
              appRouter.replaceAll(const [HomeRoute()]);
            }
          },
          unauthenticatedReady: (_) {
            if (oldState != const AppState.unauthenticatedReady()) {
              oldState = const AppState.unauthenticatedReady();
              context.read(signInFormProvider.notifier).reset();
              context.read(registerFormProvider.notifier).reset();
              appRouter.replaceAll(const [SignInRoute()]);
            }
          },
          error: (_) async {
            if (!showingDialog) {
              //TODO: use postframe
              showingDialog = true;
              await showMessageDialog(
                  context: context,
                  message: AppLocalizations.of(context).appStateError);
              showingDialog = false;
            }
          },
          orElse: () {},
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final currentThemeMode =
              watch(themeNotifierProvider).currentThemeMode;
          final FirebaseAnalyticsObserver navigatorObserver =
              context.read(firebaseAnalyticsObserver);
          return MaterialApp.router(
            title: 'Prospector',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              CountryLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate
                .supportedLocales, //! Add .arb file on lib/l10n - also modify info.plist localizations
            themeMode: currentThemeMode,
            theme: kLightTheme,
            darkTheme: kDarkTheme,
            routerDelegate: appRouter.delegate(
                navigatorObservers: () => [navigatorObserver]),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
