import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs.dart';
import 'package:random_string/random_string.dart';

import 'package:prospector/src/core/shared_prefs/shared_prefs_provider.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_state.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/import_contacts/domain/failures/import_contacts_failure.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/add_contacts_listener.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_device_contacts.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_last_import_identifiers.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/remove_contacts_listener.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/save_identifiers_list.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/save_single_identifier.dart';
import 'package:prospector/src/features/storage/domain/use_cases/upload_contact_image.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';

class ImportContactsNotifier extends ChangeNotifier {
  final GetDeviceContacts getDeviceContacts;
  final AddContactsListener addContactsListenerUC;
  final RemoveContactsListener removeContactsListenerUC;
  final UploadContactImage uploadContactImage;
  final GetLastImportIdentifiers getLastImportIdentifiers;
  final SaveIdentifiersList saveIdentifiersList;
  final SaveSingleIdentifier saveSingleIdentifier;
  final UserSharedPreferences prefs;
  final Reader read;
  ImportContactsNotifier({
    required this.getDeviceContacts,
    required this.addContactsListenerUC,
    required this.removeContactsListenerUC,
    required this.uploadContactImage,
    required this.getLastImportIdentifiers,
    required this.saveIdentifiersList,
    required this.saveSingleIdentifier,
    required this.prefs,
    required this.read,
  });

  List<ImportedContact> _deviceContacts = [];
  List<String>? _lastImportIdentifiers;
  ImportContactsState _state = const ImportContactsState.initial();

  List<ImportedContact> get deviceContacts => _deviceContacts;
  ImportContactsState get state => _state;

  bool _listenerAdded = false;

  // ignore: prefer_function_declarations_over_variables
  void Function() _listener = () {};

  Future<bool> _contactsAccessNotDenied() async {
    final PermissionStatus contactsAccessStatus =
        await Permission.contacts.status;
    return !contactsAccessStatus.isDenied && !contactsAccessStatus.isPermanentlyDenied && !contactsAccessStatus.isLimited && !contactsAccessStatus.isRestricted;
  }

  void _showPermissionsDialog(BuildContext context) {
    showPermissionsDialog(
      context: context,
      title: AppLocalizations.of(context)!.contactsAccess,
      message: AppLocalizations.of(context)!.contactsAccessMessage,
    );
  }

  Future<bool> getContacts({required BuildContext context}) async {
    _state = const ImportContactsState.initial();
    notifyListeners();

    final accessNotDenied = await _contactsAccessNotDenied();
    if (!accessNotDenied) {
      _showPermissionsDialog(context);
      return false;
    }

    final result = await getDeviceContacts();
    result.fold(
      (failure) => _state = ImportContactsState.error(failure),
      (contacts) {
        _deviceContacts = contacts;
        _state = const ImportContactsState.ready();
      },
    );

    notifyListeners();
    return true;
  }

  Future<bool> setSyncContacts({required BuildContext context, required bool enabled}) async {
    final bool isPremiumUser = read(userInfoNotifierProvider).isPremiumUser;
    if (!isPremiumUser) return false;

    final accessNotDenied = await _contactsAccessNotDenied();
    if (!accessNotDenied) {
      _showPermissionsDialog(context);
      return false;
    }

    bool _success = true;
    if (enabled) {
      final result = await getDeviceContacts();
      await result.fold(
        (failure) {
          _state = ImportContactsState.error(failure);
          _success = false;
        },
        (contacts) async {
          final String uid = read(userInfoNotifierProvider).user.uid;
          _lastImportIdentifiers = contacts
              .map((ImportedContact contact) => contact.importedID)
              .toList();
          await saveIdentifiersList(
              identifiers: _lastImportIdentifiers!, uid: uid);
          _success = await addContactsListener(manualSetting: true);
        },
      );
    } else {
      await removeContactsListener();
    }
    prefs.syncContactsEnabled = _success && enabled;

    return _success;
  }

  Future<bool> addContactsListener({bool manualSetting = false}) async {
    final bool isPremiumUser = read(userInfoNotifierProvider).isPremiumUser;
    final bool syncContactsEnabled = manualSetting || 
        read(userSharedPrefsProvider).syncContactsEnabled;
    if (isPremiumUser && syncContactsEnabled) {
      //TODO check contacts permission
      final bool accessNotDenied = await _contactsAccessNotDenied();
      if (!accessNotDenied) { //TODO test
        prefs.syncContactsEnabled = false;
        return false;
      }
      if (!_listenerAdded) {
        _listenerAdded = true;
        final String uid = read(userInfoNotifierProvider).user.uid;
        if (_lastImportIdentifiers == null) {
          final result = await getLastImportIdentifiers(uid: uid);
          result.fold(
            (failure) {
              _state = const ImportContactsState.error(
                  ImportContactsFailure.serverError());
            },
            (List<String> identifiers) => _lastImportIdentifiers = identifiers,
          );
          if (result.isLeft()) {
            _listenerAdded = false;
            return false;
          }
        }
        _listener = () async {
          final contactsResult = await getDeviceContacts();
          contactsResult.fold(
            (failure) => _state = ImportContactsState.error(failure),
            (contacts) {
              for (final ImportedContact contact in contacts) {
                if (!_lastImportIdentifiers!.contains(contact.importedID)) {
                  importContact(contact);
                  saveSingleIdentifier(
                      identifier: contact.importedID, uid: uid);
                  _lastImportIdentifiers!.add(contact.importedID);
                }
              }
            },
          );
        };
        _listener();
        addContactsListenerUC(_listener);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> importContact(ImportedContact contact) async {
    final String notContactedID = read(appDefaultDataProvider).notContactedID;
    final newContactID = randomAlphaNumeric(20);
    String? downloadURL;
    if (contact.photo != null && contact.photo!.isNotEmpty) {
      final uid = read(userInfoNotifierProvider).user.uid;
      final uploadResult = await uploadContactImage(
          uid: uid, contactID: newContactID, image: contact.photo);
      uploadResult.fold(
        (failure) {},
        (url) => downloadURL = url,
      );
    }
    final newContact = Contact(
      id: newContactID,
      importedId: contact.importedID,
      name: contact.name,
      status: notContactedID,
      created: DateTime.now(),
      modified: DateTime.now(),
      phones: contact.phones,
      phone: contact.phones != null && contact.phones!.isNotEmpty
          ? contact.phones![0]
          : null,
      whatsapp: contact.phones != null && contact.phones!.isNotEmpty
          ? contact.phones![0]
          : null,
      photo: downloadURL,
    );
    await read(contactsNotifierProvider).createContact(newContact);
  }

  Future<void> removeContactsListener() async {
    _listenerAdded = false;
    return removeContactsListenerUC(_listener);
  }
}
