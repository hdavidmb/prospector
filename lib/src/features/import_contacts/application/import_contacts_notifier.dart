import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs_provider.dart';

import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/add_contacts_listener.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_device_contacts.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class ImportContactsNotifier extends ChangeNotifier {
  final GetDeviceContacts getDeviceContacts;
  final AddContactsListener addContactsListener;
  final Reader read;
  ImportContactsNotifier({
    required this.getDeviceContacts,
    required this.addContactsListener,
    required this.read,
  });

  List<ImportedContact> _deviceContacts = [];
  ImportContactsState _state = const ImportContactsState.initial();

  List<ImportedContact> get deviceContacts => _deviceContacts;
  ImportContactsState get state => _state;

  bool _listenerAdded = false;

  Future<void> getContacts() async {
    _state = const ImportContactsState.initial();
    notifyListeners();

    final result = await getDeviceContacts();
    result.fold(
      (failure) => _state = ImportContactsState.error(failure),
      (contacts) {
        _deviceContacts = contacts;
        _state = const ImportContactsState.ready();
      },
    );

    notifyListeners();
  }

  void setSyncContacts() {
    final bool isPremiumUser = read(userInfoNotifierProvider).isPremiumUser;
    final bool syncContactsEnabled = read(userSharedPrefsProvider).syncContactsEnabled;
    if (isPremiumUser && syncContactsEnabled) {
      if (!_listenerAdded) {
        _listenerAdded = true;
        addContactsListener(
          () {
            //TODO implement contacts sync
          }
        );
      }
    }

  }
}
