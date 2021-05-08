import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/interfaces/i_contacts_local_repository.dart';

class HiveContactsRepository implements IContactsLocalRepository {
  @override
  Future<Either<DatabaseFailure, bool>> contactsCollectionExists(
      {required String uid}) async { // TODO test
    try {
      final bool exists = await Hive.boxExists('$uid/contacts');
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> createContactDocument(
          {required Contact contact, required String uid}) =>
      _saveContact(contact: contact, uid: uid); // TODO test

  @override
  Future<Either<DatabaseFailure, Unit>> deleteContactDocument(
      {required String contactID, required String uid}) async { // TODO test
    try {
      if (!Hive.isBoxOpen('$uid/contacts')) await Hive.openBox<Contact>('$uid/contacts');
      await Hive.box<Contact>('$uid/contacts').delete(contactID);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Contact>>> getContactsList(
      {required String uid}) async { // TODO test
    try {
      if (!Hive.isBoxOpen('$uid/contacts')) await Hive.openBox<Contact>('$uid/contacts');
      final contacts = Hive.box<Contact>('$uid/contacts').values.toList();
      return right(contacts);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateContactDocument(
          {required Contact contact, required String uid}) =>
      _saveContact(contact: contact, uid: uid); // TODO test

  Future<Either<DatabaseFailure, Unit>> _saveContact(
      {required Contact contact, required String uid}) async { // TODO test
    try {
      if (!Hive.isBoxOpen('$uid/contacts')) await Hive.openBox<Contact>('$uid/contacts');
      await Hive.box<Contact>('$uid/contacts').put(contact.id, contact);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
