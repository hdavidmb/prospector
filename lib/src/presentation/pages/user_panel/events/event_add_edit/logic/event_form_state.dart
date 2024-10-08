import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/database/database_failures/database_failure.dart';
import '../../../../../../features/events/domain/entites/event_alert.dart';

part 'event_form_state.freezed.dart';

@freezed
class EventFormState with _$EventFormState {
  const factory EventFormState({
    required String title,
    required String location,
    required bool allDay,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> guests,
    required EventAlert notification,
    required bool isEvent,
    required bool isSubmitting,
    required bool showErrorMessages,
    required bool deleted,
    required Option<Either<DatabaseFailure, Unit>> failureOrSuccesOption,
  }) = _EventFormState;

  const EventFormState._();

  factory EventFormState.initial() => EventFormState(
        title: '',
        location: '',
        allDay: false,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        guests: [],
        notification: EventAlert.none,
        isEvent: true,
        isSubmitting: false,
        showErrorMessages: false,
        deleted: false,
        failureOrSuccesOption: none(),
      );
}
