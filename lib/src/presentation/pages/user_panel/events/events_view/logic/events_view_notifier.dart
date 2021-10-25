import 'package:flutter/material.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';

class EventsViewNotifier extends ChangeNotifier {
  final UserSharedPreferences prefs;
  EventsViewNotifier({
    required this.prefs,
  }) {
    _isMonthFormat = prefs.isMonthFormat;
    _startDayOfWeek = prefs.startDayOfWeek;
  }

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  set selectedDay(DateTime date) {
    _selectedDay = date;
    notifyListeners();
  }

  bool _isMonthFormat = true;
  bool get isMonthFormat => _isMonthFormat;
  set isMonthFormat(bool value) {
    _isMonthFormat = value;
    prefs.isMonthFormat = value;
    notifyListeners();
  }

  int _startDayOfWeek = 0;
  int get startDayOfWeek => _startDayOfWeek;
  set startDayOfWeek(int value) {
    // TODO persist on prefs
    _startDayOfWeek = value;
    prefs.startDayOfWeek = value;
    notifyListeners();
  }
}
