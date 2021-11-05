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
    //TODO: Set editing state
  }

  // ignore: avoid_positional_boolean_parameters
  void setIsEvent(bool? value) => state =
      state.copyWith(isEvent: value ?? true, failureOrSuccesOption: none());

  void titleChanged(String value) =>
      state.copyWith(title: value, failureOrSuccesOption: none());
}
