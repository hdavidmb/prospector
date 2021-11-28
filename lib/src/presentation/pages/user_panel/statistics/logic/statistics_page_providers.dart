import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../features/app_default_data/application/app_default_data_notifier.dart';
import '../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../features/contacts/application/contacts_notifier.dart';
import '../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../features/statistics/application/statistics_providers.dart';
import '../../../../../features/statistics/domain/chart_data_entity.dart';
import '../../../../../features/statistics/domain/statistic_entity.dart';
import '../../../../../features/statistics/domain/statistics_range_entity.dart';
import '../../../../helpers/date_formatters.dart';
import '../../../../theme/theme_notifier.dart';
import '../../../../theme/theme_providers.dart';

final includeNotInterestedProvider = StateProvider<bool>((ref) => false);

final historicProvider = StateProvider<bool>((ref) => false);

final extraActionsProvider = StateProvider<bool>((ref) => false);

final selectedMonthProvider = StateProvider<DateTime>(
    (ref) => DateTime(DateTime.now().year, DateTime.now().month));

final selectedRangeProvider =
    StateProvider<StatisticsRange>((ref) => StatisticsRange.thisMonth);

final selectedDatumProvider =
    StateProvider<List<charts.SeriesDatum<DateTime>>>((ref) => []);

final effectivenessSelectedStatusProvider = StateProvider<String>((ref) {
  final notContactedID = ref.watch(appDefaultDataProvider).notContactedID;
  return notContactedID;
});

final rangeStartMonthProvider = Provider<DateTime>((ref) {
  final int _months = ref.watch(selectedRangeProvider).state.months ??
      differenceInMonths(DateTime.now(),
          ref.read(statisticsNotifierProvider).statisticsFirstMonth);

  final DateTime _now = DateTime.now();
  final DateTime _rangeStartMonth =
      DateTime(_now.year, _now.month - (_months - 1));
  return _rangeStartMonth;
});

// * PROSPECTS PER LIST
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

