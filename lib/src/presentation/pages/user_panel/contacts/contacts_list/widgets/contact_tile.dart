import 'package:flutter/material.dart';

import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../../../../../helpers/date_formatters.dart';
import '../../contact_add_edit/widgets/contact_image.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final bool redName;
  final void Function() onTap;
  const ContactTile({
    Key? key,
    required this.contact,
    this.redName = false,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Hero(
                tag: contact.id,
                child: ContactImage(size: 60.0, contactPhoto: contact.photo)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contact.name,
                      style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: redName ? Colors.red : null),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (contact.location != null &&
                        contact.location!.isNotEmpty)
                      Text(
                        contact.location!,
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w300),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      getTimeagoFormatedDate(context, contact.modified),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
