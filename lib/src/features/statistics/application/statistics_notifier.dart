import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/in_app_purchase/application/fetch_state.dart';
import 'package:prospector/src/features/statistics/domain/statistic_entity.dart';

import 'package:prospector/src/features/statistics/domain/statistics_use_cases.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class StatisticsNotifier extends ChangeNotifier {
  final StatisticsUseCases statisticsUseCases;
  final Reader read;
  StatisticsNotifier({
    required this.statisticsUseCases,
    required this.read,
  });

  FetchState _statisticsState = const FetchState.initial();
  List<Statistic> _statistics = [];

  FetchState get statisticsState => _statisticsState;
  List<Statistic> get statistics => _statistics;

  void reset() => _statisticsState = const FetchState.initial();

  Future<void> getStatistics() async {
    if (_statisticsState.isInitial) {
      _statisticsState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await statisticsUseCases.getStatisticsList(uid: uid);
        getResult.fold(
          (failure) => _statisticsState = const FetchState.error(),
          (statisticsList) {
            statisticsList.sort((a, b) =>
                a.created.compareTo(b.created)); // TODO check if needed
            _statistics = statisticsList;
            _statisticsState = const FetchState.ready();
          },
        );
      } else {
        _statisticsState = const FetchState.error();
      }
      notifyListeners();
    }
  }

  // * Getters and filters
  List<DateTime> get statisticsMonthsList {
    final List<DateTime> monthsList = [];
    for (final Statistic statistic in statistics) {
      final DateTime created = statistic.created;
      final DateTime statisticMonth = DateTime(created.year, created.month);
      if (!monthsList.contains(statisticMonth)) {
        monthsList.add(statisticMonth);
      }
    }
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    if (!monthsList.contains(currentMonth)) {
      monthsList.add(currentMonth);
    }
    monthsList.sort();
    return monthsList;
  }

  DateTime get statisticsFirstMonth => statisticsMonthsList.isNotEmpty
      ? statisticsMonthsList.first
      : DateTime(DateTime.now().year, DateTime.now().month);
}
