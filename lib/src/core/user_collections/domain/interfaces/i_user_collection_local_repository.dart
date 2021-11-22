import 'package:dartz/dartz.dart';

import '../../../database/database_failures/database_failure.dart';

//TODO: proposal - unify local and remote repositories interface. The only difference is the collection exists method and can be ingnored in the remote implementation
abstract class IUserCollectionLocalRepository {
  // Check existance
  Future<Either<DatabaseFailure, bool>> collectionExists({required String uid});
  // CRUD
  Future<Either<DatabaseFailure, Unit>> createDocument(
      {required Map<String, dynamic> document, required String uid});
  Future<Either<DatabaseFailure, List<Map<String, dynamic>>>> getDocumentsList(
      {required String uid});
  Future<Either<DatabaseFailure, Unit>> updateDocument(
      {required Map<String, dynamic> document, required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteDocument(
      {required String docID, required String uid});
}
