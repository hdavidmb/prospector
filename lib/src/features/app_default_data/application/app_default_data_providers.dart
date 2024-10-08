import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/instances/database_instance_provider.dart';
import '../data/local/hive_app_default_data_repository.dart';
import '../data/remote/firestore_app_default_data_repository.dart';
import '../domain/interface/i_app_default_data_local_repository.dart';
import '../domain/interface/i_app_default_data_repository.dart';
import '../domain/use_cases/get_statuses.dart';
import '../domain/use_cases/get_subscriptions.dart';
import 'app_default_data_notifier.dart';

final remoteAppDefaultDataRepositoryProvider = Provider<IAppDefaultDataRemoteRepository>((ref) {
    return FirestoreAppDefaultDataRepository(firestoreInstance: ref.watch(firestoreInstance));
});

final localAppDefaultDataRepositoryProvider = Provider<IAppDefaultDataLocalRepository>((ref) {
    return HiveDefaultDataRepository();
});

// * Use cases
final getStatuses = Provider<GetStatuses>((ref) {
  final _remoteDefaultDataRepository = ref.watch(remoteAppDefaultDataRepositoryProvider);
  final _localDefaultDataRepository = ref.watch(localAppDefaultDataRepositoryProvider);
    return GetStatuses(remoteRepository: _remoteDefaultDataRepository, localRepository: _localDefaultDataRepository);
});

final getSubscriptions = Provider<GetSubscriptions>((ref) {
  final _remoteDefaultDataRepository = ref.watch(remoteAppDefaultDataRepositoryProvider);
  final _localDefaultDataRepository = ref.watch(localAppDefaultDataRepositoryProvider);
    return GetSubscriptions(remoteRepository: _remoteDefaultDataRepository, localRepository: _localDefaultDataRepository);
});

// * Data provider
final appDefaultDataProvider = ChangeNotifierProvider<AppDefaultDataNotifier>((ref) {
  final _getStatuses = ref.watch(getStatuses);
  final _getSubscriptions = ref.watch(getSubscriptions);
    return AppDefaultDataNotifier(getStatuses: _getStatuses, getSubscriptions: _getSubscriptions);
});