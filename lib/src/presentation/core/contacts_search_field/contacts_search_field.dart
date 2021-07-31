import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactsSearchField extends StatelessWidget {
  final bool autofocus;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const ContactsSearchField({
    Key? key,
    this.autofocus = false,
    this.controller,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.search,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
