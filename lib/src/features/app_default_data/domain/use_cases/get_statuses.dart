import 'package:dartz/dartz.dart';

import 'package:prospector/src/core/database/dabase_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_repository.dart';

class GetStatuses {
  final IAppDefaultDataRepository appDefaultDataRepository;
  GetStatuses({
    required this.appDefaultDataRepository,
  });

  Future<Either<DatabaseFailure, List<Status>>> call() {
    return appDefaultDataRepository.getStatusList();
  }
}
