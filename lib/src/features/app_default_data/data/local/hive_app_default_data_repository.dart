import 'package:hive/hive.dart';

import '../../domain/interface/i_app_default_data_local_repository.dart';

class HiveDefaultDataRepository implements IAppDefaultDataLocalRepository {
  final String _statusesBoxName = 'statuses-map';
  final String _subscriptionsBoxName = 'subscriptions-map';

  @override
  Future<bool> statusesExists() => Hive.boxExists(_statusesBoxName);

  @override
  Future<bool> subscriptionsExists() => Hive.boxExists(_subscriptionsBoxName);

  @override
  Future<List<Map<String, dynamic>>> getStatuses() async {
    final Box<Map<dynamic, dynamic>> statusesBox =
        await _checkOpenBox(boxName: _statusesBoxName);
    final List<Map<dynamic, dynamic>> statusesList =
        statusesBox.values.toList();
    return statusesList
        .map((status) => Map<String, dynamic>.from(status))
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getSubscriptions() async {
    final Box<Map<dynamic, dynamic>> subscriptionsBox =
        await _checkOpenBox(boxName: _subscriptionsBoxName);
    final List<Map<dynamic, dynamic>> subscriptionsList =
        subscriptionsBox.values.toList();
    return subscriptionsList
        .map((subscription) => Map<String, dynamic>.from(subscription))
        .toList();
  }

  @override
  Future<void> saveStatuses(
      {required List<Map<String, dynamic>> statuses}) async {
    final Box<Map<dynamic, dynamic>> statusesBox =
        await _checkOpenBox(boxName: _statusesBoxName);
    statusesBox.addAll(statuses);
  }

  @override
  Future<void> saveSubscriptions(
      {required List<Map<String, dynamic>> subscriptions}) async {
    final Box<Map<dynamic, dynamic>> subscriptionsBox =
        await _checkOpenBox(boxName: _subscriptionsBoxName);
    subscriptionsBox.addAll(subscriptions);
  }

  Future<Box<Map<dynamic, dynamic>>> _checkOpenBox(
      {required String boxName}) async {
    if (!Hive.isBoxOpen(boxName)) {
      return Hive.openBox<Map<dynamic, dynamic>>(boxName);
    } else {
      return Hive.box<Map<dynamic, dynamic>>(boxName);
    }
  }
}
