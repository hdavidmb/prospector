import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prospector/src/core/private/private_keys.dart';
import 'package:prospector/src/presentation/core/dialogs.dart';

class LocationTextField extends StatefulWidget {
  final String location;
  final void Function(String) onLocationChanged;
  const LocationTextField({
    Key? key,
    required this.location,
    required this.onLocationChanged,
  }) : super(key: key);

  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  late TextEditingController _controller;
  final kGoogleApiKey = PrivateKeys.getGooglePlacesApiKey();
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
    final Locale myLocale = Localizations.localeOf(context);
    if (widget.location.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _controller.clear());
    }
    return TextFormField(
      readOnly: true,
      controller: _controller,
      focusNode: _textFieldFocusNode,
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
        hintText: AppLocalizations.of(context)!.city,
      ),
      textInputAction: TextInputAction.next,
      onTap: () async {
        if (_textFieldFocusNode.canRequestFocus) {
          try {
            final String? p = await showPlacesDialog(context);
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
