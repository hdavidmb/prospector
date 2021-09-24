import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'features/app_default_data/application/app_default_data_providers.dart';
import 'presentation/core/app_state/app_state.dart';
import 'presentation/core/app_state/app_state_provider.dart';
import 'presentation/core/dialogs.dart';
import 'presentation/pages/auth/register/logic/register_form_provider.dart';
import 'presentation/pages/auth/sign_in/logic/sign_in_form_provider.dart';
import 'presentation/routes/app_router.gr.dart';
import 'presentation/theme/theme_providers.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final appRouter = AppRouter();

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
    bool showingDialog = false;
    return ProviderListener<AppState>(
      provider: appStateNotifierProvider,
      onChange: (context, state) {
        state.maybeMap(
          authenticatedReady: (_) => appRouter.replaceAll(const [HomeRoute()]),
          unauthenticatedReady: (_) {
            context.read(signInFormProvider.notifier).reset();
            context.read(registerFormProvider.notifier).reset();
            return appRouter.replaceAll(const [SignInRoute()]);
          },
          error: (_) async {
            if (!showingDialog) {
              showingDialog = true;
              await showMessageDialog(
                  context: context,
                  message: AppLocalizations.of(context)!.appStateError);
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
          return MaterialApp.router(
            title: 'Prospector',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations
                .supportedLocales, //! Add .arb file on lib/l10n - also modify info.plist localizations
            themeMode: currentThemeMode,
            theme: kLightTheme,
            darkTheme: kDarkTheme,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
