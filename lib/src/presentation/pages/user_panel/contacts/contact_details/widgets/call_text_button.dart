import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../features/contacts/domain/entity/contact_entity.dart';
import '../logic/contact_details_provider.dart';

class CallTextButton extends StatelessWidget {
  final Contact contact;
  final bool isTexting;
  const CallTextButton({
    Key? key,
    required this.contact,
    this.isTexting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle),
      child: IconButton(
        icon: isTexting
            ? const FaIcon(FontAwesomeIcons.whatsapp)
            : const Icon(Icons.phone),
        onPressed: () => context
            .read(contactDetailsProvider)
            .callTextButtonPressed(
                context: context, contact: contact, isTexting: isTexting),
      ),
    );
  }
}
