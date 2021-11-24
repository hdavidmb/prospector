import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/contacts/application/contacts_notifier.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/statistics/domain/chart_data_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/statistics/logic/statistics_page_providers.dart';

class ProspectsPerListChartCard extends ConsumerWidget {
  final double cardElevation;
  final EdgeInsets cardMargins;
  final RoundedRectangleBorder cardShape;
  final Duration animationDuration;

  const ProspectsPerListChartCard({
    Key? key,
    required this.cardElevation,
    required this.cardMargins,
    required this.cardShape,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool includeNotInterested = watch(includeNotInterestedProvider).state;
    final bool contactsEmpty = watch(contactsNotifierProvider).contacts.isEmpty;
    final ContactsNotifier contactsProvider = watch(contactsNotifierProvider);

    final List<ChartData> chartData =
        watch(prospectsPerMonthDataProvider).state;

    return Card(
      elevation: cardElevation,
      margin: cardMargins,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).prospectsPerList,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () {
                    // TODO: chartsService
                    //     .showProspectsChartDescription(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context).includeNotInterested,
                  textAlign: TextAlign.end,
                ),
                Switch.adaptive(
                  value: includeNotInterested,
                  onChanged: (value) {
                    context.read(includeNotInterestedProvider).state = value;
                  },
                ),
              ],
            ),
            if (contactsEmpty)
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                height: 210.0,
                child: Center(
                  child: Text(AppLocalizations.of(context).youHaveNoProspects),
                ),
              ),
            if (!contactsEmpty)
              SizedBox(
                height: 230.0,
                child: charts.PieChart<Object>(
                  [
                    charts.Series(
                      data: chartData,
                      domainFn: (data, _) => (data as ChartData).label,
                      measureFn: (data, _) => (data as ChartData).value,
                      colorFn: (data, _) => charts.ColorUtil.fromDartColor(
                          (data as ChartData).color),
                      labelAccessorFn: (data, _) => '${data.value}',
                      id: 'prospects_per_list',
                    ),
                  ],
                  animate: true,
                  animationDuration: animationDuration,
                  defaultRenderer: charts.ArcRendererConfig<Object>(
                    arcRatio: 0.5,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside,
                      )
                    ],
                  ),
                  behaviors: [
                    charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 6,
                      cellPadding:
                          const EdgeInsets.only(right: 4.0, bottom: 4.0),
                    )
                  ],
                ),
              ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(children: [
                    Text(
                      '${contactsProvider.contacts.length}',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                    Text(AppLocalizations.of(context).total)
                  ]),
                  if (!includeNotInterested) ...[
                    const VerticalDivider(
                      width: 0.0,
                      thickness: 1.0,
                      endIndent: 5.0,
                      indent: 5.0,
                    ),
                    Column(children: [
                      Text(
                        '${contactsProvider.notInterestedContacts.length}',
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                      Text(
                        AppLocalizations.of(context).notInterestedP,
                      )
                    ]),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
