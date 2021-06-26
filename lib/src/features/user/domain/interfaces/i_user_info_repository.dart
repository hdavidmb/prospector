import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/user_entity.dart';

abstract class IUserInfoRepository {
  Future<Either<DatabaseFailure, bool>> userDocumentExists({required String uid});
  
  // CRUD
  Future<Either<DatabaseFailure, Unit>> createUserDocument(UserEntity user);
  Future<Either<DatabaseFailure, UserEntity>> readUserDocument({required String uid});
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(UserEntity user);
  Future<Either<DatabaseFailure, Unit>> deleteUserDocument({required String uid});
}