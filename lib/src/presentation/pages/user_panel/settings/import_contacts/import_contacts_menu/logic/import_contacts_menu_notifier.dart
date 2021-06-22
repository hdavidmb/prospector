import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
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
      BuildContext context, {required bool value}) async {
    final isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (isPremium) {
      final bool confirm = await showConfirmDialog(
        context: context,
        title: value ? AppLocalizations.of(context)!.enable : AppLocalizations.of(context)!.disable,
        message: value ? AppLocalizations.of(context)!.prospectorWillImportContacts : AppLocalizations.of(context)!.prospectorWillStopImporting,
        confirmText: AppLocalizations.of(context)!.ok
      );
      if (!confirm) return;
      prefs.syncContactsEnabled = value;

      if (value) {
        final importContactsState = read(importContactsProvider).state;
        if (importContactsState != const ImportContactsState.ready()) await read(importContactsProvider).getContacts(context: context);
        final bool success = await read(importContactsProvider).setSyncContacts();
        if (!success) {
          prefs.syncContactsEnabled = !value;
          return;}
      } else {
        await read(importContactsProvider).removeContactsListener();
      }
      _syncContactsEnabled = value;
      notifyListeners();
    } else {
      showPremiumDialog(context: context);
    }
  }
}
