import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
