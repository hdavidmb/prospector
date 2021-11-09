import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';
import '../../../../../core/dialogs.dart';
import '../../../contacts/contact_add_edit/widgets/location_text_field.dart';
import '../../widgets/event_alert_list_tile.dart';
import '../../widgets/event_guests_list_tile.dart';
import '../logic/event_form_providers.dart';
import '../logic/event_form_state.dart';
import '../logic/event_form_state_notifier.dart';
import 'event_date_list_tile.dart';
import 'event_title_text_field.dart';

class EventForm extends StatelessWidget {
  final Event? editingEvent;
  const EventForm({
    Key? key,
    required this.editingEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(height: 0.0, indent: 10.0, endIndent: 10.0);
    const double horizontalPadding = 10.0;
    final bool isEditing = editingEvent != null;

    return ProviderListener<EventFormState>(
      provider: eventFormProvider,
      onChange: (context, state) {
        state.failureOrSuccesOption.fold(
          () => null,
          (result) => result.fold(
            (failure) => showFailureSnackbar(context, failure),
            (_) {
              if (isEditing && state.deleted) {
                //To ensure dialog is fully closed
                Future.delayed(Duration.zero, () {
                  AutoRouter.of(context).popUntilRoot();
                });
              } else {
                AutoRouter.of(context).pop();
              }
              Future.delayed(const Duration(milliseconds: 300),
                  () => context.read(eventFormProvider.notifier).reset());
            },
          ),
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final EventFormState formState = watch(eventFormProvider);
          final EventFormStateNotifier notifier =
              context.read(eventFormProvider.notifier);
          final bool showErrorMessages = formState.showErrorMessages;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              autovalidateMode: showErrorMessages
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 6.0),

                  // * Event/Reminder selector
                  if (!isEditing)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: horizontalPadding),
                      child: CupertinoSlidingSegmentedControl<bool>(
                        groupValue: formState.isEvent,
                        children: {
                          true: Text(AppLocalizations.of(context).event),
                          false: Text(AppLocalizations.of(context).reminder)
                        },
                        onValueChanged: notifier.setIsEvent,
                      ),
                    ),

                  // * Title TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: horizontalPadding),
                    // TODO: Use required textfield
                    child: EventTitleTextField(
                      title: editingEvent?.title,
                      onTitleChanged: notifier.titleChanged,
                    ),
                  ),

                  // * Location TextField
                  if (formState.isEvent)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: horizontalPadding),
                      child: LocationTextField(
                        isForEvents: true,
                        location: formState.location,
                        onLocationChanged: context
                            .read(eventFormProvider.notifier)
                            .locationChanged,
                      ),
                    ),
                  const SizedBox(height: 12.0),
                  divider,

                  // * AllDay switch
                  SwitchListTile.adaptive(
                    value: formState.allDay,
                    onChanged: notifier.allDayChanged,
                    title: Text(AppLocalizations.of(context).allDay),
                  ),

                  // * StartDate ListTile
                  EventDateListTile(
                    title: formState.allDay || !formState.isEvent
                        ? AppLocalizations.of(context).when
                        : AppLocalizations.of(context).start,
                    date: formState.startDate,
                    onDateSelected: notifier.startDateChanged,
                  ),

                  // * EndDate ListTile
                  if (!formState.allDay && formState.isEvent)
                    EventDateListTile(
                      title: AppLocalizations.of(context).end,
                      firstDate: formState.startDate,
                      date: formState.endDate,
                      onDateSelected: notifier.endDateChanged,
                    ),
                  divider,

                  // * Guests ListTile
                  if (formState.isEvent) ...[
                    EventGuestsListTile(
                      guests: formState.guests,
                      onSelectGuests: notifier.guestsChanged,
                    ),
                    divider,
                  ],

                  // * Alert ListTile
                  EventAlertListTile(
                    eventAlert: formState.notification,
                    onSelectAlert: notifier.notificationChanged,
                  ),
                  divider,

                  // * Save button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: formState.isSubmitting
                          ? null
                          : () => context
                              .read(eventFormProvider.notifier)
                              .saveButtonPressed(editingEvent: editingEvent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context).save),
                          if (formState.isSubmitting)
                            const CircularProgressIndicator.adaptive(),
                        ],
                      ),
                    ),
                  ),

                  // * Delete button
                  if (isEditing) ...[
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: (formState.isSubmitting)
                          ? null
                          : () async {
                              final confirm = await showConfirmDialog(
                                context: context,
                                title: AppLocalizations
                                    .current.areYouSureDeleteEvent,
                                message: AppLocalizations
                                    .current.thisAcctionCannotBeUndone,
                              );
                              if (confirm) {
                                Future.delayed(
                                    Duration.zero,
                                    () => context
                                        .read(eventFormProvider.notifier)
                                        .deleteButtonPressed(
                                            eventID: editingEvent!.id));
                              }
                            },
                      child: Text(AppLocalizations.of(context).deleteEvent,
                          style: const TextStyle(color: Colors.red)),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
