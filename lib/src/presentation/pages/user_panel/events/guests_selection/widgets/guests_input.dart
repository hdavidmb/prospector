import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:prospector/src/features/contacts/application/contacts_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_add_edit/widgets/contact_image.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contacts_list/widgets/contact_tile.dart';

class GuestsInput extends StatelessWidget {
  final List selectedGuests;
  final Function(String guest) onSelect;
  final Function(String guest) onDelete;
  const GuestsInput({
    Key? key,
    required this.selectedGuests,
    required this.onSelect,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsInput(
      initialValue: context
          .read(contactsNotifierProvider)
          .contacts
          .where((listContact) => selectedGuests.contains(listContact.id))
          .toList(),
      chipBuilder: (context, state, contact) {
        return contact is Contact
            ? InputChip(
                key: ObjectKey(contact.id),
                label: Text(contact.name),
                avatar: ContactImage(
                  size: 30.0,
                  contactPhoto: contact.photo,
                ),
                onDeleted: () {
                  state.deleteChip(contact);
                  onSelect(contact.id);
                },
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, //TODO test
              )
            : const SizedBox();
      },
      suggestionBuilder: (context, state, contact) {
        return contact is Contact
            ? ContactTile(
                contact: contact,
                onTap: () {
                  state.selectSuggestion(contact);
                  onSelect(contact.id);
                },
              )
            : const SizedBox();
      },
      findSuggestions: (query) {
        final filteredContacts = context
            .read(contactsNotifierProvider)
            .contacts
            .where(
              (listContact) =>
                  query.isNotEmpty &&
                  listContact.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        return filteredContacts;
      },
      onChanged: (data) {},
    );
  }
}
