import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/theme/theme_providers.dart';

class ThemeSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final bool darkModeOn = brightness == Brightness.dark;

    return SwitchListTile.adaptive(
      title: Text(darkModeOn ? 'Light theme' : 'Dark theme'),
      value: darkModeOn ? watch(themeNotifierProvider).lightModeSwitch : watch(themeNotifierProvider).darkModeSwitch,
      onChanged: (value) {
        if (darkModeOn) {
          context.read(themeNotifierProvider).lightModeSwitch = value;
        } else {
          context.read(themeNotifierProvider).darkModeSwitch = value;
        }
      },
    );
  }
}
