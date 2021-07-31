import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/contact_entity.dart';

abstract class IContactsLocalRepository {
  // Check existance
  Future<Either<DatabaseFailure, bool>> contactsCollectionExists({required String uid});
  // CRUD
  Future<Either<DatabaseFailure, Unit>> createContactDocument({required Contact contact, required String uid});
  Future<Either<DatabaseFailure, List<Contact>>> getContactsList({required String uid});
  Future<Either<DatabaseFailure, Unit>> updateContactDocument({required Contact contact, required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteContactDocument({required String contactID, required String uid});
}