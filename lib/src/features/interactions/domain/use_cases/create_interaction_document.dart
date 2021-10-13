import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/interaction_entity.dart';
import '../interfaces/i_interactions_local_repository.dart';
import '../interfaces/i_interactions_remote_repository.dart';

class CreateInteractionDocument {
  final IInteractionsLocalRepository localInteractionsRepository;
  final IInteractionsRemoteRepository remoteInteractionsRepository;
  CreateInteractionDocument({
    required this.localInteractionsRepository,
    required this.remoteInteractionsRepository,
  });

  Future<Either<DatabaseFailure, Unit>> call(
      {required Interaction interaction, required String uid}) async {
    final localCreate = await localInteractionsRepository
        .createInteractionDocument(interaction: interaction, uid: uid);
    return localCreate.fold(
      (failure) => left(failure),
      (_) {
        remoteInteractionsRepository.createInteractionDocument(
            interaction: interaction, uid: uid);
        return right(unit);
      },
    );
  }
}
