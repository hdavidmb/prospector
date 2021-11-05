import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/events/domain/entites/event_entity.dart';
import '../../../../../core/dialogs.dart';
import '../logic/event_form_providers.dart';
import '../logic/event_form_state.dart';
import 'event_title_text_field.dart';

class EventForm extends StatelessWidget {
  final Event? editingEvent;
  const EventForm({
    Key? key,
    this.editingEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  if (!isEditing)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: horizontalPadding),
                      child: CupertinoSlidingSegmentedControl<bool>(
                        groupValue: formState.isEvent,
                        children: {
                          true: Text(AppLocalizations.of(context).event),
                          false: Text(AppLocalizations.of(context).reminder)
                        },
                        onValueChanged:
                            context.read(eventFormProvider.notifier).setIsEvent,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding),
                    child: EventTitleTextField(
                      title: formState.title,
                      onTitleChanged:
                          context.read(eventFormProvider.notifier).titleChanged,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
