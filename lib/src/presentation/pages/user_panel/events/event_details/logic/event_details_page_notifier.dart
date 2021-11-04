import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../features/events/application/events_providers.dart';
import '../../../../../../features/events/domain/entites/event_alert.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';

class EventDetailsPageNotifier {
  final Reader read;
  EventDetailsPageNotifier({
    required this.read,
  });

  Future<void> guestsTilePressed(
      {required Event event, required List<String>? selectedGuests}) async {
    if (selectedGuests != null) {
      final bool guestsChanged = event.guests == null ||
          (event.guests != null && !selectedGuests.equals(event.guests!));
      if (guestsChanged) {
        final Event newEventInfo = event.copyWith(guests: selectedGuests);
        read(eventsNotifierProvider).updateEvent(newEventInfo);
      }
    }
  }

  Future<void> alertListTilePressed(
      {required Option selectedAlert, required Event event}) async {
    selectedAlert.fold(
      () => null,
      (alert) {
        //TODO move transform logic to Event entity using EventAlert for notifications

        final Duration? alertDuration = (alert as EventAlert).duration;
        final List<DateTime>? notifications = alertDuration != null
            ? [event.startDate.subtract(alertDuration)]
            : null;
        final Event newEventInfo = event.copyWith(notifications: notifications);
        read(eventsNotifierProvider).updateEvent(newEventInfo);
      },
    );
  }
}
