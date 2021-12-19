import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/connection/connection_checker.dart';
import '../../../../core/database/database_failures/database_failure.dart';
import '../../domain/interfaces/i_user_info_repository.dart';

class FirestoreUserInfoRepository implements IUserInfoRepository {
  final FirebaseFirestore firestoreInstance;
  FirestoreUserInfoRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createUserDocument(
      Map<String, dynamic> userMap) async {
    final String uid = userMap['uid'] as String;
    try {
      await firestoreInstance.collection('users').doc(uid).set(userMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteUserDocument(
      {required String uid}) async {
    try {
      await firestoreInstance.collection('users').doc(uid).delete();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Map<String, dynamic>>> readUserDocument(
      {required String uid}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      // * Transform timestamps into DateTimes and complete with required info
      final userMap = userDocSnapshot.data()!;
      userMap['uid'] = userDocSnapshot.id;
      userMap['name'] = userMap['name'] ?? '';
      userMap['expiry_date'] = userMap['expiry_date']?.toDate() ??
          DateTime.now().subtract(const Duration(days: 30));
      userMap['created'] = userMap['created']?.toDate() ?? DateTime.now();
      userMap['modified'] = userMap['modified']?.toDate() ?? DateTime.now();
      return right(userMap);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(
      Map<String, dynamic> userMap) async {
    final String uid = userMap['uid'] as String;
    try {
      firestoreInstance.collection('users').doc(uid).update(userMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> userDocumentExists(
      {required String uid}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      return right(userDocSnapshot.exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
