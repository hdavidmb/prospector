import 'package:flutter/foundation.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/use_cases/get_statuses.dart';
import 'package:prospector/src/features/app_default_data/domain/use_cases/get_subscriptions.dart';

class AppDefaultDataNotifier extends ChangeNotifier {
  final GetStatuses getStatuses;
  final GetSubscriptions getSubscriptions;
  AppDefaultDataNotifier({
    required this.getStatuses,
    required this.getSubscriptions,
  });

  bool _defaultDataReady = false;
  late List<Status> _statuses;
  late List<Subscription> _subscriptions;

  List<Status> get statuses => _statuses;
  List<Subscription> get subscriptions => _subscriptions;
  bool get defaultDataReady => _defaultDataReady;

  Future<void> getDefaultData() async {
    bool statusesReady = false;
    bool subscriptionsReady = false;

    final statusesResult = await getStatuses();
    statusesResult.fold(
      (_) {}, //TODO show error
      (statuses) {
        _statuses = statuses;
        statusesReady = true;
      },
    );

    final subscriptionsResult = await getSubscriptions();
    subscriptionsResult.fold(
      (_) {}, //TODO show error
      (subscriptions) {
        _subscriptions = subscriptions;
        subscriptionsReady = true;
      },
    );

    _defaultDataReady = statusesReady && subscriptionsReady;
    notifyListeners();
  }
}
