import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/connection/connection_checker.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../../domain/entity/interaction_entity.dart';
import '../../domain/interfaces/i_interactions_remote_repository.dart';

class FirebaseInteractionsRepository implements IInteractionsRemoteRepository {
  final FirebaseFirestore firestoreInstance;
  FirebaseInteractionsRepository({
    required this.firestoreInstance,
  });

  @override
  Future<Either<DatabaseFailure, Unit>> createInteractionDocument(
      {required Interaction interaction, required String uid}) async {
    final Map<String, dynamic> interactionMap = interaction.toMap();
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('interactions')
          .doc(interaction.id)
          .set(interactionMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> deleteInteractionDocument(
      {required String interactionID, required String uid}) async {
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('interactions')
          .doc(interactionID)
          .delete();
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, List<Interaction>>> getInteractionsList(
      {required String uid}) async {
    final bool isConnected = await checkConnection();
    if (!isConnected) return left(const DatabaseFailure.noConnection());
    try {
      final QuerySnapshot<Map<String, dynamic>> interactionsSnapshot =
          await firestoreInstance
              .collection('users')
              .doc(uid)
              .collection('interactions')
              .get();
      // * Transform timestamps into DateTimes and complete with required info
      final List<Interaction> interactions =
          interactionsSnapshot.docs.map((interactionDoc) {
        final Map<String, dynamic> interactionMap = interactionDoc.data();
        interactionMap['id'] = interactionDoc.id;
        interactionMap['created'] =
            interactionMap['created']?.toDate() ?? DateTime.now();
        return Interaction.fromMap(interactionMap);
      }).toList();
      return right(interactions);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }

  @override
  Future<Either<DatabaseFailure, Unit>> updateInteractionDocument(
      {required Interaction interaction, required String uid}) async {
    final Map<String, dynamic> interactionMap = interaction.toMap();
    try {
      await firestoreInstance
          .collection('users')
          .doc(uid)
          .collection('interactions')
          .doc(interaction.id)
          .set(interactionMap);
      return right(unit);
    } catch (e) {
      return left(const DatabaseFailure.serverError());
    }
  }
}
