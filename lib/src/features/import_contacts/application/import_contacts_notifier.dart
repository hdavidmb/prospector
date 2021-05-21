import 'package:flutter/material.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';

import 'package:prospector/src/features/import_contacts/domain/use_cases/get_device_contacts.dart';

class ImportContactsNotifier extends ChangeNotifier {
  final GetDeviceContacts getDeviceContacts;
  ImportContactsNotifier({
    required this.getDeviceContacts,
  });

  late List<ImportedContact> _deviceContacts;
  ImportContactsState _state = const ImportContactsState.initial();

  List<ImportedContact> get deviceContacts => _deviceContacts;
  ImportContactsState get state => _state;

  Future<void> getContacts() async {
    _state = const ImportContactsState.initial();
    notifyListeners();

    final result = await getDeviceContacts();
    result.fold(
      (failure) => _state = ImportContactsState.error(failure),
      (contacts) {
        _deviceContacts = contacts;
        _state = const ImportContactsState.ready();
        //TODO implement contacts listener to reset state on changes
      },
    );

    notifyListeners();
  }
}
