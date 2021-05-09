import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_remote_repository.dart';

class FirebaseContactsRepository implements IContactsRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  FirebaseContactsRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createContactDocument(
      {required Contact contact, required String uid}) async {
    //TODO test
    final Map<String, dynamic> contactMap = contact.toMap();
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('contacts')
          .doc(contact.id)
          .set(contactMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteContactDocument(
      {required String contactID, required String uid}) async {
    //TODO test
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('contacts')
          .doc(contactID)
          .delete();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Contact>>> getContactsList(
      {required String uid}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> contactsSnapshot =
          await firestoreInstance
              .collection('users')
              .doc(uid)
              .collection('contacts')
              .get();
      // * Transform timestamps into DateTimes and complete with required info
      final List<Contact> contacts = contactsSnapshot.docs.map((contactDoc) {
        final Map<String, dynamic> contactMap = contactDoc.data();
        contactMap['id'] = contactDoc.id;
        contactMap['created'] =
            contactMap['created']?.toDate() ?? DateTime.now();
        contactMap['modified'] =
            contactMap['modified']?.toDate() ?? DateTime.now();

        return Contact.fromMap(contactMap);
      }).toList();
      return right(contacts);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateContactDocument(
      {required Contact contact, required String uid}) async {
    //TODO test
    final Map<String, dynamic> contactMap = contact.toMap();
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('contacts')
          .doc(contact.id)
          .update(contactMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
