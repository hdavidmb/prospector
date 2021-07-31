import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/contacts/domain/entity/contact_entity.dart';
import 'logic/contact_form_provider.dart';
import 'widgets/contact_form.dart';

class ContactAddEditPage extends ConsumerWidget {
  /// Pass the contact to be edited
  /// 
  /// **If editingContact is set. You must first call setEditingState on contactFormProvider**
  final Contact? editingContact;
  /// ## Page to add or edit contacts
  /// 
  /// **WARNING** If editingContact is set. You must call setEditingState on contactFormProvider before Navigating to this page
  const ContactAddEditPage({
    Key? key,
    this.editingContact,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return WillPopScope(
      onWillPop: () async {
        context.read(contactFormProvider.notifier).reset();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(editingContact != null ? AppLocalizations.of(context)!.editProspect : AppLocalizations.of(context)!.newProspect),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ContactForm(editingContact: editingContact),
        ),
      ),
    );
  }
}
