import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'events_view_notifier.dart';

final eventsViewProvider = ChangeNotifierProvider<EventsViewNotifier>((ref) {
  return EventsViewNotifier();
});
