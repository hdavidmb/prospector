import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';

abstract class IUserCollectionRemoteRepository {
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
