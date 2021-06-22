import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/import_contacts/domain/failures/import_contacts_failure.dart';

abstract class IImportContactsRepository {
  Future<Either<ImportContactsFailure, List<ImportedContact>>> getDeviceContacts();
  void addContactsListener(dynamic Function() callback);
  void removeContactsListener(void Function() callback);
}