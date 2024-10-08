import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/contacts/application/contacts_notifier.dart';
import '../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../features/statistics/domain/chart_data_entity.dart';
import '../../../../core/dialogs.dart';
import '../logic/statistics_page_providers.dart';

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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                    showProspectsChartDescriptionDialog(context);
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
                    color: isDarkMode ? Colors.white10 : Colors.grey[200],
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
                    charts.Series<ChartData, Object>(
                      data: chartData,
                      domainFn: (data, _) => data.label as String,
                      measureFn: (data, _) => data.value,
                      colorFn: (data, _) =>
                          charts.ColorUtil.fromDartColor(data.color),
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
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${contactsProvider.contacts.length}',
                          style: const TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(AppLocalizations.of(context).total)
                      ],
                    ),
                  ),
                  if (!includeNotInterested) ...[
                    const VerticalDivider(
                      width: 0.0,
                      thickness: 1.0,
                      endIndent: 5.0,
                      indent: 5.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${contactsProvider.notInterestedContacts.length}',
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).notInterestedP,
                          )
                        ],
                      ),
                    ),
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
