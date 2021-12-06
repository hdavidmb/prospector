import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/shared_prefs/shared_prefs_provider.dart';
import 'events_view_notifier.dart';

final eventsViewProvider = ChangeNotifierProvider<EventsViewNotifier>((ref) {
  final _prefs = ref.watch(userSharedPrefsProvider);
  return EventsViewNotifier(prefs: _prefs);
});
