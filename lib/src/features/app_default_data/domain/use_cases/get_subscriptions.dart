import 'package:dartz/dartz.dart';

import 'package:prospector/src/core/database/dabase_failures/database_failure.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_local_repository.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_repository.dart';

class GetSubscriptions {
  final IAppDefaultDataRemoteRepository remoteRepository;
  final IAppDefaultDataLocalRepository localRepository;
  GetSubscriptions({
    required this.remoteRepository,
    required this.localRepository,
  });

  Future<Either<DatabaseFailure, List<Subscription>>> call() async {
    final localExists = await localRepository.subscriptionsExists();
    if (!localExists) {
      final result = await remoteRepository.getSubscriptionList();
      result.fold(
        (failure) {
          return left(failure);
        },
        (subscriptions) async {
          await localRepository.saveSubscriptions(subscriptions: subscriptions);
        },
      );
    }
    final subscriptions = await localRepository.getSubscriptions();
    return right(subscriptions);
  }
}
