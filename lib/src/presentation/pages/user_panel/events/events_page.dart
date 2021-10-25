import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/events/application/events_providers.dart';
import 'package:prospector/src/features/events/domain/entity/event_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/widgets/events_calendar_view.dart';

import 'widgets/events_app_bar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EventsAppBar(),
      body: EventsCalendarView(),
    );
  }
}
