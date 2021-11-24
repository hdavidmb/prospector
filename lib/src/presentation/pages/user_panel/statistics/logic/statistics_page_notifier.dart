import 'package:flutter/foundation.dart';

class StatisticsPageNotifier extends ChangeNotifier {
  bool _includeNotInterested = false;

  bool get includeNotInterested => _includeNotInterested;
  set includeNotInterested(bool value) {
    _includeNotInterested = value;
    notifyListeners();
  }
}
