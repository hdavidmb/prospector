import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/l10n.dart';
import '../../../core/fetch_state/fetch_state.dart';
import '../domain/entities/status_entity.dart';
import '../domain/entities/subscription_entity.dart';
import '../domain/use_cases/get_statuses.dart';
import '../domain/use_cases/get_subscriptions.dart';

class AppDefaultDataNotifier extends ChangeNotifier {
  final GetStatuses getStatuses;
  final GetSubscriptions getSubscriptions;
  AppDefaultDataNotifier({
    required this.getStatuses,
    required this.getSubscriptions,
  });

  FetchState _defaultDataState = const FetchState.initial();
  void reset() => _defaultDataState = const FetchState.initial();

  late List<Status> _statuses;
  late String _notInterestedID;
  late String _notContactedID;
  late String _invitedID;
  late String _followUpID;
  late String _clientID;
  late String _executiveID;
  late List<Subscription> _subscriptions;

  List<Status> get statuses => _statuses;
  List<Subscription> get subscriptions => _subscriptions;
  FetchState get defaultDataState => _defaultDataState;

  String get notInterestedID => _notInterestedID;
  String get notContactedID => _notContactedID;
  String get invitedID => _invitedID;
  String get followUpID => _followUpID;
  String get clientID => _clientID;
  String get executiveID => _executiveID;

  String get premiumSubID =>
      _subscriptions.firstWhere((sub) => sub.key == 'premium').id;
  String get freeSubID =>
      _subscriptions.firstWhere((sub) => sub.key == 'free').id;

  Future<void> getDefaultData() async {
    bool statusesReady = false;
    bool subscriptionsReady = false;

    final statusesResult = await getStatuses();
    statusesResult.fold(
      (_) => _defaultDataState = const FetchState.error(),
      (statuses) {
        _statuses = statuses;
        _notInterestedID =
            statuses.firstWhere((status) => status.key == 'not_interested').id;
        _notContactedID =
            statuses.firstWhere((status) => status.key == 'not_contacted').id;
        _invitedID =
            statuses.firstWhere((status) => status.key == 'invited').id;
        _followUpID =
            statuses.firstWhere((status) => status.key == 'follow_up').id;
        _clientID = statuses.firstWhere((status) => status.key == 'client').id;
        _executiveID =
            statuses.firstWhere((status) => status.key == 'executive').id;
        statusesReady = true;
      },
    );

    final subscriptionsResult = await getSubscriptions();
    subscriptionsResult.fold(
      (_) => _defaultDataState = const FetchState.error(),
      (subscriptions) {
        _subscriptions = subscriptions;
        subscriptionsReady = true;
      },
    );

    if (statusesReady && subscriptionsReady) {
      _defaultDataState = const FetchState.ready();
    }
    notifyListeners();
  }

  String getStatusText({
    required String statusID,
    bool isPlural = false,
    String gender = 'male',
  }) {
    if (statusID == _notInterestedID) {
      return isPlural
          ? AppLocalizations.current.notInterestedP
          : gender == 'female'
              ? AppLocalizations.current.notInteresteF
              : AppLocalizations.current.notInterested;
    }
    if (statusID == _notContactedID) {
      return isPlural
          ? AppLocalizations.current.notContactedP
          : gender == 'female'
              ? AppLocalizations.current.notContactedF
              : AppLocalizations.current.notContacted;
    }
    if (statusID == _invitedID) {
      return isPlural
          ? AppLocalizations.current.invitedP
          : gender == 'female'
              ? AppLocalizations.current.invitedF
              : AppLocalizations.current.invited;
    }
    if (statusID == _followUpID) return AppLocalizations.current.followUp;
    if (statusID == _clientID) {
      return isPlural
          ? AppLocalizations.current.clients
          : gender == 'female'
              ? AppLocalizations.current.clientF
              : AppLocalizations.current.client;
    }
    if (statusID == _executiveID) {
      return isPlural
          ? AppLocalizations.current.executives
          : gender == 'female'
              ? AppLocalizations.current.executiveF
              : AppLocalizations.current.executive;
    }
    return AppLocalizations.current.notContacted;
  }

  IconData getStatusIcon({required String statusID}) {
    if (statusID == _notInterestedID) return FontAwesomeIcons.thermometerEmpty;
    if (statusID == _notContactedID) return FontAwesomeIcons.thermometerQuarter;
    if (statusID == _invitedID) return FontAwesomeIcons.thermometerHalf;
    if (statusID == _followUpID) {
      return FontAwesomeIcons.thermometerThreeQuarters;
    }
    if (statusID == _clientID) return FontAwesomeIcons.thermometerFull;
    if (statusID == _executiveID) return FontAwesomeIcons.thermometerFull;
    return FontAwesomeIcons.thermometerHalf;
  }
}
