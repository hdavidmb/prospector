import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/contacts/domain/entity/contact_entity.dart';
import 'package:prospector/src/presentation/pages/user_panel/contacts/contact_details/logic/contact_details_provider.dart';

class PhoneButton extends StatelessWidget {
  final Contact contact;
  const PhoneButton({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.phone),
        onPressed: () => context
            .read(contactDetailsProvider)
            .phoneButtonPressed(context: context, contact: contact),
      ),
    );
  }
}
