import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/events/domain/entites/event_entity.dart';
import 'logic/event_form_providers.dart';
import 'widgets/event_form.dart';

class EventAddEditPage extends StatelessWidget {
  /// Pass the event to be edited
  ///
  /// ** If editingEvent is set. You must first call setEditingState on eventFormProvider**
  final Event? editingEvent;

  /// ## Page to add or edit events
  ///
  /// **WARNING** If editingEvent is set. You must call setEditingState on eventFormProvider before Navigating to this page
  ///
  const EventAddEditPage({
    Key? key,
    this.editingEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: const EventForm(),
      ),
    );
  }
}
