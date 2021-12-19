import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../../core/fetch_state/fetch_state.dart';
import '../../app_default_data/application/app_default_data_notifier.dart';
import '../../app_default_data/application/app_default_data_providers.dart';
import '../../contacts/application/contacts_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/statistic_entity.dart';
import '../domain/statistics_use_cases.dart';

class StatisticsNotifier extends ChangeNotifier {
  final StatisticsUseCases statisticsUseCases;
  final Reader read;
  StatisticsNotifier({
    required this.statisticsUseCases,
    required this.read,
  });

  FetchState _statisticsState = const FetchState.initial();
  List<Statistic> _statistics = [];

  FetchState get statisticsState => _statisticsState;
  List<Statistic> get statistics => _statistics;

  void reset() => _statisticsState = const FetchState.initial();

  Future<void> getStatistics() async {
    if (_statisticsState.isInitial) {
      _statisticsState = const FetchState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await statisticsUseCases.getStatisticsList(uid: uid);
        getResult.fold(
          (failure) => _statisticsState = const FetchState.error(),
          (statisticsList) {
            statisticsList.sort((a, b) => a.created.compareTo(b.created));
            _statistics = statisticsList;
            _statisticsState = const FetchState.ready();
          },
        );
      } else {
        _statisticsState = const FetchState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> _saveStatistic(
      Statistic statistic) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final createResult = await statisticsUseCases.createStatistic(
          statistic: statistic, uid: uid);

      return createResult.fold(
        (failure) => left(failure),
        (_) {
          _statistics
            ..add(statistic)
            ..sort((a, b) =>
                a.created.compareTo(b.created)); // TODO chekc if needed to sort
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<Either<DatabaseFailure, Unit>> _deleteStatistic(
      {required String statisticID}) async {
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final deleteResult = await statisticsUseCases.deleteStatistic(
          statisticID: statisticID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          _statistics
              .removeWhere((listStatistic) => listStatistic.id == statisticID);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  bool _isBackwardsAction(
      {required String? oldStatusID, required String? newStatusID}) {
    final AppDefaultDataNotifier defaultData = read(appDefaultDataProvider);
    bool isBackwards = false;
    if (oldStatusID == defaultData.clientID ||
        oldStatusID == defaultData.executiveID) {
      if (newStatusID == defaultData.followUpID ||
          newStatusID == defaultData.invitedID ||
          newStatusID == defaultData.notContactedID) {
        isBackwards = true;
      }
    } else if (oldStatusID == defaultData.followUpID) {
      if (newStatusID == defaultData.invitedID ||
          newStatusID == defaultData.notContactedID) {
        isBackwards = true;
      }
    } else if (oldStatusID == defaultData.invitedID) {
      if (newStatusID == defaultData.notContactedID) {
        isBackwards = true;
      }
    }
    return isBackwards;
  }

  /// [oldStatusID] and [newStatusID] shouldn't be both null.
  /// At least one of them should have a valid value
  Future<Either<DatabaseFailure, Unit>> _createAndSaveStatistic(
      {required String contactID,
      required String? oldStatusID,
      required String? newStatusID,
      required bool isLastAction}) async {
    final String? uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final int oldListCount = read(contactsNotifierProvider)
          .contacts
          .where((contact) => contact.status == oldStatusID)
          .toList()
          .length;
      final int newListCount = read(contactsNotifierProvider)
          .contacts
          .where((contact) => contact.status == newStatusID)
          .toList()
          .length;
      final Statistic newStatistic = Statistic(
        id: randomAlphaNumeric(20),
        contactID: contactID,
        userID: uid,
        created: DateTime.now(),
        oldStatus: oldStatusID,
        oldListCount: oldStatusID == null ? null : oldListCount,
        newStatus: newStatusID,
        newListCount: newStatusID == null
            ? null
            : isLastAction
                ? newListCount
                : newListCount + 1,
      );
      return _saveStatistic(newStatistic);
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<void> manageStatisticActionData({
    required String contactID,
    required String? oldStatusID,
    required String? newStatusID,
  }) async {
    final bool isPremium = read(userInfoNotifierProvider).isPremiumUser;
    if (isPremium) {
      final bool isBackwards = _isBackwardsAction(
          oldStatusID: oldStatusID, newStatusID: newStatusID);
      final AppDefaultDataNotifier defaultData = read(appDefaultDataProvider);

      if (!isBackwards) {
        if (newStatusID == defaultData.notInterestedID || newStatusID == null) {
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: oldStatusID,
            newStatusID: newStatusID,
            isLastAction: true,
          );
          return;
        }

        if (oldStatusID == null || oldStatusID == defaultData.notInterestedID) {
          final String nextStepStatusID = defaultData.notContactedID;
          final bool isLastAction = newStatusID == nextStepStatusID;
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: oldStatusID,
            newStatusID: nextStepStatusID,
            isLastAction: isLastAction,
          );
          if (isLastAction) return;
        }

        if (oldStatusID == null ||
            oldStatusID == defaultData.notInterestedID ||
            oldStatusID == defaultData.notContactedID) {
          final String nextStepStatusID = defaultData.invitedID;
          final bool isLastAction = newStatusID == nextStepStatusID;
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: defaultData.notContactedID,
            newStatusID: nextStepStatusID,
            isLastAction: isLastAction,
          );
          if (isLastAction) return;
        }

        if (oldStatusID == null ||
            oldStatusID == defaultData.notInterestedID ||
            oldStatusID == defaultData.notContactedID ||
            oldStatusID == defaultData.invitedID) {
          final String nextStepStatusID = defaultData.followUpID;
          final bool isLastAction = newStatusID == nextStepStatusID;
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: defaultData.invitedID,
            newStatusID: nextStepStatusID,
            isLastAction: isLastAction,
          );
          if (isLastAction) return;
        }

        if (oldStatusID == null ||
            oldStatusID == defaultData.notInterestedID ||
            oldStatusID == defaultData.notContactedID ||
            oldStatusID == defaultData.invitedID ||
            oldStatusID == defaultData.followUpID) {
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: defaultData.followUpID,
            newStatusID: newStatusID,
            isLastAction: true,
          );
          return;
        }

        if (oldStatusID == defaultData.clientID ||
            oldStatusID == defaultData.executiveID) {
          await _createAndSaveStatistic(
            contactID: contactID,
            oldStatusID: oldStatusID,
            newStatusID: newStatusID,
            isLastAction: true,
          );
          return;
        }
      } else {
        if (oldStatusID == defaultData.clientID ||
            oldStatusID == defaultData.executiveID) {
          final inAffiliatedAction = _statistics.lastWhere(
              (action) =>
                  action.contactID == contactID &&
                  action.newStatus == oldStatusID,
              orElse: () => Statistic.empty());
          final outFollowUpAction = _statistics.lastWhere(
              (action) =>
                  action.contactID == contactID &&
                  action.oldStatus == defaultData.followUpID,
              orElse: () => Statistic.empty());
          if (inAffiliatedAction.isNotEmpty && outFollowUpAction.isNotEmpty) {
            for (final Statistic action in _statistics) {
              if (action.contactID == contactID &&
                  (action.created).compareTo(outFollowUpAction.created) >= 0 &&
                  (action.created).compareTo(inAffiliatedAction.created) <= 0) {
                _deleteStatistic(statisticID: action.id);
              }
            }
          }
        }

        if (newStatusID == defaultData.followUpID) return;

        if (oldStatusID == defaultData.clientID ||
            oldStatusID == defaultData.executiveID ||
            oldStatusID == defaultData.followUpID) {
          final lastPresentationAction = _statistics.lastWhere(
            (action) =>
                action.contactID == contactID &&
                action.oldStatus == defaultData.invitedID,
            orElse: () => Statistic.empty(),
          );
          if (lastPresentationAction.isNotEmpty) {
            _deleteStatistic(statisticID: lastPresentationAction.id);
          }
        }

        if (newStatusID == defaultData.invitedID) return;

        if (oldStatusID == defaultData.clientID ||
            oldStatusID == defaultData.executiveID ||
            oldStatusID == defaultData.followUpID ||
            oldStatusID == defaultData.invitedID) {
          final lastInvitationAction = _statistics.lastWhere(
            (action) =>
                action.contactID == contactID &&
                action.oldStatus == defaultData.notContactedID,
            orElse: () => Statistic.empty(),
          );
          if (lastInvitationAction.isNotEmpty) {
            _deleteStatistic(statisticID: lastInvitationAction.id);
          }
        }
      }
    }
  }

  // * Getters and filters
  List<DateTime> get statisticsMonthsList {
    final List<DateTime> monthsList = [];
    for (final Statistic statistic in statistics) {
      final DateTime created = statistic.created;
      final DateTime statisticMonth = DateTime(created.year, created.month);
      if (!monthsList.contains(statisticMonth)) {
        monthsList.add(statisticMonth);
      }
    }
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    if (!monthsList.contains(currentMonth)) {
      monthsList.add(currentMonth);
    }
    monthsList.sort();
    return monthsList;
  }

  DateTime get statisticsFirstMonth => statisticsMonthsList.isNotEmpty
      ? statisticsMonthsList.first
      : DateTime(DateTime.now().year, DateTime.now().month);
}
