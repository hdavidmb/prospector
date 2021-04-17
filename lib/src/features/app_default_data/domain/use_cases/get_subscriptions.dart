import 'package:dartz/dartz.dart';

import 'package:prospector/src/core/database/dabase_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_repository.dart';

class GetSubscriptions {
  final IAppDefaultDataRepository appDefaultDataRepository;
  GetSubscriptions({
    required this.appDefaultDataRepository,
  });

  Future<Either<DatabaseFailure, List<Subscription>>> call() {
    return appDefaultDataRepository.getSubscriptionList();
  }
}
