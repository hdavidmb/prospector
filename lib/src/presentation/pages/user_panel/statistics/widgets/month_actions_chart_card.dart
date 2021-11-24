import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/statistics/application/statistics_notifier.dart';
import 'package:prospector/src/features/statistics/application/statistics_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_notifier.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/month_range_dropdown_selector.dart';

class MonthActionsChartCard extends ConsumerWidget {
  const MonthActionsChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
  }) : super(key: key);

  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Card(
      elevation: cardElevation,
      margin: cardMargins,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                        child: Text(
                  AppLocalizations.of(context).monthActions,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ))),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () {
                    //TODO: chartsService.showActionsChartDescription(context);
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const MonthRangeDropdownSelector(),
          ],
        ),
      ),
    );
  }
}
