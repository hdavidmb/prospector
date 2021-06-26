import 'package:dartz/dartz.dart';

import '../../../auth/domain/auth_failure.dart';

abstract class IUserAuthProfileRepository {
  String currentUserID();
  String userProvider();
  String userDisplayName();
  String userEmail();
  String userPhotoURL();
  Future<Either<AuthFailure, Unit>> updateUserProfile({String? displayName, String? photoURL});
  Future<Either<AuthFailure, Unit>> changeUserEmail({required String newEmail});
  Future<Either<AuthFailure, Unit>> changePassword({required String newPassword});
  Future<Either<AuthFailure, Unit>> deleteAccount();
}