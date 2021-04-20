import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/user/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/user/domain/interfaces/i_user_data_remote_repository.dart';

class FirebaseUserDataRepository implements IUserDataRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  FirebaseUserDataRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createUserDocument(
      UserEntity user) async {
    //TODO test
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
    //TODO test
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
    //TODO test
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.serverError());
    try {
      final DocumentSnapshot userDocSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      final userMap = userDocSnapshot.data()!;
      userMap['uid'] = userDocSnapshot.id;
      return right(UserEntity.fromMap(userMap));
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateUserDocument(
      UserEntity user) async {
    //TODO test
    final String uid = user.uid;
    final Map<String, dynamic> userMap = user.toMap();
    try {
      await firestoreInstance.collection('users').doc(uid).update(userMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> userDocumentExists(
      {required String uid}) async {
    //TODO test
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.serverError());
    try {
      final DocumentSnapshot userDocSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      return right(userDocSnapshot.exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
