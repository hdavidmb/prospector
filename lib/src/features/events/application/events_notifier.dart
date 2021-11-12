import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../core/database/database_failures/database_failure.dart';
import '../../../presentation/helpers/date_formatters.dart';
import '../../../presentation/theme/theme_providers.dart';
import '../../local_notifications/application/local_notifications_providers.dart';
import '../../user/application/user_info_providers.dart';
import '../domain/entites/event_alert.dart';
import '../domain/entites/event_entity.dart';
import '../domain/events_use_cases.dart';
import 'events_state.dart';

class EventsNotifier extends ChangeNotifier {
  final EventsUseCases eventsUseCases;
  final Reader read;
  EventsNotifier({
    required this.eventsUseCases,
    required this.read,
  });

  EventsState _eventsState = const EventsState.initial();
  late List<Event> _events;

  EventsState get eventsState => _eventsState;
  List<Event> get events => _events;

  void reset() => _eventsState = const EventsState.initial();

  // *************** CRUD ****************
  Future<Either<DatabaseFailure, Unit>> createEvent(Event event) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final int? notificationID = _setEventNotification(event: event);
      final newEventInfo = event.copyWith(notificationID: notificationID);
      final createResult =
          await eventsUseCases.createEvent(event: newEventInfo, uid: uid);
      return createResult.fold(
        (failure) => left(failure),
        (unit) {
          _events
            ..add(newEventInfo)
            ..sort((a, b) => b.startDate.compareTo(a.startDate));

          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<void> getEvents() async {
    if (_eventsState == const EventsState.initial()) {
      _eventsState = const EventsState.fetching();
      final uid = read(userInfoNotifierProvider).user?.uid;
      if (uid != null) {
        final getResult = await eventsUseCases.getEventsList(uid: uid);
        getResult.fold(
          (failure) => _eventsState = const EventsState.error(),
          (eventsList) {
            eventsList.sort((a, b) => b.startDate.compareTo(a.startDate));
            _events = eventsList;
            _eventsState = const EventsState.ready();
          },
        );
      } else {
        _eventsState = const EventsState.error();
      }
      notifyListeners();
    }
  }

  Future<Either<DatabaseFailure, Unit>> updateEvent(Event event) async {
    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final int? notificationID = _setEventNotification(event: event);
      final Event newEventInfo = event.copyWith(
          modified: DateTime.now(), notificationID: notificationID);
      final updateResult =
          await eventsUseCases.updateEvent(event: event, uid: uid);
      return updateResult.fold(
        (failure) => left(failure),
        (unit) async {
          final int index = _events
              .indexWhere((listEvent) => listEvent.id == newEventInfo.id);
          _events[index] = newEventInfo;
          _events.sort((a, b) => b.startDate.compareTo(a.startDate));
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  Future<Either<DatabaseFailure, Unit>> removeContactFromEvent(
      {required String contactID, required Event event}) async {
    if (event.guests != null && event.guests!.contains(contactID)) {
      final Event newEventInfo = event.copyWith(title: event.title);
      newEventInfo.guests!.remove(contactID);
      return updateEvent(newEventInfo);
    } else {
      return right(unit);
    }
  }

  Future<Either<DatabaseFailure, Unit>> removeContactFromAllEvents(
      {required String contactID}) async {
    Either<DatabaseFailure, Unit> removeResult = right(unit);
    final List<Event> contactEvents = _events
        .where((event) =>
            event.guests != null && event.guests!.contains(contactID))
        .toList();
    for (final Event event in contactEvents) {
      removeResult =
          await removeContactFromEvent(contactID: contactID, event: event);
    }
    return removeResult;
  }

  Future<Either<DatabaseFailure, Unit>> deleteEvent(
      {required String eventID}) async {
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final deleteResult =
          await eventsUseCases.deleteEvent(eventID: eventID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          final Event event =
              _events.firstWhere((listEvent) => listEvent.id == eventID);
          _events.remove(event);
          _cancelEventNotification(event: event);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }

  int? _setEventNotification({required Event event}) {
    if (event.notification != EventAlert.none) {
      final int notificationID =
          event.notificationID ?? int.parse(randomNumeric(9));
      final bool is24hours = read(themeNotifierProvider).is24hours;
      read(localNotificationsProvider).scheduleNotification(
        id: notificationID,
        title: event.title,
        body: eventNotificationFormattedDate(
            date: event.startDate, is24hours: is24hours),
        date: event.startDate
            .subtract(event.notification.duration ?? Duration.zero),
        payload: event.id,
      );
      return notificationID;
    } else {
      _cancelEventNotification(event: event);
    }
  }

  void _cancelEventNotification({required Event event}) {
    if (event.notificationID != null) {
      read(localNotificationsProvider)
          .cancelNotification(id: event.notificationID!);
    }
  }
}
