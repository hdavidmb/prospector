import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../../../core/user_collections/data/local/hive_user_collection_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import '../../../core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import '../data/firebase_statistics_repository.dart';
import '../domain/statistics_use_cases.dart';
import 'statistics_notifier.dart';

// * Repositories
final remoteStatisticsRepository =
    Provider<IUserCollectionRemoteRepository>((ref) {
  return FirebaseStatisticsRepository(
    firestoreInstance: ref.watch(firestoreInstance),
  );
});

final localStatisticsRepository =
    Provider<IUserCollectionLocalRepository>((ref) {
  return HiveUserCollectionRepository(collectionName: 'statistics');
});

// * Use cases
final statisticsUseCases = Provider<StatisticsUseCases>((ref) {
  final _localStatisticsRepository = ref.watch(localStatisticsRepository);
  final _remoteStatisticsRepository = ref.watch(remoteStatisticsRepository);
  return StatisticsUseCases(
    localStatisticsRepository: _localStatisticsRepository,
    remoteStatisticsRepository: _remoteStatisticsRepository,
  );
});

// * Notifier
final statisticsNotifierProvider =
    ChangeNotifierProvider<StatisticsNotifier>((ref) {
  final StatisticsUseCases _statisticsUseCases = ref.watch(statisticsUseCases);
  return StatisticsNotifier(
    statisticsUseCases: _statisticsUseCases,
    read: ref.read,
  );
});
