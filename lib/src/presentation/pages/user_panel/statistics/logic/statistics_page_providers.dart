import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_notifier.dart';

final includeNotInterestedProvider = StateProvider<bool>((ref) {
  return false;
});

final historicProvider = StateProvider<bool>((ref) {
  return false;
});

final selectedMonthMillisProvider = StateProvider<int>((ref) {
  return DateTime(DateTime.now().year, DateTime.now().month)
      .millisecondsSinceEpoch;
});

final statisticsPageNotifierProvider =
    ChangeNotifierProvider<StatisticsPageNotifier>((ref) {
  return StatisticsPageNotifier();
});
