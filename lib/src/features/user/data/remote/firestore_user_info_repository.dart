import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_info_repository.dart';

class FirestoreUserInfoRepository implements IUserInfoRepository {
  final FirebaseFirestore firestoreInstance;
  FirestoreUserInfoRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createUserDocument(
      UserEntity user) async {
    final String uid = user.uid;
    final Map<String, dynamic> userMap = user.toMap();
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
  Future<Either<DatabaseFailure, UserEntity>> readUserDocument(
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
          DateTime.now().subtract(const Duration(days: 30)); //TODO test
      userMap['created'] =
          userMap['created']?.toDate() ?? DateTime.now(); //TODO test
      userMap['modified'] =
          userMap['modified']?.toDate() ?? DateTime.now(); //TODO test
      return right(UserEntity.fromMap(userMap));
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(
      UserEntity user) async {
    final String uid = user.uid;
    final Map<String, dynamic> userMap = user.toMap();
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
