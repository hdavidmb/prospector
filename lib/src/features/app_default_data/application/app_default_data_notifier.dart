import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prospector/src/features/app_default_data/application/app_default_data_state.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/status_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/entities/subscription_entity.dart';
import 'package:prospector/src/features/app_default_data/domain/use_cases/get_statuses.dart';
import 'package:prospector/src/features/app_default_data/domain/use_cases/get_subscriptions.dart';

class AppDefaultDataNotifier extends ChangeNotifier {
  final GetStatuses getStatuses;
  final GetSubscriptions getSubscriptions;
  AppDefaultDataNotifier({
    required this.getStatuses,
    required this.getSubscriptions,
  });

  AppDefaultDataState _defaultDataState = const AppDefaultDataState.initial();
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
  AppDefaultDataState get defaultDataState => _defaultDataState;

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
      (_) => _defaultDataState = const AppDefaultDataState.error(),
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
      (_) => _defaultDataState = const AppDefaultDataState.error(),
      (subscriptions) {
        _subscriptions = subscriptions;
        subscriptionsReady = true;
      },
    );

    if (statusesReady && subscriptionsReady) {
      _defaultDataState = const AppDefaultDataState.ready();
    }
    notifyListeners();
  }

  String getStatusText(
      {required BuildContext context,
      required String statusID,
      bool isPlural = false,
      String gender = 'male'}) {
    if (statusID == _notInterestedID) {
      return isPlural
          ? AppLocalizations.of(context)!.notInterestedP
          : gender == 'female'
              ? AppLocalizations.of(context)!.notInteresteF
              : AppLocalizations.of(context)!.notInterested;
    }
    if (statusID == _notContactedID) {
      return isPlural
          ? AppLocalizations.of(context)!.notContactedP
          : gender == 'female'
              ? AppLocalizations.of(context)!.notContactedF
              : AppLocalizations.of(context)!.notContacted;
    }
    if (statusID == _invitedID) {
      return isPlural
          ? AppLocalizations.of(context)!.invitedP
          : gender == 'female'
              ? AppLocalizations.of(context)!.invitedF
              : AppLocalizations.of(context)!.invited;
    }
    if (statusID == _followUpID) return AppLocalizations.of(context)!.followUp;
    if (statusID == _clientID) {
      return isPlural
          ? AppLocalizations.of(context)!.clients
          : gender == 'female'
              ? AppLocalizations.of(context)!.clientF
              : AppLocalizations.of(context)!.client;
    }
    if (statusID == _executiveID) {
      return isPlural
          ? AppLocalizations.of(context)!.executives
          : gender == 'female'
              ? AppLocalizations.of(context)!.executiveF
              : AppLocalizations.of(context)!.executive;
    }
    return AppLocalizations.of(context)!.notContacted;
  }

  IconData getStatusIcon({required String statusID}) {
    if (statusID == _notInterestedID) return FontAwesomeIcons.thermometerEmpty;
    if (statusID == _notContactedID) return FontAwesomeIcons.thermometerQuarter;
    if (statusID == _invitedID) return FontAwesomeIcons.thermometerHalf;
    if (statusID == _followUpID) return FontAwesomeIcons.thermometerThreeQuarters;
    if (statusID == _clientID) return FontAwesomeIcons.thermometerFull;
    if (statusID == _executiveID) return FontAwesomeIcons.thermometerFull;
    return FontAwesomeIcons.thermometerHalf;
  }
}
