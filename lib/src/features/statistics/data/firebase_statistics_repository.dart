import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/connection/connection_checker.dart';
import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';

class FirebaseStatisticsRepository implements IUserCollectionRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  FirebaseStatisticsRepository({
    required this.firestoreInstance,
  }) {
    statisticsCollection = firestoreInstance.collection('statistics');
  }

  late CollectionReference<Map<String, dynamic>> statisticsCollection;

  @override
  Future<Either<DatabaseFailure, Unit>> createDocument(
      {required Map<String, dynamic> document, required String uid}) async {
    final String docID = document['id'] as String;
    final Map<String, dynamic> docMap = document;
    docMap.remove('id');
    try {
      await statisticsCollection.doc(docID).set(docMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteDocument(
      {required String docID, required String uid}) async {
    try {
      await statisticsCollection.doc(docID).delete();
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
          await statisticsCollection.where('user_id', isEqualTo: uid).get();

      final List<Map<String, dynamic>> statisticsList =
          collectionSnapshot.docs.map((document) {
        final Map<String, dynamic> docMap = document.data();
        docMap['id'] = document.id;
        return docMap;
      }).toList();

      return right(statisticsList);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateDocument(
      {required Map<String, dynamic> document, required String uid}) {
    throw UnimplementedError();
  }
}
