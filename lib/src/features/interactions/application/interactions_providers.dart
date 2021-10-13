import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// * Notifier
final interactionsNotifierProvider =
    ChangeNotifierProvider<InteractionsNotifier>((ref) {
  final _createInteractionDocument = ref.watch(createInteractionDocument);
  final _deleteInteractionDocument = ref.watch(deleteInteractionDocument);
  final _updateInteractionDocument = ref.watch(updateInteractionDocument);
  final _getInteractionsList = ref.watch(getInteractionsList);
  return InteractionsNotifier(
    createInteractionDocumentUC: _createInteractionDocument,
    deleteInteractionDocumentUC: _deleteInteractionDocument,
    updateInteractionDocumentUC: _updateInteractionDocument,
    getInteractionsListUC: _getInteractionsList,
    read: ref.read,
  );
});
