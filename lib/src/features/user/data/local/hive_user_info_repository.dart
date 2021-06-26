import 'package:hive/hive.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_info_repository.dart';

class HiveUserInfoRepository implements IUserInfoRepository {
  @override
  Future<Either<DatabaseFailure, Unit>> createUserDocument(UserEntity user) => saveUser(user);

  @override
  Future<Either<DatabaseFailure, Unit>> deleteUserDocument(
      {required String uid}) async {
    try {
      if (!Hive.isBoxOpen(uid)) await Hive.openBox<UserEntity>(uid);
      Hive.box<UserEntity>(uid).deleteFromDisk();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, UserEntity>> readUserDocument(
      {required String uid}) async {
    try {
      if (!Hive.isBoxOpen(uid)) await Hive.openBox<UserEntity>(uid);
      final user = Hive.box<UserEntity>(uid).get(uid)!;
      return right(user);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(UserEntity user) => saveUser(user);

  @override
  Future<Either<DatabaseFailure, bool>> userDocumentExists(
      {required String uid}) async {
    try {
      final bool exists = await Hive.boxExists(uid);
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  Future<Either<DatabaseFailure, Unit>> saveUser(UserEntity user) async {
    try {
      if (!Hive.isBoxOpen(user.uid)) await Hive.openBox<UserEntity>(user.uid);
      await Hive.box<UserEntity>(user.uid).put(user.uid, user);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
