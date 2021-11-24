import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/statistics/application/statistics_providers.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';

class StatisticsMonthsDropdown extends ConsumerWidget {
  const StatisticsMonthsDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List<int> statisticsMonthsMillisList =
        watch(statisticsNotifierProvider).statisticsMonthsMillisList;
    final int selectedMonthMillis = watch(selectedMonthMillisProvider).state;

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
          isDense: false,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0)),
      value: selectedMonthMillis,
      items: statisticsMonthsMillisList
          .map((monthMillis) => DropdownMenuItem<int>(
              value: monthMillis,
              child: Text(localizedMonthYear(
                  DateTime.fromMillisecondsSinceEpoch(monthMillis)))))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          context.read(selectedMonthMillisProvider).state = value;
        }
      },
    );
  }
}
