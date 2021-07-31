import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../interfaces/i_tags_local_repository.dart';
import '../interfaces/i_tags_remote_repository.dart';

class DeleteTagDocument {
  final ITagsLocalRepository localTagsRepository;
  final ITagsRemoteRepository remoteTagsRepository;
  DeleteTagDocument({
    required this.localTagsRepository,
    required this.remoteTagsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required String tagID, required String uid}) async {
    final localDelete =
        await localTagsRepository.deleteTagDocument(tagID: tagID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (unit) {
        remoteTagsRepository.deleteTagDocument(tagID: tagID, uid: uid);
        return right(unit);
      },
    );
  }
}
