import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';

import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/contact_add_edit_page.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/logic/contact_form_provider.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_image.dart';

class ContactDetailsPage extends ConsumerWidget {
  final String contactID;
  const ContactDetailsPage({
    Key? key,
    required this.contactID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final contact = watch(contactsNotifierProvider)
        .contacts
        .firstWhere((c) => contactID == c.id);
    return Scaffold(
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
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ContactAddEditPage(
                    editingContact: contact,
                  ),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.edit,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }

  bool _isKeyboardHidden(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0.0;
  }
}
