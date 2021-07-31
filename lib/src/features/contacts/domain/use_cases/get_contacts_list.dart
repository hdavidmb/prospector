import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/contact_entity.dart';
import '../interfaces/i_contacts_local_repository.dart';
import '../interfaces/i_contacts_remote_repository.dart';

class GetContactsList {
  final IContactsLocalRepository localContactsRepository;
  final IContactsRemoteRepository remoteContactsRepository;
  GetContactsList({
    required this.localContactsRepository,
    required this.remoteContactsRepository,
  });

  Future<Either<DatabaseFailure, List<Contact>>> call(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult =
        await localContactsRepository.contactsCollectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Contact>> localGet =
              await localContactsRepository.getContactsList(uid: uid);
          return localGet;
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Contact>> remoteGet =
              await remoteContactsRepository.getContactsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (contactsList) async {
              for (final Contact contact in contactsList) {
                await localContactsRepository.createContactDocument(
                    contact: contact, uid: uid);
              }
              return right(contactsList);
            },
          );
        }
      },
    );
  }
}
