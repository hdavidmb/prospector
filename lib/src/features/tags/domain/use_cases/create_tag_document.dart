import 'package:dartz/dartz.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/tags/domain/entity/tag_entity.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_local_repository.dart';
import 'package:prospector/src/features/tags/domain/interfaces/i_tags_remote_repository.dart';

class CreateTagDocument {
  final ITagsLocalRepository localTagsRepository;
  final ITagsRemoteRepository remoteTagsRepository;
  CreateTagDocument({
    required this.localTagsRepository,
    required this.remoteTagsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call( //TODO test
      {required Tag tag, required String uid}) async {
    final localCreate =
        await localTagsRepository.createTagDocument(tag: tag, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (unit) {
        remoteTagsRepository.createTagDocument(tag: tag, uid: uid);
        return right(unit);
      },
    );
  }
}
