import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/shared_prefs/shared_prefs_provider.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_notifier.dart';
import 'package:prospector/src/features/import_contacts/data/helpers/flutter_contacts_helper.dart';
import 'package:prospector/src/features/import_contacts/data/hive_last_import_repository.dart';
import 'package:prospector/src/features/import_contacts/data/import_contacts_repository.dart';
import 'package:prospector/src/features/import_contacts/domain/interface/i_last_import_identifiers_repository.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/add_contacts_listener.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_device_contacts.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_last_import_identifiers.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/remove_contacts_listener.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/save_identifiers_list.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/save_single_identifier.dart';
import 'package:prospector/src/features/storage/application/storage_providers.dart';
import 'package:prospector/src/features/storage/domain/use_cases/upload_contact_image.dart';

// * Repository
final importContactsRepository = Provider<ImportContactsRepository>((ref) {
  final FlutterContactsHelper _flutterContacts = FlutterContactsHelper();
  return ImportContactsRepository(flutterContacts: _flutterContacts);
});

final lastImportIdentifiersRepository =
    Provider<HiveLastImportRepository>((ref) {
  return HiveLastImportRepository();
});

// * Use cases
final getDeviceContacts = Provider<GetDeviceContacts>((ref) {
  final _importContactsRepository = ref.watch(importContactsRepository);
  return GetDeviceContacts(importContactsRepository: _importContactsRepository);
});

final addContactsListener = Provider<AddContactsListener>((ref) {
  final _importContactsRepository = ref.watch(importContactsRepository);
  return AddContactsListener(
      importContactsRepository: _importContactsRepository);
});

final removeContactsListener = Provider<RemoveContactsListener>((ref) {
  final _importContactsRepository = ref.watch(importContactsRepository);
  return RemoveContactsListener(
      importContactsRepository: _importContactsRepository);
});

final getLastImportIdentifiers = Provider<GetLastImportIdentifiers>((ref) {
  final ILastImportIdentifiersRepository _lastImportIdentifiersRepository =
      ref.watch(lastImportIdentifiersRepository);
  return GetLastImportIdentifiers(
    lastImportIdentifiersRepository: _lastImportIdentifiersRepository,
  );
});

final saveIdentifiersList = Provider<SaveIdentifiersList>((ref) {
  final ILastImportIdentifiersRepository _lastImportIdentifiersRepository =
      ref.watch(lastImportIdentifiersRepository);
  return SaveIdentifiersList(
    lastImportIdentifiersRepository: _lastImportIdentifiersRepository,
  );
});

final saveSingleIdentifier = Provider<SaveSingleIdentifier>((ref) {
  final ILastImportIdentifiersRepository _lastImportIdentifiersRepository =
      ref.watch(lastImportIdentifiersRepository);
  return SaveSingleIdentifier(
    lastImportIdentifiersRepository: _lastImportIdentifiersRepository,
  );
});

// * Notifier
final importContactsProvider =
    ChangeNotifierProvider<ImportContactsNotifier>((ref) {
  final GetDeviceContacts _getDeviceContacts = ref.watch(getDeviceContacts);
  final AddContactsListener _addContactsListener =
      ref.watch(addContactsListener);
  final RemoveContactsListener _removeContactsListener =
      ref.watch(removeContactsListener);
  final GetLastImportIdentifiers _getLastImportIdentifiers =
      ref.watch(getLastImportIdentifiers);
  final SaveIdentifiersList _saveIdentifiersList =
      ref.watch(saveIdentifiersList);
  final SaveSingleIdentifier _saveSingleIdentifier =
      ref.watch(saveSingleIdentifier);
  final UploadContactImage _uploadContactImage = ref.watch(uploadContactImage);
  final _prefs = ref.watch(userSharedPrefsProvider);
  return ImportContactsNotifier(
    getDeviceContacts: _getDeviceContacts,
    addContactsListenerUC: _addContactsListener,
    removeContactsListenerUC: _removeContactsListener,
    getLastImportIdentifiers: _getLastImportIdentifiers,
    saveIdentifiersList: _saveIdentifiersList,
    saveSingleIdentifier: _saveSingleIdentifier,
    uploadContactImage: _uploadContactImage,
    prefs: _prefs,
    read: ref.read,
  );
});
