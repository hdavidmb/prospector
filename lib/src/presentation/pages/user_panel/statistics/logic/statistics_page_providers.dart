import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/generated/l10n.dart';
import 'package:prospector/src/features/contacts/application/contacts_notifier.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:prospector/src/features/statistics/domain/chart_data_entity.dart';
import 'package:prospector/src/features/statistics/domain/statistics_range_entity.dart';

final includeNotInterestedProvider = StateProvider<bool>((ref) => false);

final historicProvider = StateProvider<bool>((ref) => false);

final extraActionsProvider = StateProvider<bool>((ref) => false);

final selectedMonthProvider = StateProvider<DateTime>(
    (ref) => DateTime(DateTime.now().year, DateTime.now().month));

final selectedRangeProvider =
    StateProvider<StatisticsRange>((ref) => StatisticsRange.thisMonth);

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
