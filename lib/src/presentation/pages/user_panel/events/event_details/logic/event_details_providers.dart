import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/event_details/logic/event_details_page_notifier.dart';

final eventDetailsPageProvider = Provider<EventDetailsPageNotifier>((ref) {
  return EventDetailsPageNotifier(read: ref.read);
});
