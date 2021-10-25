import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/logic/events_page_notifier.dart';

final eventsPageProvider = ChangeNotifierProvider<EventsPageNotifier>((ref) {
  return EventsPageNotifier();
});
