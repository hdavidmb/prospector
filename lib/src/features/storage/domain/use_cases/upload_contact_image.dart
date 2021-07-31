import 'package:dartz/dartz.dart';

import '../failures/storage_failure.dart';
import '../interface/i_storage_repository.dart';

class UploadContactImage {
  final IStorageRepository storageRepository;
  UploadContactImage({
    required this.storageRepository,
  });

  Future<Either<StorageFailure, String>> call(
          {required String uid,
          required String contactID,
          required dynamic image}) =>
      storageRepository.uploadContactImage(
          uid: uid, contactID: contactID, image: image);
}
