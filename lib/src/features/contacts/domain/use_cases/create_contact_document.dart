import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_local_repository.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_remote_repository.dart';

class CreateContactDocument {
  final IContactsLocalRepository localContactsRepository;
  final IContactsRemoteRepository remoteContactsRepository;
  CreateContactDocument({
    required this.localContactsRepository,
    required this.remoteContactsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required Contact contact, required String uid}) async {
    final localCreate = await localContactsRepository.createContactDocument(
        contact: contact, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.createContactDocument(contact: contact, uid: uid);
        return right(unit);
      },
    );
  }
}
