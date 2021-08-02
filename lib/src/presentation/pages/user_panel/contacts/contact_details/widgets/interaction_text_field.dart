import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InteractionTextField extends StatefulWidget {
  @override
  _InteractionTextFieldState createState() => _InteractionTextFieldState();
}

class _InteractionTextFieldState extends State<InteractionTextField> {
  final _textEditingController = TextEditingController();

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
                hintText: AppLocalizations.of(context)!.typeAnInteraction,
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
                //TODO implement
              },
              onSubmitted: (value) {
                //TODO implement
              },
            ),
          ),
          /* TODO implement call and whatsapp buttons
          this._isKeyboardHidden(context)
                        ? Row(children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                                child: IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: callProspect)),
                            Container(
                                margin: EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                                child: IconButton(
                                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                                    onPressed: whatsappProspect))
                          ])
                        :  */
          const SizedBox(width: 10.0),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 28.0,
            onPressed: () async {
              //TODO implement
            },
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

  //TODO use KeyboardVisibilityBuilder instead
  bool _isKeyboardHidden(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0.0;
  }
}
