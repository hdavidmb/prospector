import 'package:hive/hive.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/interface/i_app_default_data_local_repository.dart';

class HiveDefaultDataRepository implements IAppDefaultDataLocalRepository {

  final String _statusesBoxName = 'statuses';
  final String _subscriptionsBoxName = 'subscriptions';

  @override
  Future<bool> statusesExists() async {
    final bool exists = await Hive.boxExists(_statusesBoxName);
    await Hive.openBox<Status>(_statusesBoxName);
    return exists;
  }

  @override
  Future<bool> subscriptionsExists() async {
    final bool exists = await Hive.boxExists(_subscriptionsBoxName);
    await Hive.openBox<Subscription>(_subscriptionsBoxName);
    return exists;
  }

  @override
  List<Status> getStatuses() => Hive.box<Status>(_statusesBoxName).values.toList();

  @override
  List<Subscription> getSubscriptions() => Hive.box<Subscription>(_subscriptionsBoxName).values.toList();

  @override
  void saveStatuses({required List<Status> statuses}) => Hive.box<Status>(_statusesBoxName).addAll(statuses);

  @override
  void saveSubscriptions({required List<Subscription> subscriptions}) => Hive.box<Subscription>(_subscriptionsBoxName).addAll(subscriptions);

}