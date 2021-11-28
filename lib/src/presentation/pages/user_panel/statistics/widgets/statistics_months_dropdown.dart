import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../features/statistics/application/statistics_providers.dart';
import '../../../../helpers/date_formatters.dart';
import '../logic/statistics_page_providers.dart';

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
