import 'package:flutter/material.dart';

final Color? kPrimaryColor = Colors.red[600];
final Color? kAccentColor = kPrimaryColor;

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
  inputDecorationTheme: kInputDecorationTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
);

final kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  inputDecorationTheme: kInputDecorationTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
);