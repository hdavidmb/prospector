import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:prospector/src/presentation/pages/splash/splash_screen_page.dart';
import 'package:prospector/src/presentation/theme/theme_providers.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentThemeMode = watch(themeNotifierProvider).currentThemeMode;
    context.read(appDefaultDataProvider).getDefaultData();

    return MaterialApp(
      title: 'Prospector',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations
          .supportedLocales, //! Add .arb file on lib/l10n - also modify info.plist localizations
      themeMode: currentThemeMode,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      home: SplashScreenPage(), // TODO implement proper routing
    );
  }
}
