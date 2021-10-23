import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/user_collections/data/local/hive_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import 'package:prospector/src/features/events/domain/events_use_cases.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../../../core/user_collections/data/remote/firebase_user_collection_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';

// * Repositories
final remoteEventsRepository = Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseUserCollectionRepository(
    firestoreInstance: ref.watch(firestoreInstance),
    collectionName: 'events',
  );
});

final localEventsRepository = Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'events');
});

// * Use cases
final eventsUseCases = Provider<EventsUseCases>((ref) {
  final _localEventsRepository = ref.watch(localEventsRepository);
  final _remoteEventsRepository = ref.watch(remoteEventsRepository);
  return EventsUseCases(
    localEventsRepository: _localEventsRepository,
    remoteEventsRepository: _remoteEventsRepository,
  );
});

// * Notifier