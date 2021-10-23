import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/user_collections/data/local/hive_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/data/remote/firebase_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'package:prospector/src/features/tags/domain/tags_use_cases.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../data/local/hive_tags_repository.dart';
import '../data/remote/firebase_tags_repository.dart';
import '../domain/interfaces/i_tags_local_repository.dart';
import '../domain/interfaces/i_tags_remote_repository.dart';
import '../domain/use_cases/create_tag_document.dart';
import '../domain/use_cases/delete_tag_document.dart';
import '../domain/use_cases/get_tags_list.dart';
import 'tags_notifier.dart';

// * Repositories
final remoteTagsRepository = Provider<ITagsRemoteRepository>((ref) {
  return FirebaseTagsRepository(
      firestoreInstance: ref.watch(firestoreInstance));
});

final localTagsRepository = Provider<ITagsLocalRepository>((ref) {
  return HiveTagsRepository();
});

// * New Repositories
//TODO test and replace old ones
final newRemoteTagsRepository =
    Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
    firestoreInstance: ref.watch(firestoreInstance),
    collectionName: 'tags',
  );
});

final newLocalTagsRepository = Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'tags');
});

// * Use cases
final createTagDocument = Provider<CreateTagDocument>((ref) {
  final _localTagsRepository = ref.watch(localTagsRepository);
  final _remoteTagsRepository = ref.watch(remoteTagsRepository);
  return CreateTagDocument(
      localTagsRepository: _localTagsRepository,
      remoteTagsRepository: _remoteTagsRepository);
});

final deleteTagDocument = Provider<DeleteTagDocument>((ref) {
  final _localTagsRepository = ref.watch(localTagsRepository);
  final _remoteTagsRepository = ref.watch(remoteTagsRepository);
  return DeleteTagDocument(
      localTagsRepository: _localTagsRepository,
      remoteTagsRepository: _remoteTagsRepository);
});

final getTagsList = Provider<GetTagsList>((ref) {
  final _localTagsRepository = ref.watch(localTagsRepository);
  final _remoteTagsRepository = ref.watch(remoteTagsRepository);
  return GetTagsList(
      localTagsRepository: _localTagsRepository,
      remoteTagsRepository: _remoteTagsRepository);
});

final tagsUseCases = Provider<TagsUseCases>((ref) {
  final _localTagsRepository = ref.watch(newLocalTagsRepository);
  final _remoteTagsRepository = ref.watch(newRemoteTagsRepository);
  return TagsUseCases(
      localTagsRepository: _localTagsRepository,
      remoteTagsRepository: _remoteTagsRepository);
});

// * Notifier
final tagsNotifierProvider = ChangeNotifierProvider<TagsNotifier>((ref) {
  // final _createTagDocument = ref.watch(createTagDocument);
  // final _deleteTagDocument = ref.watch(deleteTagDocument);
  // final _getTagsList = ref.watch(getTagsList);
  // return TagsNotifier(
  //   createTagDocument: _createTagDocument,
  //   deleteTagDocument: _deleteTagDocument,
  //   getTagsList: _getTagsList,
  //   read: ref.read,
  // );
  final _tagsUseCases = ref.watch(tagsUseCases);
  return TagsNotifier(
    tagsUseCases: _tagsUseCases,
    read: ref.read,
  );
});
