import 'package:flutter/material.dart';

class EventsPageNotifier extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  set selectedDay(DateTime date) {
    _selectedDay = date;
    notifyListeners();
  }

  bool _isMonthFormat = true; //TODO persist and get from prefs
  bool get isMonthFormat => _isMonthFormat;
  set isMonthFormat(bool value) {
    // TODO persist on prefs
    _isMonthFormat = value;
    notifyListeners();
  }
}
