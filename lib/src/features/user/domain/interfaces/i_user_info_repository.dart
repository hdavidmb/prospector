import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';

abstract class IUserInfoRepository {
  Future<Either<DatabaseFailure, bool>> userDocumentExists(
      {required String uid});

  // CRUD
  Future<Either<DatabaseFailure, Unit>> createUserDocument(
      Map<String, dynamic> user);
  Future<Either<DatabaseFailure, Map<String, dynamic>>> readUserDocument(
      {required String uid});
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(
      Map<String, dynamic> user);
  Future<Either<DatabaseFailure, Unit>> deleteUserDocument(
      {required String uid});
}
