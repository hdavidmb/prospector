import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/auth/domain/auth_failure.dart';

abstract class IUserAuthProfileRepository {
  //TODO current user
  String currentUserID();
  String userProvider();
  String userDisplayName();
  String userEmail();
  String userPhotoURL();
  //TODO update profile (display name and photoURL)
  Future<Either<AuthFailure, Unit>> updateUserProfile({String? displayName, String? photoURL});
  //TODO change email
  Future<Either<AuthFailure, Unit>> changeUserEmail({required String newEmail});
  //TODO change password
  Future<Either<AuthFailure, Unit>> changePassword({required String newPassword});
  //TODO delete account
  Future<Either<AuthFailure, Unit>> deleteAccount();
}