import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/statistics_months_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/statistics_range_dropdown.dart';

class MonthRangeDropdownSelector extends ConsumerWidget {
  const MonthRangeDropdownSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool historic = watch(historicProvider).state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: historic
          ? const StatisticsRangeDropdown()
          : const StatisticsMonthsDropdown(),
    );
  }
}
