import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../helpers/form_validators.dart';

class ContactNameTextField extends StatefulWidget {
  final String name;
  final void Function(String) onNameChanged;
  const ContactNameTextField({
    Key? key,
    required this.name,
    required this.onNameChanged,
  }) : super(key: key);

  @override
  _ContactNameTextFieldState createState() => _ContactNameTextFieldState();
}

class _ContactNameTextFieldState extends State<ContactNameTextField>
    with FormValidators {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _controller.clear());
    }
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        hintText: AppLocalizations.of(context).nameRequired,
      ),
      textInputAction: TextInputAction.next,
      onChanged: widget.onNameChanged,
      validator: (value) {
        final bool isValid = value != null && validateFieldIsNotEmpty(value);
        return isValid ? null : AppLocalizations.of(context).nameMustNotBeEmpty;
      },
    );
  }
}
