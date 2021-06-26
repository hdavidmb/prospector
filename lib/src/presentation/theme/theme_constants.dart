import 'package:flutter/material.dart';

final Color? kPrimaryColor = Colors.red[600];
final Color? kAccentColor = kPrimaryColor;
const Color kPremiumColor = Color(0xffD4AF37);
final SwitchThemeData kSwitchThemeDark = SwitchThemeData(
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

const InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2.0)),
);

final ElevatedButtonThemeData kElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(primary: kPrimaryColor));

final BottomNavigationBarThemeData kBottomNavigationBarThemeData = ThemeData.light().bottomNavigationBarTheme.copyWith(selectedItemColor: kPrimaryColor);

// * Themes
final kLightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  bottomNavigationBarTheme: kBottomNavigationBarThemeData,
  inputDecorationTheme:
      kInputDecorationTheme.copyWith(fillColor: const Color(0x0A000000)),
  elevatedButtonTheme: kElevatedButtonTheme,
);

final kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  bottomNavigationBarTheme: kBottomNavigationBarThemeData,
  inputDecorationTheme:
      kInputDecorationTheme.copyWith(fillColor: const Color(0x1AFFFFFF)),
  switchTheme: kSwitchThemeDark,
  elevatedButtonTheme: kElevatedButtonTheme,
);
