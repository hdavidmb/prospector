import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:prospector/src/features/import_contacts/data/helpers/flutter_contacts_helper.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/import_contacts/domain/failures/import_contacts_failure.dart';
import 'package:prospector/src/features/import_contacts/domain/interface/i_import_contacts_repository.dart';

class ImportContactsRepository implements IImportContactsRepository {
  final FlutterContactsHelper flutterContacts;
  ImportContactsRepository({
    required this.flutterContacts,
  });

  @override
  Future<Either<ImportContactsFailure, List<ImportedContact>>>
      getDeviceContacts() async {
    try {
      final accessGranted = await flutterContacts.requestPermission();
      if (accessGranted) {
        final List<Contact> deviceContacts =
            await flutterContacts.getContacts(withProperties: true, withPhoto: true);
        final List<ImportedContact> importedContacts = deviceContacts
            .map(
              (contact) => ImportedContact(
                  importedID: contact.id,
                  name: contact.displayName,
                  phones: contact.phones.map((phone) => phone.number).toList(),
                  photo: contact.photo),
            )
            .toList();
        return right(importedContacts);
      } else {
        return left(const ImportContactsFailure.accessDenied());
      }
    } catch (e) {
      return left(const ImportContactsFailure.serverError());
    }
  }

  @override
  void addContactsListener(Function() callback) => flutterContacts.addListener(callback);
}
