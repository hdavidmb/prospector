import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/import_contacts/application/import_contacts_notifier.dart';
import 'package:prospector/src/features/import_contacts/data/helpers/flutter_contacts_helper.dart';
import 'package:prospector/src/features/import_contacts/data/import_contacts_repository.dart';
import 'package:prospector/src/features/import_contacts/domain/use_cases/get_device_contacts.dart';

// * Repository
final importContactsRepository = Provider<ImportContactsRepository>((ref) {
  final FlutterContactsHelper _flutterContacts = FlutterContactsHelper();
    return ImportContactsRepository(flutterContacts: _flutterContacts);
});

// * Use cases
final getDeviceContacts = Provider<GetDeviceContacts>((ref) {
  final _importContactsRepository = ref.watch(importContactsRepository);
    return GetDeviceContacts(importContactsRepository: _importContactsRepository);
});

// * Notifier
final importContactsProvider = ChangeNotifierProvider<ImportContactsNotifier>((ref) {
  final GetDeviceContacts _getDeviceContacts = ref.watch(getDeviceContacts);
    return ImportContactsNotifier(getDeviceContacts: _getDeviceContacts);
});