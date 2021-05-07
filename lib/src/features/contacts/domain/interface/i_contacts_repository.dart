import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';

abstract class IContactsRepository {
  // TODO Collection exists
  Future<Either<DatabaseFailure, bool>> contactsCollectionExists({required String uid});
  // TODO CRUD
  Future<Either<DatabaseFailure, Unit>> createContactDocument(Contact contact);
  Future<Either<DatabaseFailure, List<Contact>>> getContactsList({required String uid});
  Future<Either<DatabaseFailure, Unit>> updateContactDocument(Contact contact);
  Future<Either<DatabaseFailure, Unit>> deleteContactDocument({required String contactID});
}