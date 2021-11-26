import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_notifier.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/statistics/domain/chart_data_entity.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/effectiveness_status_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/widgets/statistics_range_dropdown.dart';

class EffectivenessChartCard extends ConsumerWidget {
  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;
  final Duration animationDuration;
  const EffectivenessChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AppDefaultDataNotifier defaultData = watch(appDefaultDataProvider);
    final Map<String, dynamic> effectivenessData = watch(effectinesChartsData);
    final StatisticsRange selectedRange = watch(selectedRangeProvider).state;
    final String selectedStatus =
        watch(effectivenessSelectedStatusProvider).state;
    final List<String> forwardStatus = watch(forwardStatusProvider);

    final gaugeSize = (MediaQuery.of(context).size.width - 30) / 3;

    final defaultRenderer = charts.ArcRendererConfig<Object>(
        arcRatio: 0.4,
        startAngle: 4 / 5 * pi,
        arcLength: 7 / 5 * pi,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.auto)
        ]);
    final layoutConfig = charts.LayoutConfig(
        bottomMarginSpec: charts.MarginSpec.defaultSpec,
        leftMarginSpec: charts.MarginSpec.fixedPixel(15),
        rightMarginSpec: charts.MarginSpec.fixedPixel(15),
        topMarginSpec: charts.MarginSpec.fixedPixel(15));
    const verticalDivider = VerticalDivider(
      thickness: 1.0,
      width: 0.0,
      indent: 10.0,
      endIndent: 5.0,
    );

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
                      AppLocalizations.of(context).effectiveness,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () {
                    showEffectivenessChartDescriptionDialog(context);
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: StatisticsRangeDropdown(),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: EffectivenessStatusDropdown(),
            ),
            const SizedBox(height: 15.0),
            Text(
              AppLocalizations.of(context).outOf,
            ),
            Text(
              "${effectivenessData['status_actions']}",
              style: const TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '${effectivenessData['status_actions'] == 1 ? AppLocalizations.of(context).prospectAdded : AppLocalizations.of(context).prospectsAdded} ',
                    ),
                    TextSpan(
                      text: selectedRange.isThisMonth ||
                              selectedRange.isThisYear ||
                              selectedRange.isLifetime
                          ? ''
                          : '${AppLocalizations.of(context).inThe} ',
                    ),
                    TextSpan(
                        text: selectedRange.text.toLowerCase(),
                        // '${selectedRange.isThisMonth || selectedRange.isThisYear || selectedRange.isLifetime ? selectedRange.text : selectedRange.months} ${AppLocalizations.of(context).months} ',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' ${AppLocalizations.of(context).to} '),
                    TextSpan(
                        text:
                            context.read(appDefaultDataProvider).getStatusText(
                                  statusID: selectedStatus,
                                  isPlural: true,
                                ),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: gaugeSize,
                        width: gaugeSize,
                        child: charts.PieChart<Object>(
                          effectivenessData['forward_data']
                              as List<charts.Series<ChartData, Object>>,
                          animate: true,
                          animationDuration: animationDuration,
                          defaultRenderer: defaultRenderer,
                          layoutConfig: layoutConfig,
                        ),
                      ),
                      Text(
                        effectivenessData['forward_percentage'] != null
                            ? ' ${effectivenessData['forward_percentage'].round()} %'
                            : '-',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: gaugeSize,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).wereMovedTo} ',
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                                TextSpan(
                                  text: defaultData.getStatusText(
                                      statusID: forwardStatus.first,
                                      isPlural: true),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: forwardStatus.length > 1
                                          ? Colors.green
                                          : null),
                                ),
                                if (forwardStatus.length > 1) ...[
                                  TextSpan(
                                    text:
                                        ' ${AppLocalizations.of(context).or} ',
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context).clients,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lime),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalDivider,
                  Column(
                    children: [
                      SizedBox(
                        height: gaugeSize,
                        width: gaugeSize,
                        child: charts.PieChart(
                          effectivenessData['stay_data']
                              as List<charts.Series<ChartData, String>>,
                          animate: true,
                          animationDuration: animationDuration,
                          defaultRenderer: defaultRenderer,
                          layoutConfig: layoutConfig,
                        ),
                      ),
                      Text(
                        effectivenessData['stay_percentage'] != null
                            ? ' ${effectivenessData['stay_percentage'].round()} %'
                            : '-',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: gaugeSize,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).areStillIn} ',
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                                TextSpan(
                                  text: defaultData.getStatusText(
                                      statusID: selectedStatus, isPlural: true),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalDivider,
                  Column(
                    children: [
                      SizedBox(
                        height: gaugeSize,
                        width: gaugeSize,
                        child: charts.PieChart(
                          effectivenessData['turn_down_data']
                              as List<charts.Series<ChartData, String>>,
                          animate: true,
                          animationDuration: animationDuration,
                          defaultRenderer: defaultRenderer,
                          layoutConfig: layoutConfig,
                        ),
                      ),
                      Text(
                        effectivenessData['turn_down_percentage'] != null
                            ? ' ${effectivenessData['turn_down_percentage'].round()} %'
                            : '-',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: gaugeSize,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).wereMovedTo} ',
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)
                                      .notInterestedP,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (effectivenessData['delete_actions'] != 0) ...[
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.delete, size: 18.0),
                  Text(
                    effectivenessData['delete_actions'] == 1
                        ? ' ${effectivenessData['delete_actions']} ${AppLocalizations.of(context).deleted}'
                        : ' ${effectivenessData['delete_actions']} ${AppLocalizations.of(context).deletedP}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
            const SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
