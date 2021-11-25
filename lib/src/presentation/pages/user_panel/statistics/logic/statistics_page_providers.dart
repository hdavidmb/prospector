import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_notifier.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_providers.dart';
import 'package:prospector/src/features/contacts/application/contacts_notifier.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/statistics/application/statistics_providers.dart';
import 'package:prospector/src/features/statistics/domain/chart_data_entity.dart';
import 'package:prospector/src/features/statistics/domain/statistic_entity.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';
import 'package:prospector/src/presentation/helpers/date_formatters.dart';

final includeNotInterestedProvider = StateProvider<bool>((ref) => false);

final historicProvider = StateProvider<bool>((ref) => false);

final extraActionsProvider = StateProvider<bool>((ref) => false);

final selectedMonthProvider = StateProvider<DateTime>(
    (ref) => DateTime(DateTime.now().year, DateTime.now().month));

final selectedRangeProvider =
    StateProvider<StatisticsRange>((ref) => StatisticsRange.thisMonth);

final selectedDatumProvider =
    StateProvider<List<charts.SeriesDatum<DateTime>>>((ref) => []);

final prospectsPerMonthDataProvider = StateProvider<List<ChartData>>((ref) {
  final ContactsNotifier _contactsProvider =
      ref.watch(contactsNotifierProvider);
  final bool _includeNotInterested =
      ref.watch(includeNotInterestedProvider).state;

  final List<ChartData> _chartData = [
    ChartData(
      label: AppLocalizations.current.executives,
      value: _contactsProvider.executiveContacts.length,
      color: Colors.teal,
    ),
    ChartData(
      label: AppLocalizations.current.clients,
      value: _contactsProvider.clientContacts.length,
      color: Colors.lime,
    ),
    ChartData(
      label: AppLocalizations.current.followUp,
      value: _contactsProvider.followUpContacts.length,
      color: Colors.indigo,
    ),
    ChartData(
      label: AppLocalizations.current.invitedP,
      value: _contactsProvider.invitedContacts.length,
      color: Colors.blue,
    ),
    ChartData(
      label: AppLocalizations.current.notContactedP,
      value: _contactsProvider.notContactedContacts.length,
      color: Colors.amber,
    ),
    if (_includeNotInterested)
      ChartData(
        label: AppLocalizations.current.notInterestedP,
        value: _contactsProvider.notInterestedContacts.length,
        color: Colors.red,
      ),
  ];
  return _chartData;
});

