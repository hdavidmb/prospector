import 'package:dartz/dartz.dart';

import '../../../../core/database/database_failures/database_failure.dart';
import '../entities/subscription_entity.dart';
import '../interface/i_app_default_data_local_repository.dart';
import '../interface/i_app_default_data_repository.dart';

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
      return result.fold(
        (failure) {
          return left(failure);
        },
        (subscriptions) {
          localRepository.saveSubscriptions(subscriptions: subscriptions);
          return right(subscriptions);
        },
      );
    }
    final subscriptions = await localRepository.getSubscriptions();
    return right(subscriptions);
  }
}
