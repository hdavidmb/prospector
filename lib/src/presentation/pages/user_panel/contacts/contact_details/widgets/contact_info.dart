import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../features/app_default_data/application/app_default_data_providers.dart';
import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../contact_add_edit/widgets/contact_image.dart';
import 'contact_tags_wrap.dart';

class ContactInfo extends StatelessWidget {
  final Contact contact;
  const ContactInfo({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
      color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Hero(
                tag: contact.id,
                child: ContactImage(size: 90.0, contactPhoto: contact.photo)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contact.name,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      getStatusText(context: context, statusID: contact.status),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  if (contact.location != null && contact.location!.isNotEmpty)
                    Text(contact.location ?? '',
                        style: const TextStyle(fontSize: 15.0)),
                  if (contact.phone != null && contact.phone!.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_in_talk_rounded,
                          size: 15.0,
                        ),
                        if (contact.whatsapp == contact.phone) ...[
                          const SizedBox(width: 2.0),
                          const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 15.0,
                          ),
                        ],
                        const SizedBox(width: 4.0),
                        Text(
                          contact.phone!,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  if (contact.whatsapp != null &&
                      contact.whatsapp!.isNotEmpty &&
                      contact.whatsapp != contact.phone)
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          size: 15.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          contact.whatsapp!,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  if ((contact.phone == null || contact.phone == '') &&
                      (contact.whatsapp == null || contact.whatsapp == '') &&
                      contact.phones != null &&
                      contact.phones!.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          contact.phones![0],
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  if (contact.gender != null && contact.gender!.isNotEmpty)
                    Text(
                      contact.gender == 'male'
                          ? AppLocalizations.of(context).male
                          : AppLocalizations.of(context).female,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  if (contact.tags != null && contact.tags!.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    ContactTagsWrap(tags: contact.tags!),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getStatusText(
      {required BuildContext context, required String statusID}) {
    return context
        .read(appDefaultDataProvider)
        .getStatusText(statusID: statusID, gender: contact.gender ?? '');
  }
}
