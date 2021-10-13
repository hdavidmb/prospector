import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/interaction_entity.dart';
import '../interfaces/i_interactions_local_repository.dart';
import '../interfaces/i_interactions_remote_repository.dart';

class GetInteractionsList {
  final IInteractionsLocalRepository localInteractionsRepository;
  final IInteractionsRemoteRepository remoteInteractionsRepository;
  GetInteractionsList({
    required this.localInteractionsRepository,
    required this.remoteInteractionsRepository,
  });

  Future<Either<DatabaseFailure, List<Interaction>>> call(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult = await localInteractionsRepository
        .interactionsCollectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Interaction>> localGet =
              await localInteractionsRepository.getInteractionsList(uid: uid);
          return localGet;
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Interaction>> remoteGet =
              await remoteInteractionsRepository.getInteractionsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (interactionsList) async {
              for (final Interaction interaction in interactionsList) {
                await localInteractionsRepository.createInteractionDocument(
                    interaction: interaction, uid: uid);
              }
              return right(interactionsList);
            },
          );
        }
      },
    );
  }
}
