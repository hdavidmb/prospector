import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_notifier.dart';

final statisticsPageNotifierProvider =
    ChangeNotifierProvider<StatisticsPageNotifier>((ref) {
  return StatisticsPageNotifier();
});
