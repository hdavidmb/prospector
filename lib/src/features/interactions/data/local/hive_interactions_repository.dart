import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../../domain/entity/interaction_entity.dart';
import '../../domain/interfaces/i_interactions_local_repository.dart';

class HiveInteractionsRepository implements IInteractionsLocalRepository {
  @override
  Future<Either<DatabaseFailure, bool>> interactionsCollectionExists(
      {required String uid}) async {
    try {
      final bool exists = await Hive.boxExists('$uid-interactions');
      return right(exists);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> createInteractionDocument(
          {required Interaction interaction, required String uid}) =>
      _saveInteraction(interaction: interaction, uid: uid);

  @override
  Future<Either<DatabaseFailure, Unit>> deleteInteractionDocument(
      {required String interactionID, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-interactions')) {
        await Hive.openBox<Interaction>('$uid-interactions');
      }
      await Hive.box<Interaction>('$uid-interactions').delete(interactionID);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Interaction>>> getInteractionsList(
      {required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-interactions')) {
        await Hive.openBox<Interaction>('$uid-interactions');
      }
      final interactions =
          Hive.box<Interaction>('$uid-interactions').values.toList();
      return right(interactions);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateInteractionDocument(
          {required Interaction interaction, required String uid}) =>
      _saveInteraction(interaction: interaction, uid: uid);

  Future<Either<DatabaseFailure, Unit>> _saveInteraction(
      {required Interaction interaction, required String uid}) async {
    try {
      if (!Hive.isBoxOpen('$uid-interactions')) {
        await Hive.openBox<Interaction>('$uid-interactions');
      }
      await Hive.box<Interaction>('$uid-interactions')
          .put(interaction.id, interaction);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
