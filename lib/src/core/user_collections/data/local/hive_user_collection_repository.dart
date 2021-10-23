import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../database/database_failures/database_failure.dart';
import '../../domain/interfaces/i_user_collection_local_repository.dart';

class HiveUserCollectionRepository implements IUserCollectionLocalRepository {
  final String collectionName;
  HiveUserCollectionRepository({
    required this.collectionName,
  });

  @override
  Future<Either<DatabaseFailure, bool>> collectionExists(
      {required String uid}) async {
    try {
      final bool exists = await Hive.boxExists('$uid-$collectionName');
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> createDocument(
          {required Map<String, dynamic> document, required String uid}) =>
      _saveDocument(document: document, uid: uid);

  @override
  Future<Either<DatabaseFailure, Unit>> updateDocument(
          {required Map<String, dynamic> document, required String uid}) =>
      _saveDocument(document: document, uid: uid);

  Future<Either<DatabaseFailure, Unit>> _saveDocument(
      {required Map<String, dynamic> document, required String uid}) async {
    try {
      await _checkOpenBox(uid: uid);
      await Hive.box<Map<dynamic, dynamic>>('$uid-$collectionName')
          .put(document['id'], document);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteDocument(
      {required String docID, required String uid}) async {
    try {
      await _checkOpenBox(uid: uid);
      await Hive.box<Map<dynamic, dynamic>>('$uid-$collectionName')
          .delete(docID);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Map<String, dynamic>>>> getDocumentsList(
      {required String uid}) async {
    try {
      await _checkOpenBox(uid: uid);
      final documentsLis =
          Hive.box<Map<dynamic, dynamic>>('$uid-$collectionName')
              .values
              .toList();
      return right(
          documentsLis.map((map) => Map<String, dynamic>.from(map)).toList());
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  Future<void> _checkOpenBox({required String uid}) async {
    if (!Hive.isBoxOpen('$uid-$collectionName')) {
      await Hive.openBox<Map<dynamic, dynamic>>('$uid-$collectionName');
    }
  }
}
