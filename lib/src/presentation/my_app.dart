import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentThemeMode =
        Provider.of<ThemeProvider>(context).currentThemeMode;

    // * Temporal
    final themeProvider = Provider.of<ThemeProvider>(context);
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
