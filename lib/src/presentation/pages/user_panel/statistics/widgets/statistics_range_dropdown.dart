import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';

class StatisticsRangeDropdown extends ConsumerWidget {
  const StatisticsRangeDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final StatisticsRange selectedRange = watch(selectedRangeProvider).state;

    return DropdownButtonFormField<StatisticsRange>(
      value: selectedRange,
      items: StatisticsRange.values
          .map((range) => DropdownMenuItem<StatisticsRange>(
              value: range, child: Text(range.text)))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          context.read(selectedRangeProvider).state = value;
        }
      },
    );
  }
}
