import 'package:dartz/dartz.dart';

import 'package:prospector/src/core/database/dabase_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';


abstract class IAppDefaultDataRepository {
  Future<Either<DatabaseFailure, List<Status>>> getStatusList();
  Future<Either<DatabaseFailure, List<Subscription>>> getSubscriptionList();
}