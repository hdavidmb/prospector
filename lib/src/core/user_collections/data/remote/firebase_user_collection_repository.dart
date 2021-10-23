import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';

class FirebaseUserCollectionRepository
    implements IUserCollectionRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  final String collectionName;
  FirebaseUserCollectionRepository({
    required this.firestoreInstance,
    required this.collectionName,
  });

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
    final String docID = document['id'] as String;
    final Map<String, dynamic> docMap = document;
    docMap.remove('id');
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection(collectionName)
          .doc(docID)
          .set(docMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteDocument(
      {required String docID, required String uid}) async {
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection(collectionName)
          .doc(docID)
          .delete();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Map<String, dynamic>>>> getDocumentsList(
      {required String uid}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> collectionSnapshot =
          await firestoreInstance
              .collection('users')
              .doc(uid)
              .collection(collectionName)
              .get();

      final List<Map<String, dynamic>> collectionList =
          collectionSnapshot.docs.map((document) {
        final Map<String, dynamic> docMap = document.data();
        docMap['id'] = document.id;
        return docMap;
      }).toList();

      return right(collectionList);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
