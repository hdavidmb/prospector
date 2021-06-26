import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/tag_entity.dart';
import '../interfaces/i_tags_local_repository.dart';
import '../interfaces/i_tags_remote_repository.dart';

class GetTagsList {
  final ITagsLocalRepository localTagsRepository;
  final ITagsRemoteRepository remoteTagsRepository;
  GetTagsList({
    required this.localTagsRepository,
    required this.remoteTagsRepository,
  });

  Future<Either<DatabaseFailure, List<Tag>>> call({required String uid}) async {
    final localCheck = await localTagsRepository.tagsCollectionExists(uid: uid);
    // Check if exists locally
    return localCheck.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Tag>> localGet =
              await localTagsRepository.getTagsList(uid: uid);
          return localGet;
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Tag>> remoteGet =
              await remoteTagsRepository.getTagsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (tagsList) async {
              for (final Tag tag in tagsList) {
                await localTagsRepository.createTagDocument(tag: tag, uid: uid);
              }
              return right(tagsList);
            },
          );
        }
      },
    );
  }
}
