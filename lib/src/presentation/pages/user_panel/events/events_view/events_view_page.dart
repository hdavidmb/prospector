import 'package:flutter/material.dart';

import 'widgets/events_app_bar.dart';
import 'widgets/events_calendar_view.dart';

class EventsViewPage extends StatelessWidget {
  const EventsViewPage({
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
