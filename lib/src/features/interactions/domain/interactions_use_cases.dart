import 'package:dartz/dartz.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'entity/interaction_entity.dart';

class InteractionsUseCases {
  final IUserCollectionLocalRepository localInteractionsRepository;
  final IUserCollectionRemoteRepository remoteInteractionsRepository;
  InteractionsUseCases({
    required this.localInteractionsRepository,
    required this.remoteInteractionsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> createInteraction(
      {required Interaction interaction, required String uid}) async {
    final Map<String, dynamic> interactionMap = interaction.toMap();
    final localCreate = await localInteractionsRepository.createDocument(
        document: interactionMap, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.createDocument(
            document: interactionMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> updateInteraction(
      {required Interaction interaction, required String uid}) async {
    final Map<String, dynamic> interactionMap = interaction.toMap();
    final localUpdate = await localInteractionsRepository.updateDocument(
        document: interactionMap, uid: uid);
    return localUpdate.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.updateDocument(
            document: interactionMap, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, Unit>> deleteInteraction(
      {required String interactionID, required String uid}) async {
    final localDelete = await localInteractionsRepository.deleteDocument(
        docID: interactionID, uid: uid);
    return localDelete.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.deleteDocument(
            docID: interactionID, uid: uid);
        return right(unit);
      },
    );
  }

  Future<Either<DatabaseFailure, List<Interaction>>> getInteractionsList(
      {required String uid}) async {
    // Check if exists locally
    final localCheckResult =
        await localInteractionsRepository.collectionExists(uid: uid);
    return localCheckResult.fold(
      (failure) => left(failure),
      (existsLocally) async {
        if (existsLocally) {
          // yes? -> get and return local contacts list
          final Either<DatabaseFailure, List<Map<String, dynamic>>> localGet =
              await localInteractionsRepository.getDocumentsList(uid: uid);
          return localGet.fold(
            (failure) => left(failure),
            (interactionsMapsList) => right(
              interactionsMapsList
                  .map((interactionMap) => Interaction.fromMap(interactionMap))
                  .toList(),
            ),
          );
        } else {
          // no? -> get remote contacts list, save it locally and return it
          final Either<DatabaseFailure, List<Map<String, dynamic>>> remoteGet =
              await remoteInteractionsRepository.getDocumentsList(uid: uid);
          return remoteGet.fold(
            (failure) => left(failure),
            (interactionsMapsList) async {
              final List<Interaction> interactionsList =
                  interactionsMapsList.map(
                (interactionMap) {
                  interactionMap['created'] =
                      interactionMap['created']?.toDate() ?? DateTime.now();

                  localInteractionsRepository.createDocument(
                      document: interactionMap, uid: uid);

                  return Interaction.fromMap(interactionMap);
                },
              ).toList();
              return right(interactionsList);
            },
          );
        }
      },
    );
  }
}
