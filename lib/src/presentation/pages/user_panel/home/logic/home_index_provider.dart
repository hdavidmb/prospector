import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../../core/shared_prefs/shared_prefs_provider.dart';

final homeIndexProvider = ChangeNotifierProvider<HomeIndexNotifier>((ref) {
  final _prefs = ref.watch(userSharedPrefsProvider);
  return HomeIndexNotifier(prefs: _prefs);
});

class HomeIndexNotifier extends ChangeNotifier {
  final UserSharedPreferences prefs;
  HomeIndexNotifier({
    required this.prefs,
  }) {
    index = prefs.homeIndex;
  }

  int _index = 1;
  int get index => _index;
  set index(int value) {
    _index = value;
    prefs.homeIndex = value;
    notifyListeners();
  }
}
