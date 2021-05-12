import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_state.dart';
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
        //TODO show snackbar depending on state failure or success
      },
      child: Consumer(builder: (context, watch, child) {
        final ContactFormState formState = watch(contactFormProvider);
        final bool showErrorMessages = formState.showErrorMessages;
        return Form(
          autovalidateMode: showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20.0),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // * Name textfield
                        TextFormField(
                          initialValue: editingContact?.name,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            hintText:
                                AppLocalizations.of(context)!.nameRequired,
                          ),
                          textInputAction: TextInputAction.next,
                          onChanged: context
                              .read(contactFormProvider.notifier)
                              .nameChanged,
                          validator: (value) {
                            final bool isValid = context
                                .read(contactFormProvider.notifier)
                                .validateFieldIsNotEmpty(value!);
                            return isValid
                                ? null
                                : AppLocalizations.of(context)!
                                    .nameMustNotBeEmpty;
                          },
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

              ElevatedButton(
                onPressed: () {
                  debugPrint(formState.toString());
                  debugPrint(editingContact.toString());
                },
                child: Text('PRINT'), //TODO change to localized save
              ),
            ],
          ),
        );
      }),
    );
  }
}
