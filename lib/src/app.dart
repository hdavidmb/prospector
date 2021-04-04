import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/wrapper.dart';

import 'package:prospector/src/presentation/theme/theme_providers.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentThemeMode =
        watch(themeNotifierProvider).currentThemeMode;

        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prospector',
      themeMode: currentThemeMode,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      home: Wrapper(), // TODO implement proper routing
    );
  }
}
