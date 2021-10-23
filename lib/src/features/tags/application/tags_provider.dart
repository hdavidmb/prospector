import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../../../core/user_collections/data/local/hive_user_collection_repository.dart';
import '../../../core/user_collections/data/remote/firebase_user_collection_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import '../domain/tags_use_cases.dart';
import 'tags_notifier.dart';

// * Repositories
final remoteTagsRepository = Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
    firestoreInstance: ref.watch(firestoreInstance),
    collectionName: 'tags',
  );
});

final localTagsRepository = Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'tags');
});

// * Use cases
final tagsUseCases = Provider<TagsUseCases>((ref) {
  final _localTagsRepository = ref.watch(localTagsRepository);
  final _remoteTagsRepository = ref.watch(remoteTagsRepository);
  return TagsUseCases(
      localTagsRepository: _localTagsRepository,
      remoteTagsRepository: _remoteTagsRepository);
});

// * Notifier
final tagsNotifierProvider = ChangeNotifierProvider<TagsNotifier>((ref) {
  final _tagsUseCases = ref.watch(tagsUseCases);
  return TagsNotifier(
    tagsUseCases: _tagsUseCases,
    read: ref.read,
  );
});
