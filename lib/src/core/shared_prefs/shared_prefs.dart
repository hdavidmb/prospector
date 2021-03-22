import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static final UserSharedPreferences _instance = UserSharedPreferences._internal();

  factory UserSharedPreferences() {
    return _instance;
  }

  UserSharedPreferences._internal();

  SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int get userThemePrefs => _prefs.getInt('userThemePrefs') ?? 0;
  set userThemePrefs(int value) {
    _prefs.setInt('userThemePrefs', value);
  }
}