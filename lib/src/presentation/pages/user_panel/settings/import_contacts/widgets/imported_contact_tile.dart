import 'package:flutter/material.dart';

import '../../../../../../features/import_contacts/domain/entity/imported_contact_entity.dart';

class ImportedContactTile extends StatelessWidget {
  final ImportedContact contact;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  const ImportedContactTile({
    Key? key,
    required this.contact,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage =
        const AssetImage('assets/images/defaultContactImage.jpg');
    if (contact.photo != null) backgroundImage = MemoryImage(contact.photo!);
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.phones != null && contact.phones!.isNotEmpty
          ? contact.phones![0]
          : ''),
      leading: leading ??
          CircleAvatar(
            radius: 30.0,
            backgroundImage: backgroundImage,
          ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
