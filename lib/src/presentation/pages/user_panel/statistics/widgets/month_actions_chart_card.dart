import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/statistics_months_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/statistics_range_dropdown.dart';

class MonthActionsChartCard extends ConsumerWidget {
  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;
  final Duration animationDuration;

  const MonthActionsChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool historic = watch(historicProvider).state;
    final bool extraActions = watch(extraActionsProvider).state;

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
                    //TODO: showActionsChartDescription(context);
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: historic
                  ? const StatisticsRangeDropdown()
                  : const StatisticsMonthsDropdown(),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context).historic),
                        Switch.adaptive(
                          value: historic,
                          onChanged: (value) {
                            final selectedRange =
                                context.read(selectedRangeProvider).state;
                            context.read(historicProvider).state = value;

                            if (value && selectedRange.isThisMonth) {
                              context.read(selectedRangeProvider).state =
                                  StatisticsRange.threeMonths;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context).extraActions),
                        Switch.adaptive(
                          value: extraActions,
                          onChanged: (value) {
                            context.read(selectedDatumProvider).state = [];
                            context.read(extraActionsProvider).state = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (historic) ...[
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: extraActions ? 204.0 : 228.0,
                child: charts.TimeSeriesChart(
                  watch(historicActionsPerMonthProvider),
                  animate: true,
                  animationDuration: animationDuration,
                  selectionModels: [
                    charts.SelectionModelConfig(
                      type: charts.SelectionModelType.info,
                      changedListener: (value) => context
                          .read(selectedDatumProvider)
                          .state = value.selectedDatum,
                    )
                  ],
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: isDarkMode
                            ? charts.MaterialPalette.white
                            : charts.MaterialPalette.black,
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: false,
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: isDarkMode
                            ? charts.MaterialPalette.white
                            : charts.MaterialPalette.black,
                      ),
                      lineStyle: charts.LineStyleSpec(
                          color: charts.MaterialPalette.gray.shade300),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10.0,
                    children: watch(historicActionsLeyendsProvider)),
              )
            ],
            if (!historic)
              SizedBox(
                height: 300.0,
                child: charts.BarChart(
                  watch(actionsPerMonth),
                  animate: true,
                  animationDuration: animationDuration,
                  vertical: false,
                  barRendererDecorator: charts.BarLabelDecorator(),
                  domainAxis: const charts.OrdinalAxisSpec(
                      renderSpec: charts.NoneRenderSpec()),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: false,
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: isDarkMode
                            ? charts.MaterialPalette.white
                            : charts.MaterialPalette.black,
                      ),
                      lineStyle: charts.LineStyleSpec(
                          color: charts.MaterialPalette.gray.shade300),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
