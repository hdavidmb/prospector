import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../../../core/user_collections/data/local/hive_user_collection_repository.dart';
import '../../../core/user_collections/data/remote/firebase_user_collection_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import '../domain/interactions_use_cases.dart';
import 'interactions_notifier.dart';

// * Repositories
final remoteInteractionsRepository =
    Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
      firestoreInstance: ref.watch(firestoreInstance),
      collectionName: 'interactions');
});

final localInteractionsRepository =
    Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'interactions');
});

// * Use cases
final interactionsUseCases = Provider<InteractionsUseCases>((ref) {
  final _localInteractionsRepository = ref.watch(localInteractionsRepository);
  final _remoteInteractionsRepository = ref.watch(remoteInteractionsRepository);
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
