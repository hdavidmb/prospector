import 'package:flutter/material.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../core/dialogs.dart';

class LocationTextField extends StatefulWidget {
  final String location;
  final void Function(String) onLocationChanged;
  final bool isForEvents;
  const LocationTextField({
    Key? key,
    required this.location,
    required this.onLocationChanged,
    this.isForEvents = false,
  }) : super(key: key);

  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  late TextEditingController _controller;
  final _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.location);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.location.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _controller.clear());
    }
    return TextFormField(
      readOnly: true,
      controller: _controller,
      focusNode: _textFieldFocusNode,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_on),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  // Unfocus all focus nodes
                  _textFieldFocusNode.unfocus();
                  // Disable text field's focus node request
                  _textFieldFocusNode.canRequestFocus = false;

                  _controller.clear();
                  widget.onLocationChanged('');

                  //Enable the text field's focus node request after some delay
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _textFieldFocusNode.canRequestFocus = true;
                  });
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        hintText: widget.isForEvents
            ? AppLocalizations.of(context).location
            : AppLocalizations.of(context).city,
      ),
      onTap: () async {
        if (_textFieldFocusNode.canRequestFocus) {
          try {
            final String? p = widget.isForEvents
                ? await showCustomPlacesDialog(context)
                : await showPlacesDialog(context);
            if (p != null && p != '') {
              _controller.text = p;
              widget.onLocationChanged(p);
            }
          } catch (e) {
            debugPrint(e.toString());
            return;
          }
        }
      },
    );
  }
}
