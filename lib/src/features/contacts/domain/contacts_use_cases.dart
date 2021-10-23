import 'package:dartz/dartz.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'entity/contact_entity.dart';

class ContactsUseCases {
  final IUserCollectionLocalRepository localContactsRepository;
  final IUserCollectionRemoteRepository remoteContactsRepository;
  ContactsUseCases({
    required this.localContactsRepository,
    required this.remoteContactsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> createContact(
      {required Contact contact, required String uid}) async {
    final Map<String, dynamic> contactMap = contact.toMap();
    final localCreate = await localContactsRepository.createDocument(
        document: contactMap, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.createDocument(document: contactMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> updateContact(
      {required Contact contact, required String uid}) async {
    final Map<String, dynamic> contactMap = contact.toMap();
    final localUpdate = await localContactsRepository.updateDocument(
        document: contactMap, uid: uid);
    return localUpdate.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.updateDocument(document: contactMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteContact(
      {required String contactID, required String uid}) async {
    final localDelete = await localContactsRepository.deleteDocument(
        docID: contactID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (unit) {
        remoteContactsRepository.deleteDocument(docID: contactID, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, List<Contact>>> getContactsList(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult =
        await localContactsRepository.collectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Map<String, dynamic>>> localGet =
              await localContactsRepository.getDocumentsList(uid: uid);
          return localGet.fold(
            (failure) => left(failure),
            (contactsMapsList) => right(
              contactsMapsList
                  .map((contactMap) => Contact.fromMap(contactMap))
                  .toList(),
            ),
          );
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Map<String, dynamic>>> remoteGet =
              await remoteContactsRepository.getDocumentsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (contactsMapsList) async {
              final List<Contact> contactsList = contactsMapsList.map(
                (contactMap) {
                  contactMap['created'] =
                      contactMap['created']?.toDate() ?? DateTime.now();
                  contactMap['modified'] =
                      contactMap['modified']?.toDate() ?? DateTime.now();
                  if (contactMap['phones'] != null) {
                    contactMap['phones'] = (contactMap['phones']
                            as List<dynamic>)
                        .map((phone) => phone.toString())
                        .toList(); //TODO try List<String>.from(contactMap['phones'])
                  }
                  if (contactMap['tags'] != null) {
                    contactMap['tags'] = (contactMap['tags'] as List<dynamic>)
                        .map((tag) => tag.toString())
                        .toList();
                  }

                  localContactsRepository.createDocument(
                      document: contactMap, uid: uid);

                  return Contact.fromMap(contactMap);
                },
              ).toList();
              return right(contactsList);
            },
          );
        }
      },
    );
  }
}
