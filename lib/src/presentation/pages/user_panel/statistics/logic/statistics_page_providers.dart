import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_notifier.dart';

final includeNotInterestedProvider = StateProvider<bool>((ref) {
  return false;
});

final historicProvider = StateProvider<bool>((ref) {
  return false;
});

final selectedMonthProvider = StateProvider<DateTime>((ref) {
  return DateTime(DateTime.now().year, DateTime.now().month);
});

final selectedRangeProvider = StateProvider<StatisticsRange>((ref) {
  return StatisticsRange.thisMonth;
});

final statisticsPageNotifierProvider =
    ChangeNotifierProvider<StatisticsPageNotifier>((ref) {
  return StatisticsPageNotifier();
});
