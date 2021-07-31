import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/auth/auth_helpers.dart';
import '../../auth/domain/auth_failure.dart';
import '../domain/interfaces/i_user_auth_profile_repository.dart';

class UserAuthProfileRepository implements IUserAuthProfileRepository {
  final FirebaseAuth firebaseAuthInstance;

  UserAuthProfileRepository({
    required this.firebaseAuthInstance,
  });

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {required String newPassword}) async {
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updatePassword(newPassword);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changeUserEmail(
      {required String newEmail}) async {
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updateEmail(newEmail);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteAccount() async {
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.delete();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserProfile(
      {String? displayName, String? photoURL}) async {
    final user = firebaseAuthInstance.currentUser!;
    try {
      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);

      //TODO test and delete updateProfile(displayName: displayName, photoURL: photoURL);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return manageFirebaseAuthExceptions(errorCode: e.code);
    }
  }

  @override
  String currentUserID() => firebaseAuthInstance.currentUser!.uid;

  @override
  String userDisplayName() =>
      firebaseAuthInstance.currentUser!.displayName ?? '';

  @override
  String userEmail() => firebaseAuthInstance.currentUser!.email ?? '';

  @override
  String userPhotoURL() => firebaseAuthInstance.currentUser!.photoURL ?? '';

  @override
  String userProvider() => firebaseAuthInstance.currentUser != null
      ? firebaseAuthInstance.currentUser!.providerData.last.providerId
      : '';
}
