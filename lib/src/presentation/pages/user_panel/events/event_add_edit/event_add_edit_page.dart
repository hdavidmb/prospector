import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/user_panel/events/events_view/logic/events_view_providers.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/events/domain/entites/event_entity.dart';
import 'logic/event_form_providers.dart';
import 'widgets/event_form.dart';

class EventAddEditPage extends StatefulWidget {
  final Event? editingEvent;
  const EventAddEditPage({
    Key? key,
    this.editingEvent,
  }) : super(key: key);

  @override
  _EventAddEditPageState createState() => _EventAddEditPageState();
}

class _EventAddEditPageState extends State<EventAddEditPage> {
  @override
  void initState() {
    super.initState();
    //TODO: try this on contactAddEditPage to avoid setting the editing state before navigating
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        if (widget.editingEvent != null) {
          context
              .read(eventFormProvider.notifier)
              .setEditingState(editingEvent: widget.editingEvent!);
        } else {
          final DateTime selectedDay =
              context.read(eventsViewProvider).selectedDay;
          context
              .read(eventFormProvider.notifier)
              .setInitialDates(selectedDay: selectedDay);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //TODO check if this can go on the dispose method
        context.read(eventFormProvider.notifier).reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.editingEvent != null
              ? AppLocalizations.of(context).editEvent
              : AppLocalizations.of(context).newEvent),
        ),
        body: EventForm(
          editingEvent: widget.editingEvent,
        ),
      ),
    );
  }
}
