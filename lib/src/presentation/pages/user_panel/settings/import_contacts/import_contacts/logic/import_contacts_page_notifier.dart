import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_providers.dart';

import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/storage/domain/use_cases/upload_contact_image.dart';

class ImportContactsPageNotifier extends ChangeNotifier {
  final List<ImportedContact> deviceContacts;
  final UploadContactImage uploadContactImage;
  final Reader read;
  ImportContactsPageNotifier({
    required this.deviceContacts,
    required this.uploadContactImage,
    required this.read,
  });

  String _searchText = '';
  bool _importing = false;

  bool get importing => _importing;

  void searchTextChanged(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }

  List<ImportedContact> get notImportedContacts {
    final importedContactsIDs = read(contactsNotifierProvider)
        .contacts
        .where((contact) =>
            contact.importedId != null && contact.importedId!.isNotEmpty)
        .map((importedContact) => importedContact.importedId!)
        .toList();
    return deviceContacts
        .where((deviceContact) =>
            !importedContactsIDs.contains(deviceContact.importedID))
        .toList();
  }

  List<ImportedContact> get showingList => notImportedContacts
      .where(
        (deviceContact) =>
            _searchText.isEmpty ||
            deviceContact.name
                .toLowerCase()
                .contains(_searchText.toLowerCase()),
      )
      .toList();

  bool get allSelected =>
      notImportedContacts.every((contact) => contact.selected);

  void selectContact({required ImportedContact contact, bool? selected}) {
    final index = deviceContacts.indexOf(contact);
    deviceContacts[index] =
        contact.copyWith(selected: selected ?? !contact.selected);
    notifyListeners();
  }

  Future<void> importSelectedContacts() async {
    _importing = true;
    notifyListeners();
    deviceContacts
        .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    for (final ImportedContact contact in deviceContacts) {
      if (contact.selected) {
        read(importContactsProvider).importContact(contact);
      }
    }
    deviceContacts
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    _importing = false;
    notifyListeners();
  }

  void selectAllButtonPressed() {
    final bool _allSelected = allSelected;
    for (final ImportedContact contact in deviceContacts) {
      selectContact(contact: contact, selected: !_allSelected);
    }
    notifyListeners();
  }
}
