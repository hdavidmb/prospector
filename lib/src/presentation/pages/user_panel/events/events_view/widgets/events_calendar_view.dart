import 'package:flutter/material.dart';

import 'calendar_widget.dart';
import 'day_events_list.dart';

class EventsCalendarView extends StatelessWidget {
  const EventsCalendarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CalendarWidget(),
        Divider(height: 0.0, thickness: 1.0),
        Expanded(child: DayEventsList()),
      ],
    );
  }
}
