import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../core/dialogs.dart';
import '../../../../../core/widgets/required_text_field/required_text_field.dart';
import '../logic/contact_form_provider.dart';
import '../logic/contact_form_state.dart';
import 'contact_image.dart';
import 'gender_dropdown.dart';
import 'location_text_field.dart';
import 'phones_text_fields.dart';
import 'status_dropdown.dart';
import 'tags_selection_wrap/tags_selection_wrap.dart';

class ContactForm extends StatelessWidget {
  final Contact? editingContact;
  const ContactForm({
    Key? key,
    this.editingContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEditing = editingContact != null;

    return ProviderListener<ContactFormState>(
      provider: contactFormProvider,
      onChange: (context, state) {
        state.failureOrSuccesOption.fold(
          () => null,
          (result) => result.fold(
            (failure) => showFailureSnackbar(context, failure),
            (_) {
              // Pop view
              if (editingContact != null && state.deleted) {
                //To ensure dialog is fully closed
                Future.delayed(Duration.zero, () {
                  AutoRouter.of(context).popUntilRoot();
                });
              } else {
                AutoRouter.of(context).pop();
              }
              Future.delayed(const Duration(milliseconds: 300),
                  () => context.read(contactFormProvider.notifier).reset());
            },
          ),
        );
      },
      child: Consumer(builder: (context, watch, child) {
        final ContactFormState formState = watch(contactFormProvider);
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
                const SizedBox(height: 20.0),

                Row(
                  children: [
                    if (editingContact != null) ...[
                      // * Contact image selector
                      GestureDetector(
                        onTap: () => context
                            .read(contactFormProvider.notifier)
                            .getContactImage(context),
                        child: Column(
                          children: [
                            ContactImage(
                              size: 80,
                              contactPhoto: editingContact?.photo,
                              pickedImage: formState.pickedImage,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              onPressed: () => context
                                  .read(contactFormProvider.notifier)
                                  .getContactImage(context),
                              child:
                                  Text(AppLocalizations.of(context).editImage),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                    Expanded(
                      child: Column(
                        children: [
                          // * Name textfield
                          RequiredTextField(
                            initialValue: editingContact?.name,
                            hintText: AppLocalizations.of(context).nameRequired,
                            errorMessage:
                                AppLocalizations.of(context).nameMustNotBeEmpty,
                            onChanged: context
                                .read(contactFormProvider.notifier)
                                .nameChanged,
                          ),
                          const SizedBox(height: 10.0),

                          // * Optional tatus dropdown
                          if (isEditing) ...[
                            StatusDropdown(
                              status: formState.status,
                              gender: formState.gender,
                              onStatusChanged: (String value) => context
                                  .read(contactFormProvider.notifier)
                                  .statusChanged(value),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                // * Phones textfields
                PhonesTextFields(
                  initialPhonesList: editingContact?.phones ?? [],
                  formPhone: formState.phone,
                  formWhatsapp: formState.whatsapp,
                  onPhonesListChanged: (List<String> phones) => context
                      .read(contactFormProvider.notifier)
                      .phonesListChanged(phones),
                  onPhoneChanged: (String value) => context
                      .read(contactFormProvider.notifier)
                      .phoneChanged(value),
                  onWhatsappChanged: (String value) => context
                      .read(contactFormProvider.notifier)
                      .whatsappChanged(value),
                ),
                const SizedBox(height: 10.0),

                // * Location textfield
                LocationTextField(
                  location: formState.location,
                  onLocationChanged: (String value) => context
                      .read(contactFormProvider.notifier)
                      .locationChanged(value),
                ),
                const SizedBox(height: 10.0),

                // * Gender dropdown
                GenderDropdown(
                  gender: formState.gender,
                  onGenderChanged: (String value) => context
                      .read(contactFormProvider.notifier)
                      .genderChanged(value),
                ),
                const SizedBox(height: 10.0),

                // * Optional status dropdown
                if (!isEditing) ...[
                  StatusDropdown(
                    status: formState.status,
                    gender: formState.gender,
                    onStatusChanged: (String value) => context
                        .read(contactFormProvider.notifier)
                        .statusChanged(value),
                  ),
                  const SizedBox(height: 10.0),
                ],

                // * Tags wrap
                TagsSelectionWrap(
                  selectedTags: formState.tags,
                  onTagsListChanged: (List<String> values) => context
                      .read(contactFormProvider.notifier)
                      .tagsListChanged(values),
                ),
                const SizedBox(height: 10.0),

                // * Save button
                ElevatedButton(
                  onPressed: (formState.isSubmitting)
                      ? null
                      : () => context
                          .read(contactFormProvider.notifier)
                          .savedButtonPressed(editingContact: editingContact),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context).save),
                      if (formState.isSubmitting)
                        const CircularProgressIndicator.adaptive(),
                    ],
                  ),
                ),

                if (editingContact != null) ...[
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: (formState.isSubmitting)
                        ? null
                        : () {
                            context
                                .read(contactFormProvider.notifier)
                                .deleteContact(
                                    context: context,
                                    contactID: editingContact!.id);
                          },
                    child: Text(AppLocalizations.of(context).deleteProspect,
                        style: const TextStyle(color: Colors.red)),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
