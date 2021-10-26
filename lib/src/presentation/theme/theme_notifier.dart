import 'package:flutter/material.dart';

import '../../core/shared_prefs/shared_prefs.dart';

export 'theme_constants.dart';

class ThemeNotifier with ChangeNotifier {
  final UserSharedPreferences _prefs;

  ThemeNotifier(this._prefs) {
    _is24hours = _prefs.is24hours;

    switch (_prefs.userThemePrefs) {
      case 0: //system
        _lightModeSwitch = false;
        _darkModeSwitch = false;
        _currentThemeMode = ThemeMode.system;
        break;
      case 1: //light
        _lightModeSwitch = true;
        _darkModeSwitch = false;
        _currentThemeMode = ThemeMode.light;
        break;
      case 2: //dark
        _lightModeSwitch = false;
        _darkModeSwitch = true;
        _currentThemeMode = ThemeMode.dark;
        break;
      default:
    }
  }

  bool _lightModeSwitch = false;
  bool get lightModeSwitch => _lightModeSwitch;
  set lightModeSwitch(bool value) {
    _darkModeSwitch = false;
    _lightModeSwitch = value;
    _currentThemeMode = value ? ThemeMode.light : ThemeMode.system;
    _prefs.userThemePrefs = value ? 1 : 0;
    notifyListeners();
  }

  bool _darkModeSwitch = false;
  bool get darkModeSwitch => _darkModeSwitch;
  set darkModeSwitch(bool value) {
    _lightModeSwitch = false;
    _darkModeSwitch = value;
    _currentThemeMode = value ? ThemeMode.dark : ThemeMode.system;
    _prefs.userThemePrefs = value ? 2 : 0;
    notifyListeners();
  }

  ThemeMode _currentThemeMode = ThemeMode.system;
  ThemeMode get currentThemeMode => _currentThemeMode;

  bool _is24hours = false;
  bool get is24hours => _is24hours;
  set is24hours(bool value) {
    _is24hours = value;
    _prefs.is24hours = value;
    notifyListeners();
  }
}
