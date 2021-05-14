import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_image.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_name_text_field.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/gender_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/location_text_field.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/phones_text_fields.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/status_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/tags_selection_wrap/tags_selection_wrap.dart';

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
              if (editingContact == null) {
                //Show success snackbar
                FocusScope.of(context).unfocus();
                showSnackBar(
                    context: context,
                    message:
                        AppLocalizations.of(context)!.prospectSavedSuccessfully,
                    type: SnackbarType.success);
                //Reset form state
                context.read(contactFormProvider.notifier).reset();
              } else {
                // Pop view
                if (state.deleted) {
                  Navigator.of(context).popUntil((route) => route
                      .isFirst); //TODO test when contactDetails page is implemented
                } else {
                  Navigator.of(context).pop();
                }
                Future.delayed(const Duration(milliseconds: 300), () => 
                context.read(contactFormProvider.notifier).reset());
              }
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
                                  Text(AppLocalizations.of(context)!.editImage),
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
                          ContactNameTextField(
                            name: formState.name,
                            onNameChanged: context
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
                  phonesList: formState.phones,
                  phone: formState.phone,
                  whatsapp: formState.whatsapp,
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

                // * Optional tatus dropdown
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
                      Text(AppLocalizations.of(context)!.save),
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
                        : () => context
                            .read(contactFormProvider.notifier)
                            .deleteContact(
                                context: context,
                                contactID: editingContact!.id),
                    child: Text(AppLocalizations.of(context)!.deleteProspect,
                        style: const TextStyle(color: Colors.red)),
                  ),
                ]
              ],
            ),
          ),
        );
      }),
    );
  }
}
