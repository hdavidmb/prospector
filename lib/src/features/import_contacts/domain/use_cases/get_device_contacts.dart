import 'package:dartz/dartz.dart';

import '../entity/imported_contact_entity.dart';
import '../failures/import_contacts_failure.dart';
import '../interface/i_import_contacts_repository.dart';

class GetDeviceContacts {
  final IImportContactsRepository importContactsRepository;
  GetDeviceContacts({
    required this.importContactsRepository,
  });

  Future<Either<ImportContactsFailure, List<ImportedContact>>> call() =>
      importContactsRepository.getDeviceContacts();
}
