import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entities/status_entity.dart';
import '../entities/subscription_entity.dart';


abstract class IAppDefaultDataRemoteRepository {
  Future<Either<DatabaseFailure, List<Status>>> getStatusList();
  Future<Either<DatabaseFailure, List<Subscription>>> getSubscriptionList();
}