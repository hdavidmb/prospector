import '../entities/status_entity.dart';
import '../entities/subscription_entity.dart';

abstract class IAppDefaultDataLocalRepository {
  Future<bool> statusesExists();
  Future<bool> subscriptionsExists();

  Future<List<Status>> getStatuses();
  Future<List<Subscription>> getSubscriptions();

  Future<void> saveStatuses({required List<Status> statuses});
  Future<void> saveSubscriptions({required List<Subscription> subscriptions});

}