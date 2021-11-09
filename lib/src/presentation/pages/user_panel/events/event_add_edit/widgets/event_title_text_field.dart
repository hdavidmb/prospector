import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../helpers/form_validators.dart';

// TODO: USE REQUIRED TEXTFIELD AND DELETE THIS WIDGET
class EventTitleTextField extends StatelessWidget with FormValidators {
  final String? title;
  final void Function(String) onTitleChanged;
  const EventTitleTextField({
    Key? key,
    this.title,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: title,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        hintText: AppLocalizations.of(context).titleRequired,
      ),
      textInputAction: TextInputAction.next,
      onChanged: onTitleChanged,
      validator: (value) {
        final bool isValid = value != null && validateFieldIsNotEmpty(value);
        return isValid ? null : AppLocalizations.of(context).titleIsRequired;
      },
    );
  }
}
