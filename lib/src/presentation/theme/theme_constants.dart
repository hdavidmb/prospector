import 'package:flutter/material.dart';

final Color kPrimaryColor = Colors.red[600];

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
  inputDecorationTheme: kInputDecorationTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
);

final kDarkTheme = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  inputDecorationTheme: kInputDecorationTheme,
  elevatedButtonTheme: kElevatedButtonTheme,
);