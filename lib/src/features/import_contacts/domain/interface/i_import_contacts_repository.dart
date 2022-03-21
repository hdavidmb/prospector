import 'package:dartz/dartz.dart';

import '../entity/imported_contact_entity.dart';
import '../failures/import_contacts_failure.dart';

abstract class IImportContactsRepository {
  Future<Either<ImportContactsFailure, List<ImportedContact>>>
      getDeviceContacts();
  void addContactsListener(dynamic Function() callback);
  void removeContactsListener(void Function() callback);
}
