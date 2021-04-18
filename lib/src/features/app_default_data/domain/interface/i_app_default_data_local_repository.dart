import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';

abstract class IAppDefaultDataLocalRepository {
  Future<bool> statusesExists();
  Future<bool> subscriptionsExists();

  List<Status> getStatuses();
  List<Subscription> getSubscriptions();

  void saveStatuses({required List<Status> statuses});
  void saveSubscriptions({required List<Subscription> subscriptions});

}