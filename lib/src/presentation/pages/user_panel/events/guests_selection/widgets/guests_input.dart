import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../generated/l10n.dart';

import '../../../../../../features/contacts/application/contacts_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../contacts/contact_add_edit/widgets/contact_image.dart';
import '../../../contacts/contacts_list/widgets/contact_tile.dart';

class GuestsInput extends StatelessWidget {
  final List selectedGuests;
  final bool autoFocus;
  final Function(String guest) onSelect;
  final Function(String guest) onDelete;
  const GuestsInput({
    Key? key,
    required this.selectedGuests,
    this.autoFocus = false,
    required this.onSelect,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        ChipsInput(
          decoration:
              InputDecoration(hintText: AppLocalizations.of(context).search),
          autofocus: autoFocus,
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
                    backgroundColor: isDarkTheme ? Colors.white24 : null,
                    avatar: ContactImage(
                      size: 30.0,
                      contactPhoto: contact.photo,
                    ),
                    onDeleted: () {
                      state.deleteChip(contact);
                      onDelete(contact.id);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                .searchContactsByName(query: query);
            return filteredContacts;
          },
          onChanged: (data) {},
        ),
      ],
    );
  }
}
