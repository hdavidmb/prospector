import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../interfaces/i_interactions_local_repository.dart';
import '../interfaces/i_interactions_remote_repository.dart';

class DeleteInteractionDocument {
  final IInteractionsLocalRepository localInteractionsRepository;
  final IInteractionsRemoteRepository remoteInteractionsRepository;
  DeleteInteractionDocument({
    required this.localInteractionsRepository,
    required this.remoteInteractionsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required String interactionID, required String uid}) async {
    final localDelete = await localInteractionsRepository
        .deleteInteractionDocument(interactionID: interactionID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.deleteInteractionDocument(
            interactionID: interactionID, uid: uid);
        return right(unit);
      },
    );
  }
}
