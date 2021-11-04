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
        if ((alert as EventAlert) != event.notifications[0]) {
          final Event newEventInfo = event.copyWith(notifications: [alert]);
          read(eventsNotifierProvider).updateEvent(newEventInfo);
        }
      },
    );
  }
}
