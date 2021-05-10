import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/database/instances/database_instance_provider.dart';
import 'package:prospector/src/features/tags/application/tags_notifier.dart';
import 'package:prospector/src/features/tags/data/local/hive_tags_repository.dart';
import 'package:prospector/src/features/tags/data/remote/firebase_tags_repository.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_local_repository.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_remote_repository.dart';
import 'package:prospector/src/features/tags/domain/use_cases/create_tag_document.dart';
import 'package:prospector/src/features/tags/domain/use_cases/delete_tag_document.dart';
import 'package:prospector/src/features/tags/domain/use_cases/get_tags_list.dart';

// * Repositories
final remoteTagsRepository = Provider<ITagsRemoteRepository>((ref) {
  return FirebaseTagsRepository(
      firestoreInstance: ref.watch(firestoreInstance));
});

final localTagsRepository = Provider<ITagsLocalRepository>((ref) {
  return HiveTagsRepository();
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

// * Notifier
final tagsNotifierProvider = ChangeNotifierProvider<TagsNotifier>((ref) {
  final _createTagDocument = ref.watch(createTagDocument);
  final _deleteTagDocument = ref.watch(deleteTagDocument);
  final _getTagsList = ref.watch(getTagsList);
  return TagsNotifier(
    createTagDocument: _createTagDocument,
    deleteTagDocument: _deleteTagDocument,
    getTagsList: _getTagsList,
    read: ref.read,
  );
});
