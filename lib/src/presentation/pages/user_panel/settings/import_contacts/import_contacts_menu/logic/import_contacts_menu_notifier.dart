import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../generated/l10n.dart';
import '../../../../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../../../../features/import_contacts/application/import_contacts_providers.dart';
import '../../../../../../../features/user/application/user_info_providers.dart';
import '../../../../../../core/dialogs.dart';

class ImportContactsMenuNotifier extends ChangeNotifier {
  final UserSharedPreferences prefs;
  final Reader read;
  ImportContactsMenuNotifier({required this.prefs, required this.read}) {
    _syncContactsEnabled = prefs.syncContactsEnabled;
  }

  bool _syncContactsEnabled = false;
  bool get syncContactsEnabled => _syncContactsEnabled;

  Future<void> syncContactsSwitchTapped(BuildContext context,
      {required bool value}) async {
    final isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (isPremium) {
      final bool confirm = await showConfirmDialog(
          context: context,
          title: value
              ? AppLocalizations.current.enable
              : AppLocalizations.current.disable,
          message: value
              ? AppLocalizations.current.prospectorWillImportContacts
              : AppLocalizations.current.prospectorWillStopImporting,
          confirmText: AppLocalizations.current.ok);
      if (!confirm) return;

      await Future.delayed(Duration.zero, () async {
        final bool success = await read(importContactsProvider)
            .setSyncContacts(context: context, enabled: value);
        if (!success) return;
      });

      _syncContactsEnabled = value;
      notifyListeners();
    } else {
      showPremiumDialog(context: context);
    }
  }
}
