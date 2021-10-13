import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entity/interaction_entity.dart';

abstract class IInteractionsRemoteRepository {
  Future<Either<DatabaseFailure, Unit>> createInteractionDocument(
      {required Interaction interaction, required String uid});
  Future<Either<DatabaseFailure, List<Interaction>>> getInteractionsList(
      {required String uid});
  Future<Either<DatabaseFailure, Unit>> updateInteractionDocument(
      {required Interaction interaction, required String uid});
  Future<Either<DatabaseFailure, Unit>> deleteInteractionDocument(
      {required String interactionID, required String uid});
}
