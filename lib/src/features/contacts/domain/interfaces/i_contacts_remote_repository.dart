import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';

abstract class IContactsRemoteRepository {
  Future<Either<DatabaseFailure, Unit>> createContactDocument({required Contact contact, required String uid});
  Future<Either<DatabaseFailure, List<Contact>>> getContactsList({required String uid});
  Future<Either<DatabaseFailure, Unit>> updateContactDocument({required Contact contact, required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteContactDocument({required String contactID, required String uid});
}