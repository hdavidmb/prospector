import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/user_collections/data/local/hive_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/data/remote/firebase_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'package:prospector/src/features/interactions/domain/interactions_use_cases.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../data/local/hive_interactions_repository.dart';
import '../data/remote/firebase_interactions_repository.dart';
import '../domain/interfaces/i_interactions_local_repository.dart';
import '../domain/interfaces/i_interactions_remote_repository.dart';
import '../domain/use_cases/create_interaction_document.dart';
import '../domain/use_cases/delete_interaction_document.dart';
import '../domain/use_cases/get_interactions_list.dart';
import '../domain/use_cases/update_interaction_document.dart';
import 'interactions_notifier.dart';

// * Repositories
final remoteInteractionsRepository =
    Provider<IInteractionsRemoteRepository>((ref) {
  return FirebaseInteractionsRepository(
      firestoreInstance: ref.watch(firestoreInstance));
});

final localInteractionsRepository =
    Provider<IInteractionsLocalRepository>((ref) {
  return HiveInteractionsRepository();
});

// * New repositories
//TODO replace the old repositories
final newRemoteInteractionsRepository =
    Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
      firestoreInstance: ref.watch(firestoreInstance),
      collectionName: 'interactions');
});

final newLocalInteractionsRepository =
    Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'interactions');
});

// * Use cases
final createInteractionDocument = Provider<CreateInteractionDocument>((ref) {
  final _localInteractionsRepository = ref.watch(localInteractionsRepository);
  final _remoteInteractionsRepository = ref.watch(remoteInteractionsRepository);
  return CreateInteractionDocument(
    localInteractionsRepository: _localInteractionsRepository,
    remoteInteractionsRepository: _remoteInteractionsRepository,
  );
});

final deleteInteractionDocument = Provider<DeleteInteractionDocument>((ref) {
  final _localInteractionsRepository = ref.watch(localInteractionsRepository);
  final _remoteInteractionsRepository = ref.watch(remoteInteractionsRepository);
  return DeleteInteractionDocument(
    localInteractionsRepository: _localInteractionsRepository,
    remoteInteractionsRepository: _remoteInteractionsRepository,
  );
});

final updateInteractionDocument = Provider<UpdateInteractionDocument>((ref) {
  final _localInteractionsRepository = ref.watch(localInteractionsRepository);
  final _remoteInteractionsRepository = ref.watch(remoteInteractionsRepository);
  return UpdateInteractionDocument(
    localInteractionsRepository: _localInteractionsRepository,
    remoteInteractionsRepository: _remoteInteractionsRepository,
  );
});

final getInteractionsList = Provider<GetInteractionsList>((ref) {
  final _localInteractionsRepository = ref.watch(localInteractionsRepository);
  final _remoteInteractionsRepository = ref.watch(remoteInteractionsRepository);
  return GetInteractionsList(
    localInteractionsRepository: _localInteractionsRepository,
    remoteInteractionsRepository: _remoteInteractionsRepository,
  );
});

// * New use cases
//TODO replace old use cases
final interactionsUseCases = Provider<InteractionsUseCases>((ref) {
  final _localInteractionsRepository =
      ref.watch(newLocalInteractionsRepository);
  final _remoteInteractionsRepository =
      ref.watch(newRemoteInteractionsRepository);
  return InteractionsUseCases(
    localInteractionsRepository: _localInteractionsRepository,
    remoteInteractionsRepository: _remoteInteractionsRepository,
  );
});

// * Notifier
final interactionsNotifierProvider =
    ChangeNotifierProvider<InteractionsNotifier>((ref) {
  final _interactionUseCases = ref.watch(interactionsUseCases);
  return InteractionsNotifier(
    interactionsUseCases: _interactionUseCases,
    read: ref.read,
  );
});
