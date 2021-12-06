import 'package:flutter/material.dart';

import '../../../helpers/form_validators.dart';

class RequiredTextField extends StatelessWidget with FormValidators {
  final String? initialValue;
  final String hintText;
  final String errorMessage;
  final void Function(String) onChanged;

  const RequiredTextField({
    Key? key,
    this.initialValue,
    required this.hintText,
    required this.errorMessage,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        hintText: hintText,
      ),
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      validator: (value) {
        final bool isValid = value != null && validateFieldIsNotEmpty(value);
        return isValid ? null : errorMessage;
      },
    );
  }
}
