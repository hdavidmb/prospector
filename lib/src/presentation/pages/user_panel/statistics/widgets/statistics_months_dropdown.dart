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
    final List<DateTime> statisticsMonthsList =
        watch(statisticsNotifierProvider).statisticsMonthsList;
    final DateTime selectedMonth = watch(selectedMonthProvider).state;

    return DropdownButtonFormField<DateTime>(
      value: selectedMonth,
      items: statisticsMonthsList
          .map((month) => DropdownMenuItem<DateTime>(
              value: month, child: Text(localizedMonthYear(month))))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          context.read(selectedMonthProvider).state = value;
        }
      },
    );
  }
}
