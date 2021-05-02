import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:prospector/src/features/storage/domain/failures/storage_failure.dart';
import 'package:prospector/src/features/storage/domain/interface/i_storage_repository.dart';

class UploadContactImage {
  final IStorageRepository storageRepository;
  UploadContactImage({
    required this.storageRepository,
  });

  Future<Either<StorageFailure, String>> call({required String uid, required String contactID, required File image}) => storageRepository.uploadContactImage(uid: uid, contactID: contactID, image: image);
}
