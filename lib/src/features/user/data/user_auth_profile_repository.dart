import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prospector/src/core/auth/auth_helpers.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';

import 'package:prospector/src/features/user/domain/interfaces/i_user_auth_profile_repository.dart';

class UserAuthProfileRepository implements IUserAuthProfileRepository {
  final FirebaseAuth firebaseAuthInstance;

  UserAuthProfileRepository({
    required this.firebaseAuthInstance,
  });

  @override
  Future<Either<AuthFailure, Unit>> changePassword({required String newPassword}) async { //TODO test
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updatePassword(newPassword);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      //TODO return AuthFailure (weakPassword)
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changeUserEmail({required String newEmail}) async { //TODO test
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updateEmail(newEmail);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      //TODO return AuthFailure
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteAccount() async { //TODO test
    final user = firebaseAuthInstance.currentUser!; // TODO test without connection
    try {
      await user.delete();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      //TODO return AuthFailure
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserProfile(
      {String? displayName, String? photoURL}) async { //TODO test
     final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updateProfile(displayName: displayName, photoURL: photoURL); //TODO test without connection
      return right(unit);
    } on FirebaseAuthException catch (e) {
      //TODO return AuthFailure
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  String currentUserID() => firebaseAuthInstance.currentUser!.uid; //TODO test

  @override
  String userDisplayName() =>
      firebaseAuthInstance.currentUser!.displayName ?? ''; //TODO test

  @override
  String userEmail() => firebaseAuthInstance.currentUser!.email ?? ''; //TODO test

  @override
  String userPhotoURL() => firebaseAuthInstance.currentUser!.photoURL ?? ''; //TODO test

  @override
  String userProvider() =>
      firebaseAuthInstance.currentUser!.providerData.last.providerId; //TODO test
}
