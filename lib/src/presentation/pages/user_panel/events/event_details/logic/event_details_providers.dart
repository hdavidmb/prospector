import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'event_details_page_notifier.dart';

final eventDetailsPageProvider = Provider<EventDetailsPageNotifier>((ref) {
  return EventDetailsPageNotifier(read: ref.read);
});
