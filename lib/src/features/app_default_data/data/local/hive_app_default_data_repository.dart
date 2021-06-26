import 'package:hive/hive.dart';

import '../../domain/entities/status_entity.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/interface/i_app_default_data_local_repository.dart';

class HiveDefaultDataRepository implements IAppDefaultDataLocalRepository {

  final String _statusesBoxName = 'statuses';
  final String _subscriptionsBoxName = 'subscriptions';

  @override
  Future<bool> statusesExists() => Hive.boxExists(_statusesBoxName);

  @override
  Future<bool> subscriptionsExists() => Hive.boxExists(_subscriptionsBoxName);

  @override
  Future<List<Status>> getStatuses() async {
    if (!Hive.isBoxOpen(_statusesBoxName)) await Hive.openBox<Status>(_statusesBoxName);
    return Hive.box<Status>(_statusesBoxName).values.toList();
  }

  @override
  Future<List<Subscription>> getSubscriptions() async {
    if (!Hive.isBoxOpen(_subscriptionsBoxName)) await Hive.openBox<Subscription>(_subscriptionsBoxName);
    return Hive.box<Subscription>(_subscriptionsBoxName).values.toList();
  }

  @override
  Future<void> saveStatuses({required List<Status> statuses}) async {
    if (!Hive.isBoxOpen(_statusesBoxName)) await Hive.openBox<Status>(_statusesBoxName);
    Hive.box<Status>(_statusesBoxName).addAll(statuses);
  }

  @override
  Future<void> saveSubscriptions({required List<Subscription> subscriptions}) async {
    if (!Hive.isBoxOpen(_subscriptionsBoxName)) await Hive.openBox<Subscription>(_subscriptionsBoxName);
    Hive.box<Subscription>(_subscriptionsBoxName).addAll(subscriptions);
  }

}