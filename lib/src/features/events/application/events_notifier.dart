import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/core/database/database_failures/database_failure.dart';
import 'package:prospector/src/features/events/domain/entites/event_entity.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

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
      final createResult =
          await eventsUseCases.createEvent(event: event, uid: uid);
      return createResult.fold(
        (failure) => left(failure),
        (unit) {
          _events
            ..add(event)
            ..sort((a, b) =>
                b.startDate.compareTo(a.startDate)); //TODO check sort order
          // TODO Schedule local notification
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
            eventsList.sort((a, b) =>
                b.startDate.compareTo(a.startDate)); //TODO check sort order
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
    // TODO compare, delete and schedule notifications

    final uid = read(userInfoNotifierProvider).user?.uid;

    if (uid != null) {
      final Event newEventInfo = event.copyWith(modified: DateTime.now());
      final updateResult =
          await eventsUseCases.updateEvent(event: event, uid: uid);
      return updateResult.fold(
        (failure) => left(failure),
        (unit) async {
          final int index = _events
              .indexWhere((listEvent) => listEvent.id == newEventInfo.id);
          _events[index] = newEventInfo;
          _events.sort((a, b) =>
              b.startDate.compareTo(a.startDate)); //TODO check sort order
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
    // TODO delete notifications
    final uid = read(userInfoNotifierProvider).user?.uid;
    if (uid != null) {
      final deleteResult =
          await eventsUseCases.deleteEvent(eventID: eventID, uid: uid);
      return deleteResult.fold(
        (failure) => left(failure),
        (unit) {
          _events.removeWhere((listEvent) => listEvent.id == eventID);
          notifyListeners();
          return right(unit);
        },
      );
    } else {
      return left(const DatabaseFailure.noUserAuthenticated());
    }
  }
}
