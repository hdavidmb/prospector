import 'dart:io';

import 'package:dartz/dartz.dart';

import '../failures/storage_failure.dart';
import '../interface/i_storage_repository.dart';

class UploadUserAvatar {
  final IStorageRepository storageRepository;
  UploadUserAvatar({
    required this.storageRepository,
  });

  Future<Either<StorageFailure, String>> call({required String uid, required File image}) => storageRepository.uploadUserAvatar(uid: uid, image: image);
}
