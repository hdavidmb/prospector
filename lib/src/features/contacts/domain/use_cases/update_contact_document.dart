import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/contact_entity.dart';
import '../interfaces/i_contacts_local_repository.dart';
import '../interfaces/i_contacts_remote_repository.dart';

class UpdateContactDocument {
  final IContactsLocalRepository localContactsRepository;
  final IContactsRemoteRepository remoteContactsRepository;
  UpdateContactDocument({
    required this.localContactsRepository,
    required this.remoteContactsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required Contact contact, required String uid}) async {
    final localUpdate = await localContactsRepository.updateContactDocument(
        contact: contact, uid: uid);
    return localUpdate.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.updateContactDocument(contact: contact, uid: uid);
        return right(unit);
      },
    );
  }
}
