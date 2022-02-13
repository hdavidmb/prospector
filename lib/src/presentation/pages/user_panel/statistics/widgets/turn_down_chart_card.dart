import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../core/dialogs.dart';
import '../logic/statistics_page_providers.dart';
import 'statistics_range_dropdown.dart';

class TurnDownChartCard extends ConsumerWidget {
  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;
  final Duration animationDuration;
  const TurnDownChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                  AppLocalizations.of(context).turnDownAnalysis,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ))),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () {
                    showNoAnalysisChartDescriptionDialog(context);
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: StatisticsRangeDropdown(),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                AppLocalizations.of(context).wichListCome,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: charts.BarChart(
                watch(turnDownAnalysisChartData),
                animate: true,
                animationDuration: animationDuration,
                barGroupingType: charts.BarGroupingType.groupedStacked,
                barRendererDecorator: charts.BarLabelDecorator(
                    labelPosition: charts.BarLabelPosition.inside,
                    labelAnchor: charts.BarLabelAnchor.middle,
                    insideLabelStyleSpec: charts.TextStyleSpec(
                        fontSize: 10,
                        color: charts.ColorUtil.fromDartColor(Colors.white))),
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
                behaviors: [
                  charts.ChartTitle(
                    AppLocalizations.of(context).totalTurnDowns,
                    titleStyleSpec: charts.TextStyleSpec(
                        color: isDarkMode
                            ? charts.MaterialPalette.white
                            : charts.MaterialPalette.black),
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        charts.OutsideJustification.middle,
                    outerPadding: -30,
                  ),
                  charts.ChartTitle(
                    AppLocalizations.of(context).cameFrom,
                    titleStyleSpec: charts.TextStyleSpec(
                        color: isDarkMode
                            ? charts.MaterialPalette.white
                            : charts.MaterialPalette.black),
                    behaviorPosition: charts.BehaviorPosition.end,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea,
                    outerPadding: -30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
