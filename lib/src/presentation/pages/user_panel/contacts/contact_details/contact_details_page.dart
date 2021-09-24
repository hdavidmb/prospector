import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../routes/app_router.gr.dart';
import '../contact_add_edit/logic/contact_form_provider.dart';
import '../contact_add_edit/widgets/contact_image.dart';
import 'widgets/action_buttons.dart';
import 'widgets/contact_info.dart';
import 'widgets/interaction_text_field.dart';

class ContactDetailsPage extends ConsumerWidget {
  final String? contactID;
  const ContactDetailsPage({
    Key? key,
    required this.contactID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final contact = watch(contactsNotifierProvider)
        .contacts
        .firstWhere((c) => contactID == c.id, orElse: () => Contact.empty());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: !_isKeyboardHidden(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContactImage(
                      size: 33.0,
                      contactPhoto: contact.photo,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        contact.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : Text(AppLocalizations.of(context)!.prospectDetails),
          actions: [
            TextButton(
              onPressed: () {
                context
                    .read(contactFormProvider.notifier)
                    .setEditingState(editingContact: contact);
                AutoRouter.of(context)
                    .push(ContactAddEditRoute(editingContact: contact));
              },
              child: Text(
                AppLocalizations.of(context)!.edit,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                if (_isKeyboardHidden(context)) ContactInfo(contact: contact),
                ActionButtons(contact: contact),
                const Divider(height: 0.0, thickness: 2.0),
                const Expanded(
                  child: Center(
                    child: Text('Interactions list'),
                  ),
                ), //TODO implement interactions
                InteractionTextField()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //TODO use KeyboardVisibilityBuilder instead
  bool _isKeyboardHidden(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0.0;
  }
}
