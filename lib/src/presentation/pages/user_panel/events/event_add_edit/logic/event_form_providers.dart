import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'event_form_state.dart';
import 'event_form_state_notifier.dart';

final eventFormProvider =
    StateNotifierProvider<EventFormStateNotifier, EventFormState>((ref) {
  return EventFormStateNotifier(read: ref.read);
});
