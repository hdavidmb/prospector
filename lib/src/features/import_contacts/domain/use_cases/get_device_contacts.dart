import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';
import 'package:prospector/src/features/import_contacts/domain/failures/import_contacts_failure.dart';
import 'package:prospector/src/features/import_contacts/domain/interface/i_import_contacts_repository.dart';

class GetDeviceContacts {
  final IImportContactsRepository importContactsRepository;
  GetDeviceContacts({
    required this.importContactsRepository,
  });
  
  Future<Either<ImportContactsFailure, List<ImportedContact>>> call() => importContactsRepository.getDeviceContacts();
}
