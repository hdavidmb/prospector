import 'package:flutter/material.dart';

import 'package:prospector/src/features/import_contacts/domain/entity/imported_contact_entity.dart';

class ImportedContactTile extends StatelessWidget {
  final ImportedContact contact;
  final Widget? trailing;
  //TODO implement on tap action
  const ImportedContactTile({
    Key? key,
    required this.contact,
    this.trailing,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //TODO implement contact image on leading
      title: Text(contact.name),
      subtitle: contact.phones != null && contact.phones!.isNotEmpty
          ? Text(contact.phones![0])
          : null,
          trailing: trailing,
    );
  }
}