//TODO: try to generally optimize actionsPerMonth providers
// * ACTIONS PER MONTH
final actionsPerMonth = Provider<List<charts.Series<ChartData, String>>>((ref) {
  final ThemeNotifier theme = ref.watch(themeNotifierProvider);

  final bool isDarkMode = theme.currentThemeMode == ThemeMode.dark ||
      (theme.currentThemeMode == ThemeMode.system &&
          SchedulerBinding.instance!.window.platformBrightness ==
              Brightness.dark);
  final List<Statistic> _monthActions = ref
      .watch(statisticsNotifierProvider)
      .statistics
      .where((statistic) => isSameMonth(
          ref.watch(selectedMonthProvider).state, statistic.created))
      .toList();
  final AppDefaultDataNotifier defaultData = ref.watch(appDefaultDataProvider);
  final bool _extraActions = ref.watch(extraActionsProvider).state;

  final addActions =
      _monthActions.where((statistic) => statistic.oldStatus == null);
  final inviteActions = _monthActions.where((statistic) =>
      statistic.oldStatus == defaultData.notContactedID &&
      statistic.newStatus == defaultData.invitedID);
  final presentActions = _monthActions.where((statistic) =>
      statistic.oldStatus == defaultData.invitedID &&
      statistic.newStatus == defaultData.followUpID);
  final signUpClientActions = _monthActions.where((statistic) =>
      statistic.oldStatus == defaultData.followUpID &&
      statistic.newStatus == defaultData.clientID);
  final signUpExecutiveActions = _monthActions.where((statistic) =>
      statistic.oldStatus == defaultData.followUpID &&
      statistic.newStatus == defaultData.executiveID);

  final List<ChartData> chartData = [
    ChartData(
        label: AppLocalizations.current.addProspect,
        value: addActions.length,
        color: Colors.amber),
    ChartData(
        label: AppLocalizations.current.invite,
        value: inviteActions.length,
        color: Colors.blue),
    ChartData(
        label: AppLocalizations.current.present,
        value: presentActions.length,
        color: Colors.indigo),
    ChartData(
        label: AppLocalizations.current.newClient,
        value: signUpClientActions.length,
        color: Colors.lime),
    ChartData(
        label: AppLocalizations.current.newExecutive,
        value: signUpExecutiveActions.length,
        color: Colors.teal),
  ];

  if (_extraActions) {
    final reactivateActions = _monthActions.where((statistic) =>
        statistic.oldStatus == defaultData.notInterestedID &&
        statistic.newStatus == defaultData.notContactedID);
    final upgradeActions = _monthActions.where((statistic) =>
        statistic.oldStatus == defaultData.clientID &&
        statistic.newStatus == defaultData.executiveID);
    final downgradeActions = _monthActions.where((statistic) =>
        statistic.oldStatus == defaultData.executiveID &&
        statistic.newStatus == defaultData.clientID);
    final turnDownActions = _monthActions.where(
        (statistic) => statistic.newStatus == defaultData.notInterestedID);
    final deleteActions =
        _monthActions.where((statistic) => statistic.newStatus == null);

    chartData.addAll([
      ChartData(
          label: AppLocalizations.current.reactivate,
          value: reactivateActions.length,
          color: Colors.amberAccent),
      ChartData(
          label: AppLocalizations.current.clientToExecutive,
          value: upgradeActions.length,
          color: Colors.lightBlueAccent),
      ChartData(
          label: AppLocalizations.current.executiveToClient,
          value: downgradeActions.length,
          color: Colors.deepPurple[200]!),
      ChartData(
          label: AppLocalizations.current.turnDown,
          value: turnDownActions.length,
          color: Colors.red),
      ChartData(
          label: AppLocalizations.current.delete,
          value: deleteActions.length,
          color: Colors.brown),
    ]);
  }

  final List<charts.Series<ChartData, String>> chartSeries = [
    charts.Series(
        data: chartData,
        domainFn: (ChartData data, _) => data.label as String,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) =>
            charts.ColorUtil.fromDartColor(data.color),
        labelAccessorFn: (ChartData data, _) =>
            '${data.label as String}: ${data.value}',
        outsideLabelStyleAccessorFn: (ChartData data, _) =>
            charts.TextStyleSpec(
              color: isDarkMode
                  ? charts.MaterialPalette.white
                  : charts.MaterialPalette.black,
            ),
        id: 'actions_per_month')
  ];

  return chartSeries;
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

  final DateTime _rangeStartMonth = ref.watch(rangeStartMonthProvider);

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

final forwardStatusProvider = Provider<List<String>>((ref) {
  final AppDefaultDataNotifier _defaultData = ref.watch(appDefaultDataProvider);
  final String _selectedStatus =
      ref.watch(effectivenessSelectedStatusProvider).state;

  final List<String> forwardStatus = _selectedStatus == _defaultData.followUpID
      ? [_defaultData.executiveID, _defaultData.clientID]
      : _selectedStatus == _defaultData.invitedID
          ? [_defaultData.followUpID]
          : [_defaultData.invitedID];

  return forwardStatus;
});

// * EFFECTIVENESS CHART
final effectinesChartsData = Provider<Map<String, dynamic>>((ref) {
  final AppDefaultDataNotifier defaultData = ref.watch(appDefaultDataProvider);

  final DateTime _rangeStartMonth = ref.watch(rangeStartMonthProvider);

  final List<Statistic> _rangeActions = ref
      .watch(statisticsNotifierProvider)
      .statistics
      .where((statistic) => statistic.created.isAfter(_rangeStartMonth))
      .toList();

  final String _selectedStatus =
      ref.watch(effectivenessSelectedStatusProvider).state;

  final List<Statistic> _statusActions = _rangeActions
      .where((action) => action.newStatus == _selectedStatus)
      .toList();
  final List<Statistic> _noStatusActions = _rangeActions
      .where((action) => action.newStatus != _selectedStatus)
      .toList();

  final List<String> forwardStatus = ref.watch(forwardStatusProvider);

  final List<List<Statistic>> forwardActions =
      forwardStatus.length == 1 ? [[]] : [[], []];
  final List turnDownActions = [];
  final List deleteActions = [];

  for (final Statistic statusAction in _statusActions) {
    final String contactID = statusAction.contactID;
    final Statistic contactMovedAction = _noStatusActions.firstWhere(
      (action) =>
          action.contactID == contactID && action.oldStatus == _selectedStatus,
      orElse: () => Statistic.empty(),
    );
    if (contactMovedAction.isNotEmpty) {
      if (contactMovedAction.newStatus == defaultData.notInterestedID) {
        turnDownActions.add(contactMovedAction);
      } else if (contactMovedAction.newStatus == null) {
        deleteActions.add(contactMovedAction);
      } else if (contactMovedAction.newStatus == forwardStatus[0]) {
        forwardActions[0].add(contactMovedAction);
      } else if (forwardStatus.length == 2 &&
          contactMovedAction.newStatus == forwardStatus[1]) {
        forwardActions[1].add(contactMovedAction);
      }
    }
  }

  // FORWARD CHART DATA
  final forwardLength = forwardStatus.length == 1
      ? forwardActions[0].length
      : forwardActions[0].length + forwardActions[1].length;
  final List<ChartData> forwardChartData = [
    ChartData(
        label: 'forward', value: forwardActions[0].length, color: Colors.green),
    ChartData(
      label: 'empty',
      value: _statusActions.isEmpty ? 1 : _statusActions.length - forwardLength,
      color: Colors.grey[200]!,
    )
  ];
  if (forwardStatus.length == 2) {
    forwardChartData.insert(
      1,
      ChartData(
        label: 'forward-2',
        value: forwardActions[1].length,
        color: Colors.lime,
      ),
    );
  }

  final List<charts.Series<ChartData, String>> forwardChartSeries = [
    charts.Series(
        data: forwardChartData,
        domainFn: (ChartData data, _) => data.label as String,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) =>
            charts.ColorUtil.fromDartColor(data.color),
        labelAccessorFn: (ChartData data, _) {
          if (data.label == 'empty' || data.value == 0) {
            return '';
          } else {
            return '${data.value}';
          }
        },
        id: 'effectiveness-forward'),
  ];

  // STAY CHART DATA
  final List<ChartData> stayChartData = [
    ChartData(
      label: 'stay',
      value: _statusActions.length -
          forwardLength -
          turnDownActions.length -
          deleteActions.length,
      color: Colors.amber,
    ),
    ChartData(
      label: 'empty',
      value: _statusActions.isEmpty
          ? 1
          : forwardLength + turnDownActions.length + deleteActions.length,
      color: Colors.grey[200]!,
    ),
  ];

  final List<charts.Series<ChartData, String>> stayChartSeries = [
    charts.Series(
        data: stayChartData,
        domainFn: (ChartData data, _) => data.label as String,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) =>
            charts.ColorUtil.fromDartColor(data.color),
        labelAccessorFn: (ChartData data, _) {
          if (data.label == 'empty' || data.value == 0) {
            return '';
          } else {
            return '${data.value}';
          }
        },
        id: 'effectiveness-stay'),
  ];

  // TURN DOWN CHART DATA
  final List<ChartData> turnDownChartData = [
    ChartData(
      label: 'turn-down',
      value: turnDownActions.length,
      color: Colors.red,
    ),
    ChartData(
      label: 'empty',
      value: _statusActions.isEmpty
          ? 1
          : _statusActions.length - turnDownActions.length,
      color: Colors.grey[200]!,
    )
  ];

  final List<charts.Series<ChartData, String>> turnDownChartSeries = [
    charts.Series(
        data: turnDownChartData,
        domainFn: (ChartData data, _) => data.label as String,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) =>
            charts.ColorUtil.fromDartColor(data.color),
        labelAccessorFn: (ChartData data, _) {
          if (data.label == 'empty' || data.value == 0) {
            return '';
          } else {
            return '${data.value}';
          }
        },
        id: 'effectiveness-turn-down'),
  ];

  final Map<String, dynamic> data = {
    'status_actions': _statusActions.length,
    'forward_data': forwardChartSeries,
    'forward_percentage': _statusActions.isNotEmpty
        ? forwardLength / _statusActions.length * 100
        : null,
    'stay_data': stayChartSeries,
    'stay_percentage': _statusActions.isNotEmpty
        ? (_statusActions.length -
                forwardLength -
                turnDownActions.length -
                deleteActions.length) /
            _statusActions.length *
            100
        : null,
    'turn_down_data': turnDownChartSeries,
    'turn_down_percentage': _statusActions.isNotEmpty
        ? turnDownActions.length / _statusActions.length * 100
        : null,
    'delete_actions': deleteActions.length,
  };

  return data;
});

