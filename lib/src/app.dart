import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/theme/providers.dart';
import 'package:prospector/src/presentation/theme/theme_constants.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentThemeMode =
        watch(themeNotifierProvider).currentThemeMode;

    // * Temporal
    final themeProvider = watch(themeNotifierProvider);
    final Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    final bool darkModeOn = brightness == Brightness.dark;
    // * Temporal 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prospector',
      themeMode: currentThemeMode,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: SwitchListTile.adaptive(
            value: darkModeOn
                ? themeProvider.lightModeSwitch
                : themeProvider.darkModeSwitch,
            onChanged: (value) {
              if (darkModeOn) {
                themeProvider.lightModeSwitch = value;
              } else {
                themeProvider.darkModeSwitch = value;
              }
            },
            title: Text(darkModeOn ? 'Light Theme' : 'Dark Theme'),
          ),
        ),
      ),
    );
  }
}
