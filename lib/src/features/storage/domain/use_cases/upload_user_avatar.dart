import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/storage/domain/failures/storage_failure.dart';
import 'package:prospector/src/features/storage/domain/interface/i_storage_repository.dart';

class UploadUserAvatar {
  final IStorageRepository storageRepository;
  UploadUserAvatar({
    required this.storageRepository,
  });

  Future<Either<StorageFailure, String>> call({required String uid, required File image}) => storageRepository.uploadUserAvatar(uid: uid, image: image);
}
