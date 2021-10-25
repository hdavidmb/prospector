import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static final UserSharedPreferences _instance =
      UserSharedPreferences._internal();

  factory UserSharedPreferences() {
    return _instance;
  }

  UserSharedPreferences._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ************* THEME ***************
  int get userThemePrefs => _prefs.getInt('userThemePrefs') ?? 0;
  set userThemePrefs(int value) => _prefs.setInt('userThemePrefs', value);

  // *************** HOME ****************

  int get homeIndex => _prefs.getInt('homeIndex') ?? 1;
  set homeIndex(int value) => _prefs.setInt('homeIndex', value);

  // *********** SYNC CONTACTS ***********
  bool get syncContactsEnabled =>
      _prefs.getBool('syncContactsEnabled') ?? false;
  set syncContactsEnabled(bool value) =>
      _prefs.setBool('syncContactsEnabled', value);

  // ************** ADS ***************
  DateTime get rewardEndDate {
    final int? milliseconds = _prefs.getInt('rewardEndDateMilliseconds');
    return milliseconds != null
        ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
        : DateTime.now().subtract(const Duration(days: 10));
  }

  set rewardEndDate(DateTime date) =>
      _prefs.setInt('rewardEndDateMilliseconds', date.millisecondsSinceEpoch);

  // ************ EVENTS **************
  bool get isMonthFormat => _prefs.getBool('isMonthFormat') ?? true;
  set isMonthFormat(bool value) => _prefs.setBool('isMonthFormat', value);

  int get startDayOfWeek => _prefs.getInt('startDayOfWeek') ?? 0;
  set startDayOfWeek(int value) => _prefs.setInt('startDayOfWeek', value);
}
