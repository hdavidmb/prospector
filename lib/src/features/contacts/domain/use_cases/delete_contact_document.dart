import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_local_repository.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_remote_repository.dart';

class DeleteContactDocument {
  final IContactsLocalRepository localContactsRepository;
  final IContactsRemoteRepository remoteContactsRepository;
  DeleteContactDocument({
    required this.localContactsRepository,
    required this.remoteContactsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required String contactID, required String uid}) async {
    final localDelete = await localContactsRepository.deleteContactDocument(
        contactID: contactID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.deleteContactDocument(contactID: contactID, uid: uid);
        return right(unit);
      },
    );
  }
}
