import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../helpers/form_validators.dart';

//TODO: DELETE THIS WIDGET
class ContactNameTextField extends StatelessWidget with FormValidators {
  final String? name;
  final void Function(String) onNameChanged;
  const ContactNameTextField({
    Key? key,
    required this.name,
    required this.onNameChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: name,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        hintText: AppLocalizations.of(context).nameRequired,
      ),
      textInputAction: TextInputAction.next,
      onChanged: onNameChanged,
      validator: (value) {
        final bool isValid = value != null && validateFieldIsNotEmpty(value);
        return isValid ? null : AppLocalizations.of(context).nameMustNotBeEmpty;
      },
    );
  }
}
