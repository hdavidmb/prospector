import 'package:flutter/material.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/widgets/calendar_widget.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/widgets/day_events_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../generated/l10n.dart';
import '../logic/events_view_providers.dart';

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
