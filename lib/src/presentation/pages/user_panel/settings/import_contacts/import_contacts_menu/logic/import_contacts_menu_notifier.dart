import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';

class ImportContactsMenuNotifier extends ChangeNotifier {
  final UserSharedPreferences prefs;
  final Reader read;
  ImportContactsMenuNotifier({required this.prefs, required this.read}) {
    _syncContactsEnabled = prefs.syncContactsEnabled;
  }

  bool _syncContactsEnabled = false;
  bool get syncContactsEnabled => _syncContactsEnabled;

  Future<void> syncContactsSwitchTapped(
      BuildContext context, bool value) async {
    final isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (isPremium) {
      if (value) {
        //TODO show confirmation dialog
        final bool confirm = await showConfirmDialog(context: context);
      }
      prefs.syncContactsEnabled = value;
      _syncContactsEnabled = value;
      notifyListeners();
    } else {
      showPremiumDialog(context: context);
    }
  }
}
