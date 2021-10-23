import 'package:dartz/dartz.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'entity/tag_entity.dart';

class TagsUseCases {
  final IUserCollectionLocalRepository localTagsRepository;
  final IUserCollectionRemoteRepository remoteTagsRepository;
  TagsUseCases({
    required this.localTagsRepository,
    required this.remoteTagsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> createTag(
      {required Tag tag, required String uid}) async {
    final Map<String, dynamic> tagMap = tag.toMap();
    final localCreate =
        await localTagsRepository.createDocument(document: tagMap, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (unit) {
        remoteTagsRepository.createDocument(document: tagMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteTag(
      {required String tagID, required String uid}) async {
    final localDelete =
        await localTagsRepository.deleteDocument(docID: tagID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (unit) {
        remoteTagsRepository.deleteDocument(docID: tagID, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, List<Tag>>> getTagsList(
      {required String uid}) async {
    final localCheck = await localTagsRepository.collectionExists(uid: uid);
    // Check if exists locally
    return localCheck.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Map<String, dynamic>>> localGet =
              await localTagsRepository.getDocumentsList(uid: uid);
          return localGet.fold(
            (failure) => left(failure),
            (tagsMapsList) => right(
              tagsMapsList.map((tagMap) => Tag.fromMap(tagMap)).toList(),
            ),
          );
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Map<String, dynamic>>> remoteGet =
              await remoteTagsRepository.getDocumentsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (tagsMapsList) async {
              final List<Tag> tagsList = tagsMapsList.map((tagMap) {
                final Map<String, dynamic> newTagMap = tagMap;
                newTagMap['created'] =
                    tagMap['created']?.toDate() ?? DateTime.now();
                localTagsRepository.createDocument(
                    document: newTagMap, uid: uid);
                return Tag.fromMap(newTagMap);
              }).toList();
              return right(tagsList);
            },
          );
        }
      },
    );
  }
}
