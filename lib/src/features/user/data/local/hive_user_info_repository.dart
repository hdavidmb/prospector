import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/database/database_failures/database_failure.dart';
// import '../../domain/entity/user_entity.dart';
import '../../domain/interfaces/i_user_info_repository.dart';

class HiveUserInfoRepository implements IUserInfoRepository {
  @override
  Future<Either<DatabaseFailure, Unit>> deleteUserDocument(
      {required String uid}) async {
    try {
      final Box<Map<dynamic, dynamic>> box = await _checkOpenBox(uid: uid);
      box.deleteFromDisk();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Map<String, dynamic>>> readUserDocument(
      {required String uid}) async {
    try {
      final Box<Map<dynamic, dynamic>> box = await _checkOpenBox(uid: uid);
      final user = box.get(uid)!;
      return right(Map<String, dynamic>.from(user));
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> userDocumentExists(
      {required String uid}) async {
    try {
      final bool exists = await Hive.boxExists('$uid-map');
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> createUserDocument(
          Map<String, dynamic> user) =>
      saveUser(user);

  @override
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(
          Map<String, dynamic> user) =>
      saveUser(user);

  Future<Either<DatabaseFailure, Unit>> saveUser(
      Map<String, dynamic> user) async {
    try {
      final Box<Map<dynamic, dynamic>> box =
          await _checkOpenBox(uid: user['uid'] as String);
      box.put(user['uid'], user);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  Future<Box<Map<dynamic, dynamic>>> _checkOpenBox(
      {required String uid}) async {
    if (!Hive.isBoxOpen('$uid-map')) {
      return Hive.openBox<Map<dynamic, dynamic>>('$uid-map');
    } else {
      return Hive.box<Map<dynamic, dynamic>>('$uid-map');
    }
  }
}
