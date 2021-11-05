import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../helpers/form_validators.dart';

class EventTitleTextField extends StatefulWidget {
  //TODO: try optional title, stateless textfield and initial value for when title is not null
  final String title;
  final void Function(String) onTitleChanged;
  const EventTitleTextField({
    Key? key,
    required this.title,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  _EventTitleTextFieldState createState() => _EventTitleTextFieldState();
}

class _EventTitleTextFieldState extends State<EventTitleTextField>
    with FormValidators {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _controller.clear());
    }
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        hintText: AppLocalizations.of(context).titleRequired,
      ),
      textInputAction: TextInputAction.next,
      onChanged: widget.onTitleChanged,
      validator: (value) {
        //TODO: mix other textfields with fromValidators
        final bool isValid = value != null && validateFieldIsNotEmpty(value);
        return isValid ? null : AppLocalizations.of(context).titleIsRequired;
      },
    );
  }
}
