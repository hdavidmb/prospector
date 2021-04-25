import 'package:flutter/foundation.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';
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

  AppDefaultDataState _defaultDataState = const AppDefaultDataState.initial();
  late List<Status> _statuses;
  late List<Subscription> _subscriptions;

  List<Status> get statuses => _statuses;
  List<Subscription> get subscriptions => _subscriptions;
  AppDefaultDataState get defaultDataState => _defaultDataState;

  String get premiumSubID => _subscriptions.firstWhere((sub) => sub.key == 'premium').id; //TODO test
  String get freeSubID => _subscriptions.firstWhere((sub) => sub.key == 'free').id;

  Future<void> getDefaultData() async {
    bool statusesReady = false;
    bool subscriptionsReady = false;

    final statusesResult = await getStatuses();
    statusesResult.fold(
      (_) => _defaultDataState = const AppDefaultDataState.error(),
      (statuses) {
        _statuses = statuses;
        statusesReady = true;
      },
    );

    final subscriptionsResult = await getSubscriptions();
    subscriptionsResult.fold(
      (_) => _defaultDataState = const AppDefaultDataState.error(),
      (subscriptions) {
        _subscriptions = subscriptions;
        subscriptionsReady = true;
      },
    );

    if (statusesReady && subscriptionsReady) _defaultDataState = const AppDefaultDataState.ready();
    notifyListeners();
  }
}
