import 'package:flutter/material.dart';
import '../../../../../../../generated/l10n.dart';

class InteractionTextField extends StatefulWidget {
  final Contact contact;
  const InteractionTextField({
    Key? key,
    required this.contact,
  }) : super(key: key);
  @override
  _InteractionTextFieldState createState() => _InteractionTextFieldState();
}

class _InteractionTextFieldState extends State<InteractionTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  String _textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 6.0, 6.0, 6.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).typeAnInteraction,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                setState(() => _textFieldValue = value);
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Consumer(builder: (context, watch, child) {
            return IconButton(
              icon: const Icon(Icons.send),
              iconSize: 28.0,
              onPressed: () async {
                if (_textFieldValue.isNotEmpty) {
                  final bool success = await context
                      .read(contactDetailsProvider)
                      .interactionSubmitButtonPressed(
                          description: _textFieldValue,
                          contactID: widget.contact.id);
                  if (success) {
                    _textFieldValue = '';
                    _textEditingController.clear();
                  } else {
                    //TODO show snackbar if error
                  }
                }
              },
            );
          }),
          KeyboardVisibility(
            keyboardHiddenChild: Row(
              children: [
                PhoneButton(phone: widget.contact.phone),
                WhatsappButton(
                  whatsapp: widget.contact.whatsapp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
