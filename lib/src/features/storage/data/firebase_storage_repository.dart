import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prospector/src/core/connection/connection_checker.dart';
import 'package:prospector/src/features/storage/domain/failures/storage_failure.dart';
import 'package:prospector/src/features/storage/domain/interface/i_storage_repository.dart';

class FirebaseStorageRepository implements IStorageRepository {
  final FirebaseStorage storageInstance;
  FirebaseStorageRepository({
    required this.storageInstance,
  });

  @override
  Future<Either<StorageFailure, String>> uploadContactImage(
      {required String uid, required String contactID, required dynamic image}) async {
    final String storageImagePath = (image is File)
        ? 'images/contacts_images/$uid/$contactID.jpg'
        : 'images/contacts_images/$uid/$contactID.png';
    return _performUploadTask(storageImagePath, image);
  }

  @override
  Future<Either<StorageFailure, String>> uploadUserAvatar(
      {required String uid, required File image}) async {
    final String storageImagePath = 'images/profile_images/$uid.jpg';
    return _performUploadTask(storageImagePath, image);
  }

  Future<Either<StorageFailure, String>> _performUploadTask(
      String storageImagePath, dynamic image) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const StorageFailure.noConnection());
    try {
      final Reference storageReference =
          storageInstance.ref().child(storageImagePath);

      if (image is File) {
        await storageReference.putFile(image);
      } else if (image is Uint8List) {
        await storageReference.putData(image);
      } else {
        return left(const StorageFailure.invalidFormat());
      }

      final downloadURL = await storageReference.getDownloadURL();
      return right(downloadURL);
    } on FirebaseException catch (_) {
      return left(const StorageFailure.serverError());
    }
  }
}
