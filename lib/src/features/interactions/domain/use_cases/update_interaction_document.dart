import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/interaction_entity.dart';
import '../interfaces/i_interactions_local_repository.dart';
import '../interfaces/i_interactions_remote_repository.dart';

class UpdateInteractionDocument {
  final IInteractionsLocalRepository localInteractionsRepository;
  final IInteractionsRemoteRepository remoteInteractionsRepository;
  UpdateInteractionDocument({
    required this.localInteractionsRepository,
    required this.remoteInteractionsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required Interaction interaction, required String uid}) async {
    final localUpdate = await localInteractionsRepository
        .updateInteractionDocument(interaction: interaction, uid: uid);
    return localUpdate.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.updateInteractionDocument(
            interaction: interaction, uid: uid);
        return right(unit);
      },
    );
  }
}
