import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/firebase_storage_repository.dart';
import '../domain/interface/i_storage_repository.dart';
import '../domain/use_cases/upload_contact_image.dart';
import '../domain/use_cases/upload_user_avatar.dart';

// * Repository
final storageRepository = Provider<IStorageRepository>((ref) {
  final _storageInstance = FirebaseStorage.instance;
  return FirebaseStorageRepository(storageInstance: _storageInstance);
});

// * Use Cases
final uploadUserAvatar = Provider<UploadUserAvatar>((ref) {
  final _storageRepository = ref.watch(storageRepository);
  return UploadUserAvatar(storageRepository: _storageRepository);
});

final uploadContactImage = Provider<UploadContactImage>((ref) {
  final _storageRepository = ref.watch(storageRepository);
    return UploadContactImage(storageRepository: _storageRepository);
});
