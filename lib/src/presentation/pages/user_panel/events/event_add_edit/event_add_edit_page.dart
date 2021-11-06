import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/events/domain/entites/event_entity.dart';
import 'logic/event_form_providers.dart';
import 'widgets/event_form.dart';

class EventAddEditPage extends StatelessWidget {
  final Event? editingEvent;
  const EventAddEditPage({
    Key? key,
    this.editingEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: try this on contactAddEditPage to avoid setting the editing state before navigating
    if (editingEvent != null) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => context
            .read(eventFormProvider.notifier)
            .setEditingState(editingEvent: editingEvent!),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        // TODO test
        context.read(eventFormProvider.notifier).reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(editingEvent != null
              ? AppLocalizations.of(context).editEvent
              : AppLocalizations.of(context).newEvent),
        ),
        body: EventForm(
          editingEvent: editingEvent,
        ),
      ),
    );
  }
}
