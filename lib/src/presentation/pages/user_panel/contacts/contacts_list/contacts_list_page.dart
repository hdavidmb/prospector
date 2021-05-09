import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';

class ContactsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.prospects),
      ),
      body: Consumer(builder: (context, watch, child) {
        final contacts = watch(contactsNotifierProvider).contacts;
        return ListView.separated(
          itemBuilder: (context, index) => ListTile(title: Text(contacts[index].name)),
          separatorBuilder: (context, index) => const Divider(height: 0.0),
          itemCount: contacts.length,
        );
      }),
    );
  }
}
