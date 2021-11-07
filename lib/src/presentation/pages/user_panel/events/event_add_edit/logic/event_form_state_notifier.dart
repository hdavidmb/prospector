import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';

import '../../../../../../core/database/database_failures/database_failure.dart';
import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../../features/events/domain/entites/event_alert.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';
import '../../../../../helpers/form_validators.dart';
import 'event_form_state.dart';

class EventFormStateNotifier extends StateNotifier<EventFormState>
    with FormValidators {
  final Reader read;
  EventFormStateNotifier({
    required this.read,
  }) : super(EventFormState.initial());

  void reset() => state = EventFormState.initial();

  void setEditingState({required Event editingEvent}) {
    state = EventFormState(
      title: editingEvent.title,
      location: editingEvent.location ?? '',
      allDay: editingEvent.allDay,
      startDate: editingEvent.startDate,
      endDate: editingEvent.endDate,
      guests: editingEvent.guests ?? [],
      notification: editingEvent.notification,
      isEvent: editingEvent.type == 'event',
      isSubmitting: false,
      showErrorMessages: false,
      deleted: false,
      failureOrSuccesOption: none(),
    );
  }

  void setInitialDates({required DateTime selectedDay}) {
    final DateTime startDate = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
      DateTime.now().hour + 1,
    );
    final DateTime endDate = startDate.add(const Duration(hours: 1));

    state = state.copyWith(startDate: startDate, endDate: endDate);
  }

  // ignore: avoid_positional_boolean_parameters
  void setIsEvent(bool? value) => state =
      state.copyWith(isEvent: value ?? true, failureOrSuccesOption: none());

  void titleChanged(String value) =>
      state = state.copyWith(title: value, failureOrSuccesOption: none());

  void locationChanged(String value) =>
      state = state.copyWith(location: value, failureOrSuccesOption: none());

  // ignore: avoid_positional_boolean_parameters
  void allDayChanged(bool value) =>
      state = state.copyWith(allDay: value, failureOrSuccesOption: none());

  void startDateChanged(DateTime value) {
    if (value.isAfter(state.endDate)) {
      state = state.copyWith(
          startDate: value,
          endDate: value.add(const Duration(hours: 1)),
          failureOrSuccesOption: none());
    } else {
      state = state.copyWith(startDate: value, failureOrSuccesOption: none());
    }
  }

  void endDateChanged(DateTime value) {
    if (value.isBefore(state.startDate)) {
      state = state.copyWith(
          startDate: value.subtract(const Duration(hours: 1)),
          endDate: value,
          failureOrSuccesOption: none());
    } else {
      state = state.copyWith(endDate: value, failureOrSuccesOption: none());
    }
  }

  void guestsChanged(List<String>? values) {
    if (values != null) {
      state = state.copyWith(guests: values, failureOrSuccesOption: none());
    }
  }

  void notificationChanged(Option<EventAlert> alertOption) {
    alertOption.fold(
      () => null,
      (alert) => state =
          state.copyWith(notification: alert, failureOrSuccesOption: none()),
    );
  }

  Future<void> saveButtonPressed({Event? editingEvent}) async {
    //Validate title field
    final bool isTitleValid = validateFieldIsNotEmpty(state.title);
    Either<DatabaseFailure, Unit>? failureOrSuccess;

    if (isTitleValid) {
      // Set submitting state
      state = state.copyWith(isSubmitting: true, failureOrSuccesOption: none());

      // Arrange eventEntity from state values
      final newEventInfo = Event(
        id: editingEvent?.id ?? randomAlphaNumeric(20),
        allDay: state.allDay,
        created: editingEvent?.created ?? DateTime.now(),
        modified: editingEvent?.modified ?? DateTime.now(),
        startDate: state.startDate,
        endDate: state.endDate,
        title: state.title,
        type: state.isEvent ? 'event' : 'reminder',
        notification: state.notification,
        guests: state.guests.isNotEmpty ? state.guests : null,
        location: state.location.isNotEmpty ? state.location : null,
      );

      // If editing compare event entities
      if (editingEvent != null) {
        // Compare
        if (editingEvent != newEventInfo) {
          // TODO: investigate about freezed data classes equality when fields are lists
          // TODO: Check if sending inmuted event counts as write in firebase
          // Edit
          failureOrSuccess =
              await read(eventsNotifierProvider).updateEvent(newEventInfo);
        } else {
          failureOrSuccess = right(unit);
        }
      } else {
        // Create event
        failureOrSuccess =
            await read(eventsNotifierProvider).createEvent(newEventInfo);
      }
    }

    // Set final state (failure or success)
    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      failureOrSuccesOption: optionOf(failureOrSuccess),
    );
  }
}
