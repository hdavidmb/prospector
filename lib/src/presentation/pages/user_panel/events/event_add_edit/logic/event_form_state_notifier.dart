import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../helpers/form_validators.dart';
import 'event_form_state.dart';

class EventFormStateNotifier extends StateNotifier<EventFormState>
    with FormValidators {
  final Reader read;
  EventFormStateNotifier({
    required this.read,
  }) : super(EventFormState.initial());

  void reset() => state = EventFormState.initial();
}
