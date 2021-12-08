import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entities/status_entity.dart';
import '../interface/i_app_default_data_local_repository.dart';
import '../interface/i_app_default_data_repository.dart';

class GetStatuses {
  final IAppDefaultDataRemoteRepository remoteRepository;
  final IAppDefaultDataLocalRepository localRepository;
  GetStatuses({
    required this.remoteRepository,
    required this.localRepository,
  });

  Future<Either<DatabaseFailure, List<Status>>> call() async {
    final localExists = await localRepository.statusesExists();
    if (!localExists) {
      final result = await remoteRepository.getStatusList();
      return result.fold(
        (failure) {
          return left(failure);
        },
        (statuses) {
          final List<Map<String, dynamic>> statusesMapsList =
              statuses.map((status) => status.toMap()).toList();
          localRepository.saveStatuses(statuses: statusesMapsList);
          return right(statuses);
        },
      );
    }
    final List<Map<String, dynamic>> statusesMapsList =
        await localRepository.getStatuses();
    final List<Status> statuses =
        statusesMapsList.map((statusMap) => Status.fromMap(statusMap)).toList();
    return right(statuses);
  }
}
