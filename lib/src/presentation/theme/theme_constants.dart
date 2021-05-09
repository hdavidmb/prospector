import 'package:flutter/material.dart';

final Color? kPrimaryColor = Colors.red[600];
final Color? kAccentColor = kPrimaryColor;
const Color kPremiumColor = Color(0xffD4AF37);

const InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
    filled: true,
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0)),
  );

final ElevatedButtonThemeData kElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: kPrimaryColor
    )
  );

// * Themes
final kLightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  inputDecorationTheme: kInputDecorationTheme.copyWith(fillColor: const Color(0x0A000000)),
  elevatedButtonTheme: kElevatedButtonTheme,
);

final kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  inputDecorationTheme: kInputDecorationTheme.copyWith(fillColor: const Color(0x1AFFFFFF)),
  elevatedButtonTheme: kElevatedButtonTheme,
);