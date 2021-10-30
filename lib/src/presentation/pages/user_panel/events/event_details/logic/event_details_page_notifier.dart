import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class EventDetailsPageNotifier {
  final Reader read;
  EventDetailsPageNotifier({
    required this.read,
  });

  Future<void> guestsTilePressed(
      {required Event event, List<String>? selectedGuests}) async {
    if (selectedGuests != null) {
      final bool guestsChanged = event.guests == null ||
          (event.guests != null && !selectedGuests.equals(event.guests!));
      if (guestsChanged) {
        final Event newEventInfo = event.copyWith(guests: selectedGuests);
        read(eventsNotifierProvider).updateEvent(newEventInfo);
      }
    }
  }

  Future<void> alertListTilePressed() async {}
}
