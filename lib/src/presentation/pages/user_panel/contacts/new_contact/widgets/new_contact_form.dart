import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/logic/new_contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/logic/new_contact_form_state.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/widgets/gender_dropdown.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/widgets/location_text_field.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/widgets/phones_text_fields.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/new_contact/widgets/status_dropdown.dart';

class NewContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<NewContactFormState>(
      provider: newContactFormProvider,
      onChange: (context, state) {
        //TODO show snackbar deppending on state failure or success
      },
      child: Consumer(builder: (context, watch, child) {
        final NewContactFormState formState = watch(newContactFormProvider);
        final bool showErrorMessages = formState.showErrorMessages;
        return Form(
          autovalidateMode: showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20.0),

              // * Name textfield
              TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_circle),
                  hintText: AppLocalizations.of(context)!.nameRequired,
                ),
                textInputAction: TextInputAction.next,
                onChanged:
                    context.read(newContactFormProvider.notifier).nameChanged,
                validator: (value) {
                  final bool isValid = context
                      .read(newContactFormProvider.notifier)
                      .validateFieldIsNotEmpty(value!);
                  return isValid
                      ? null
                      : AppLocalizations.of(context)!.nameMustNotBeEmpty;
                },
              ),
              const SizedBox(height: 10.0),

              // * Phones textfields
              PhonesTextFields(
                phonesList: formState.phones,
                phone: formState.phone,
                whatsapp: formState.whatsapp,
                onPhonesListChanged: (List<String> phones) => context
                    .read(newContactFormProvider.notifier)
                    .phonesListChanged(phones),
                onPhoneChanged: (String value) => context
                    .read(newContactFormProvider.notifier)
                    .phoneChanged(value),
                onWhatsappChanged: (String value) => context
                    .read(newContactFormProvider.notifier)
                    .whatsappChanged(value),
              ),
              const SizedBox(height: 10.0),

              // * Location textfield
              LocationTextField(
                location: formState.location,
                onLocationChanged: (String value) => context
                    .read(newContactFormProvider.notifier)
                    .locationChanged(value),
              ),
              const SizedBox(height: 10.0),

              // * Gender dropdown
              GenderDropdown(
                gender: formState.gender,
                onGenderChanged: (String value) => context
                    .read(newContactFormProvider.notifier)
                    .genderChanged(value),
              ),
              const SizedBox(height: 10.0),

              // * Status dropdown
              StatusDropDown(
                status: formState.status,
                gender: formState.gender,
                onStatusChanged: (String value) => context
                    .read(newContactFormProvider.notifier)
                    .statusChanged(value),
              ),
              const SizedBox(height: 10.0),

              ElevatedButton(
                onPressed: () {
                  debugPrint(formState.toString());
                },
                child: Text('PRINT'), //TODO change to localized save
              )
            ],
          ),
        );
      }),
    );
  }
}