final historicActionsPerMonthProvider =
    Provider<List<charts.Series<ChartData, DateTime>>>((ref) {
  final bool _extraActions = ref.watch(extraActionsProvider).state;
  final AppDefaultDataNotifier defaultData = ref.watch(appDefaultDataProvider);

  final List<ChartData> addsLists = [];
  final List<ChartData> inviteLists = [];
  final List<ChartData> presentLists = [];
  final List<ChartData> clientLists = [];
  final List<ChartData> executiveLists = [];
  final List<ChartData> reactivateLists = [];
  final List<ChartData> upgradeLists = [];
  final List<ChartData> downgradeLists = [];
  final List<ChartData> turnDownLists = [];
  final List<ChartData> deleteLists = [];

  final int _months = ref.watch(selectedRangeProvider).state.months ??
      differenceInMonths(DateTime.now(),
          ref.read(statisticsNotifierProvider).statisticsFirstMonth);

  final DateTime _now = DateTime.now();
  final DateTime _rangeStartMonth =
      DateTime(_now.year, _now.month - (_months - 1));

  for (int i = 0; i < _months; i++) {
    final DateTime _iterationMonth =
        DateTime(_rangeStartMonth.year, _rangeStartMonth.month + i);

    int addsMonth = 0;
    int inviteMonth = 0;
    int presentMonth = 0;
    int clientMonth = 0;
    int executiveMonth = 0;
    int reactivateMonth = 0;
    int upgradeMonth = 0;
    int downgradeMonth = 0;
    int turnDownMonth = 0;
    int deleteMonth = 0;

    final _monthStatistics = ref
        .watch(statisticsNotifierProvider)
        .statistics
        .where((statistic) => isSameMonth(_iterationMonth, statistic.created))
        .toList();

    for (final Statistic statistic in _monthStatistics) {
      if (statistic.oldStatus == null) {
        addsMonth++;
      } else if (statistic.newStatus == null) {
        deleteMonth++;
      } else if (statistic.newStatus == defaultData.notInterestedID) {
        turnDownMonth++;
      } else if (statistic.oldStatus == defaultData.notInterestedID) {
        reactivateMonth++;
      } else if (statistic.oldStatus == defaultData.notContactedID) {
        inviteMonth++;
      } else if (statistic.oldStatus == defaultData.invitedID) {
        presentMonth++;
      } else if (statistic.oldStatus == defaultData.followUpID) {
        if (statistic.newStatus == defaultData.clientID) {
          clientMonth++;
        } else if (statistic.newStatus == defaultData.executiveID) {
          executiveMonth++;
        }
      } else if (statistic.oldStatus == defaultData.clientID) {
        upgradeMonth++;
      } else if (statistic.oldStatus == defaultData.executiveID) {
        downgradeMonth++;
      }
    }

    addsLists.add(ChartData(
        label: _iterationMonth, value: addsMonth, color: Colors.amber));
    inviteLists.add(ChartData(
        label: _iterationMonth, value: inviteMonth, color: Colors.blue));
    presentLists.add(ChartData(
        label: _iterationMonth, value: presentMonth, color: Colors.indigo));
    clientLists.add(ChartData(
        label: _iterationMonth, value: clientMonth, color: Colors.lime));
    executiveLists.add(ChartData(
        label: _iterationMonth, value: executiveMonth, color: Colors.teal));
    reactivateLists.add(ChartData(
        label: _iterationMonth,
        value: reactivateMonth,
        color: Colors.amberAccent));
    upgradeLists.add(ChartData(
        label: _iterationMonth,
        value: upgradeMonth,
        color: Colors.lightBlueAccent));
    downgradeLists.add(ChartData(
        label: _iterationMonth,
        value: downgradeMonth,
        color: Colors.deepPurple[200]!));
    turnDownLists.add(ChartData(
        label: _iterationMonth, value: turnDownMonth, color: Colors.red));
    deleteLists.add(ChartData(
        label: _iterationMonth, value: deleteMonth, color: Colors.brown));
  }

  final Map<String, List<ChartData>> dataMap = {
    AppLocalizations.current.addProspect: addsLists,
    AppLocalizations.current.invite: inviteLists,
    AppLocalizations.current.present: presentLists,
    AppLocalizations.current.newClient: clientLists,
    AppLocalizations.current.newExecutive: executiveLists,
  };

  if (_extraActions) {
    dataMap[AppLocalizations.current.reactivate] = reactivateLists;
    dataMap[AppLocalizations.current.clientToExecutive] = upgradeLists;
    dataMap[AppLocalizations.current.executiveToClient] = downgradeLists;
    dataMap[AppLocalizations.current.turnDown] = turnDownLists;
    dataMap[AppLocalizations.current.delete] = deleteLists;
  }

  final List<charts.Series<ChartData, DateTime>> chartSeries = dataMap
      .map((key, value) => MapEntry(
          key,
          charts.Series<ChartData, DateTime>(
            id: key,
            colorFn: (data, __) => charts.ColorUtil.fromDartColor(data.color),
            domainFn: (data, _) => data.label as DateTime,
            measureFn: (data, _) => data.value,
            data: value,
          )))
      .values
      .toList();

  return chartSeries;
});

final historicActionsLeyendsProvider = Provider<List<Widget>>((ref) {
  final List<charts.SeriesDatum<DateTime>> selectedDatum =
      ref.watch(selectedDatumProvider).state;

  final List<ChartData> chartDataList = selectedDatum.isNotEmpty
      ? selectedDatum.map((charts.SeriesDatum data) {
          return (data.datum as ChartData)
              .copyWith(label: data.series.displayName);
        }).toList()
      : ref
          .watch(historicActionsPerMonthProvider)
          .map((series) => series.data.first.copyWith(label: series.id))
          .toList();
  chartDataList
      .sort((a, b) => (a.label as String).compareTo(b.label as String));
  final List<Widget> leyends = chartDataList
      .map(
        (chartData) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.remove, color: chartData.color),
            Text(chartData.label as String),
            if (selectedDatum.isNotEmpty && chartData.value != 0)
              Text(': ${chartData.value}')
          ],
        ),
      )
      .toList();
  return leyends;
});
