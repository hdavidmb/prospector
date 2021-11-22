import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/database/instances/database_instance_provider.dart';
import 'package:prospector/src/core/user_collections/data/local/hive_user_collection_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_local_repository.dart';
import 'package:prospector/src/core/user_collections/domain/interfaces/i_user_collection_remote_repository.dart';
import 'package:prospector/src/features/statistics/application/statistics_notifier.dart';
import 'package:prospector/src/features/statistics/data/firebase_statistics_repository.dart';
import 'package:prospector/src/features/statistics/domain/statistics_use_cases.dart';

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