// * TURN DOWN CHART DATA
final turnDownAnalysisChartData =
    Provider<List<charts.Series<ChartData, String>>>((ref) {
  final DateTime _rangeStartMonth = ref.watch(rangeStartMonthProvider);
  final AppDefaultDataNotifier defaultData = ref.watch(appDefaultDataProvider);

  final List<Statistic> rangeTurnDownActions = ref
      .watch(statisticsNotifierProvider)
      .statistics
      .where((statistic) =>
          statistic.created.isAfter(_rangeStartMonth) &&
          statistic.newStatus == defaultData.notInterestedID)
      .toList();

  final List<List<ChartData>> dataList = [
    [
      ChartData(
        label: AppLocalizations.current.notInterestedP,
        value: rangeTurnDownActions.length,
        color: Colors.red,
      ),
    ],
    [
      ChartData(
        label: AppLocalizations.current.notContactedP,
        value: rangeTurnDownActions
            .where((statistic) =>
                statistic.oldStatus == defaultData.notContactedID)
            .length,
        color: Colors.amber,
      ),
    ],
    [
      ChartData(
          label: AppLocalizations.current.invitedP,
          value: rangeTurnDownActions
              .where(
                  (statistic) => statistic.oldStatus == defaultData.invitedID)
              .length,
          color: Colors.blue),
    ],
    [
      ChartData(
          label: AppLocalizations.current.followUp,
          value: rangeTurnDownActions
              .where(
                  (statistic) => statistic.oldStatus == defaultData.followUpID)
              .length,
          color: Colors.indigo),
    ],
    [
      ChartData(
          label: AppLocalizations.current.clients,
          value: rangeTurnDownActions
              .where((statistic) => statistic.oldStatus == defaultData.clientID)
              .length,
          color: Colors.lime),
    ],
    [
      ChartData(
          label: AppLocalizations.current.executives,
          value: rangeTurnDownActions
              .where(
                  (statistic) => statistic.oldStatus == defaultData.executiveID)
              .length,
          color: Colors.teal),
    ],
  ];

  return dataList
      .map(
        (data) => charts.Series<ChartData, String>(
          id: data.first.label as String,
          seriesCategory: data.first.label as String ==
                  AppLocalizations.current.notInterestedP
              ? 'A'
              : 'B',
          domainFn: (ChartData data, _) => AppLocalizations.current.turnDown,
          measureFn: (ChartData data, _) => data.value,
          colorFn: (ChartData data, _) =>
              charts.ColorUtil.fromDartColor(data.color),
          labelAccessorFn: (ChartData data, _) =>
              data.value == 0 ? '' : '${data.label}: ${data.value}',
          data: data,
        ),
      )
      .toList();
});
