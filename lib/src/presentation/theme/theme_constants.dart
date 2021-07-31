import 'package:flutter/material.dart';

final Color? kPrimaryColor = Colors.red[600];
final Color? kAccentColor = kPrimaryColor;
const Color kPremiumColor = Color(0xffD4AF37);

final ColorScheme kLightColorScheme =
    ThemeData.light().colorScheme.copyWith(primary: kPrimaryColor);
final ColorScheme kDarkColorScheme = ThemeData.dark()
    .colorScheme
    .copyWith(primary: kPrimaryColor, secondary: kPrimaryColor);

const InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2.0)),
);

final SwitchThemeData kSwitchTheme = SwitchThemeData(
  thumbColor: MaterialStateProperty.all(Colors.white),
  trackColor: MaterialStateProperty.resolveWith(
    (states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
    },
  ),
);

// * Themes
final kLightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  colorScheme: kLightColorScheme,
  switchTheme: kSwitchTheme,
  inputDecorationTheme:
      kInputDecorationTheme.copyWith(fillColor: const Color(0x0A000000)),
);

final kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  colorScheme: kDarkColorScheme,
  switchTheme: kSwitchTheme,
  inputDecorationTheme:
      kInputDecorationTheme.copyWith(fillColor: const Color(0x1AFFFFFF)),
);
