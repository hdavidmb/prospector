import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/storage/domain/failures/storage_failure.dart';

abstract class IStorageRepository {
  Future<Either<StorageFailure, String>> uploadUserAvatar({required String uid, required File image});
  Future<Either<StorageFailure, String>> uploadContactImage(
      {required String uid, required String contactID, required File image});
}
